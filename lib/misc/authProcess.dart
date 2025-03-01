import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'fonts.dart';
import '../api.dart';
import '../loginPage.dart';
import '../loggedIn/getProfile.dart';
import '../loggedIn/siswa/overlay.dart';

class auth {
  login(String username, String password, context) async {
    final prefs = await SharedPreferences.getInstance();
    api Api = new api();
    Get get = new Get();

    prefs.setString("username", username);
    prefs.setString("password", password);

    var headers = {"makerID": "${Api.makerID}"};

    var result = await http.post(Uri.parse(Api.loginApi), body: {
      "username": username,
      "password": password
    }, headers: headers);

    Map<String, dynamic> resultData = jsonDecode(result.body);

    if (result.statusCode == 200) {
      if (resultData["user"]["role"].contains("siswa")) {
        prefs.setString("token", resultData["access_token"]);
        prefs.setString("roleSiswa", resultData["user"]["role"]);

        await get.profileSiswa();

        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => overlayHomeS()), (route) => false);
      } else if (resultData["user"]["role"].contains("admin_stan")) {
        prefs.setString("token", resultData["access_token"]);
        print("Admin Stan!");
      }
    } else if (result.statusCode == 401 || resultData["message"].contains("incorrect")) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Hmm... Sepertinya username atau password anda salah!", style: fonts().googleSansRegular(Colors.white, 16), softWrap: true),
              Text("Silahkan cek kembali dan coba lagi!", style: fonts().googleSansRegular(Colors.white, 16), softWrap: true),
            ],
          ),
          backgroundColor: Colors.redAccent,
          showCloseIcon: true,
          duration: Duration(seconds: 20),
        ),
      );
    } else {
      print(resultData);
      print("Gagal Login");
    }
  }

  refreshTokenLogin() async {
    final prefs = await SharedPreferences.getInstance();
    api Api = new api();
    Get get = new Get();

    var headers = {"makerID": "${Api.makerID}"};

    var result = await http.post(Uri.parse(Api.loginApi), body: {
      "username": prefs.get("username"),
      "password": prefs.get("password")
    }, headers: headers);

    Map<String, dynamic> resultData = jsonDecode(result.body);

    if (result.statusCode == 200) {
      if (resultData["user"]["role"].contains("siswa")) {
        prefs.setString("token", resultData["access_token"]);

        await get.profileSiswa();
      } else if (resultData["user"]["role"].contains("admin_stan")) {
        print("Admin Stan!");
      }
    } else {
      print("Gagal Login");
    }
  }

  registerSiswa(String nama_siswa, String alamat, String telp, String username, String password, String filePath, BuildContext context) async {
    api Api = new api();

    var headers = {"makerID": "${Api.makerID}"};

    var request = http.MultipartRequest("POST", Uri.parse(Api.registerApiSiswa));

    request.headers.addAll(headers);

    request.fields.addAll({
      "nama_siswa": nama_siswa,
      "alamat": alamat,
      "telp": telp,
      "username": username,
      "password": password,
    });

    if (filePath.isNotEmpty) {
      request.files.add(
        await http.MultipartFile.fromPath("foto", filePath),
      );
    }

    http.StreamedResponse streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => loginPage()), (route) => false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Akun berhasil dibuat!", style: fonts().googleSansRegular(Colors.white, 16)),
              Text("Silahkan login untuk melanjutkan", style: fonts().googleSansRegular(Colors.white, 16)),
            ],
          ),
          showCloseIcon: true,
          duration: Duration(seconds: 20),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Oh tidak!", style: fonts().googleSansRegular(Colors.white, 16)),
              Text("Sepertinya ada masalah saat membuat akun.", style: fonts().googleSansRegular(Colors.white, 16)),
              Text("Silahkan coba lagi!", style: fonts().googleSansRegular(Colors.white, 16)),
            ],
          ),
          showCloseIcon: true,
          duration: Duration(seconds: 20),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  registerStan(String nama_pemilik, String nama_stan, String telp, String username, String password, BuildContext context) async {
    api Api = new api();

    var headers = {"makerID": "${Api.makerID}"};

    var result = await http.post(Uri.parse(Api.registerApiStan), body: {
      "nama_stan": nama_stan,
      "nama_pemilik": nama_pemilik,
      "telp": telp,
      "username": username,
      "password": password,
    }, headers: headers);

    Map<String, dynamic> resultData = jsonDecode(result.body);

    if (result.statusCode == 200) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => loginPage()), (route) => false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Akun berhasil dibuat!", style: fonts().googleSansRegular(Colors.white, 16)),
              Text("Silahkan login untuk melanjutkan", style: fonts().googleSansRegular(Colors.white, 16)),
            ],
          ),
          showCloseIcon: true,
          duration: Duration(seconds: 20),
          backgroundColor: Colors.green,
        ),
      );
    } else if (resultData["message"]["username"][0].contains("already been taken")) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Ups! Sepertinya username yang anda masukkan sudah digunakan.", style: fonts().googleSansRegular(Colors.white, 16)),
              Text("Silahkan masukkan username lain dan coba lagi!", style: fonts().googleSansRegular(Colors.white, 16)),
            ],
          ),
          showCloseIcon: true,
          duration: Duration(seconds: 20),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      print(resultData);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Oh tidak!", style: fonts().googleSansRegular(Colors.white, 16)),
              Text("Sepertinya ada masalah saat membuat akun.", style: fonts().googleSansRegular(Colors.white, 16)),
              Text("Silahkan coba lagi!", style: fonts().googleSansRegular(Colors.white, 16)),
            ],
          ),
          showCloseIcon: true,
          duration: Duration(seconds: 20),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
