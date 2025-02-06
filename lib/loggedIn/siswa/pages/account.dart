import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:yukan_app_ukk/misc/styles.dart';

import '../../../landingPage.dart';
import '../../../misc/fonts.dart';
import '../../userData.dart';

class akun extends StatefulWidget {
  const akun({super.key});

  @override
  State<akun> createState() => _akunState();
}

class _akunState extends State<akun> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(28),
                child: Text("Akun", style: fonts().googleSansBold(Colors.black, 28)),
              ),
              Divider(height: 0),
              Container(
                margin: EdgeInsets.all(28),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      child: dataUser().getUrlFoto().isEmpty ? Image.asset("assets/noIcon.png", width: 100,) : Image.network(dataUser().getUrlFoto(), width: 100,),
                      borderRadius: BorderRadius.circular(911),
                    ),
                    SizedBox(width: 26),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${dataUser().getNama()}", style: fonts().googleSansCustom(Colors.black, 20, FontWeight.w600)),
                        Text("${dataUser().getUsername()}", style: fonts().googleSansCustom(Colors.black, 16, FontWeight.w100)),
                        SizedBox(height: 6),
                        Text("${dataUser().getNoTelp()}", style: fonts().googleSansCustom(Colors.black, 16, FontWeight.normal)),
                      ],
                    ),
                    Expanded(child: Container()),
                    Icon(Icons.settings, color: Colors.white),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 28, right: 28),
                child: ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.clear();

                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => landingPage()), (route) => false);
                  },
                  style: style().buttonCustom(Colors.red, Colors.white, 18, FontWeight.bold),
                  child: Text("Keluar"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

