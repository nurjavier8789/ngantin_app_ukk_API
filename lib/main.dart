import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:yukan_app_ukk/misc/fonts.dart';

import 'loggedIn/siswa/overlay.dart';
import 'loggedIn/getProfile.dart';
import 'landingPage.dart';
import 'api.dart';

void main() {
  runApp(const bridge());
}

class bridge extends StatelessWidget {
  const bridge({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: mainApp(),
    );
  }
}


class mainApp extends StatefulWidget {
  const mainApp({super.key});

  @override
  State<mainApp> createState() => _mainAppState();
}

class _mainAppState extends State<mainApp> {

  tokenCheck() async {
    final prefs = await SharedPreferences.getInstance();
    Get get = new Get();
    api Api = new api();
    apiSiswa _apiSiswa = new apiSiswa();
    apiAdmin _apiAdmin = new apiAdmin();

    if (prefs.getString("token") == null) {
      await Future.delayed(Duration(seconds: 3));
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => landingPage()), (route) => false);
    } else {
      if (prefs.getString("roleSiswa") == null) {
        await Future.delayed(Duration(seconds: 3));
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => landingPage()), (route) => false);
      } else if (prefs.getString("roleSiswa")!.contains("siswa")) {
        var result = await http.get(Uri.parse(_apiSiswa.getProfile), headers: {
          "Authorization": "Bearer ${prefs.getString("token")}",
          "makerID": "${Api.makerID}",
        });

        Map<String, dynamic> resultData = jsonDecode(result.body);

        if (resultData["status"] == true) {
          await get.profileSiswa();
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => overlayHomeS()), (route) => false);
        } else if (resultData["status"] == false) {
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => landingPage()), (route) => false);
        }

      } else if (prefs.getString("roleSiswa")!.contains("admin_stan")) {
        var result = await http.get(Uri.parse(_apiAdmin.getProfile), headers: {
          "Authorization": "Bearer ${prefs.getString("token")}",
          "makerID": "${Api.makerID}",
        });

        Map<String, dynamic> resultData = jsonDecode(result.body);

        if (resultData["status"] == true) {
          print("admin udah masuk!");
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => landingPage()), (route) => false);
        } else if (resultData["status"] == false) {
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => landingPage()), (route) => false);
        }
      }
    }
  }

  @override
  void initState() {
    Intl.defaultLocale = 'id_ID';
    tokenCheck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ngantin!",
      home: Scaffold(
        body: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset("assets/appIcon.png"),
              ),
              Text("Ngantin!", style: fonts().googleSansBold(Colors.black, 32),),
              Text("Ayok Ngantin!", style: fonts().googleSansRegular(Colors.black, 24),),
            ],
          ),
        ),
      ),
    );
  }
}
