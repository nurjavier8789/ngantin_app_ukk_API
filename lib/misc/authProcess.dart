import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../api.dart';
import '../loggedIn/siswa/overlay.dart';
import '../loggedIn/getProfile.dart';

class auth {
  login(String username, String password, context) async {
    final prefs = await SharedPreferences.getInstance();
    api Api = new api();
    Get get = new Get();

    int makerID = Api.makerID;

    var headers = {"makerID": "$makerID"};

    var result = await http.post(Uri.parse(Api.loginApi), body: {
      "username": username,
      "password": password
    }, headers: headers);

    Map<String, dynamic> resultData = jsonDecode(result.body);

    if (result.statusCode == 200) {
      if (resultData["user"]["role"].contains("siswa")) {
        prefs.setString("token", resultData["access_token"]);

        await get.profileSiswa();

        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => overlayHomeS()), (route) => false);
      } else if (resultData["user"]["role"].contains("admin_stan")) {
        print("Admin Stan!");
      }
    } else {
      print("Gagal Login");
    }
  }

  register() {}
}
