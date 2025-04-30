import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../api.dart';
import 'userData.dart';

class Get {
  api Api = new api();
  apiSiswa _apiSiswa = new apiSiswa();
  apiAdmin _apiAdmin = new apiAdmin();

  profileSiswa() async {
    final prefs = await SharedPreferences.getInstance();

    var result = await http.get(Uri.parse(_apiSiswa.getProfile), headers: {
      "Authorization": "Bearer ${prefs.getString("token")}",
      "makerID": "${Api.makerID}",
    });
    Map<String, dynamic> resultData = jsonDecode(result.body);

    if (resultData["status"] == true) {
      prefs.setString("nama", resultData["data"]["nama_siswa"]);
      prefs.setString("alamat", resultData["data"]["alamat"]);
      prefs.setString("telp", resultData["data"]["telp"]);
      prefs.setInt("id_user", resultData["data"]["id"]);
      prefs.setString("username", resultData["data"]["username"]);
      prefs.setString("role", resultData["data"]["role"]);
      prefs.setInt("makerID", resultData["data"]["maker_id"]);

      if (resultData["data"]["foto"] != null) {
        dataUser().setDataSiswa(
          resultData["data"]["nama_siswa"],
          resultData["data"]["alamat"],
          resultData["data"]["telp"],
          "${Api.baseUrlRil}${resultData["data"]["foto"]}",
          resultData["data"]["id"],
          resultData["data"]["username"],
          resultData["data"]["maker_id"],
        );

        prefs.setString("foto", resultData["data"]["foto"]);
      } else {
        dataUser().setDataSiswa(
          resultData["data"]["nama_siswa"],
          resultData["data"]["alamat"],
          resultData["data"]["telp"],
          "",
          resultData["data"]["id"],
          resultData["data"]["username"],
          resultData["data"]["maker_id"],
        );
      }
    }
  }

  profileStan() async {
    final prefs = await SharedPreferences.getInstance();

    var result = await http.get(Uri.parse(_apiAdmin.getProfile), headers: {
      "Authorization": "Bearer ${prefs.getString("token")}",
      "makerID": "${Api.makerID}",
    });
    Map<String, dynamic> resultData = jsonDecode(result.body);

    dataUser().setDataStan(
      resultData["data"]["nama_stan"],
      resultData["data"]["nama_pemilik"],
      resultData["data"]["telp"],
      resultData["data"]["id"],
      resultData["data"]["username"],
    );

    prefs.setInt("id_user", resultData["data"]["id"]);
    prefs.setString("namaStan", resultData["data"]["nama_stan"]);
    prefs.setString("nama", resultData["data"]["nama_pemilik"]);
    prefs.setString("telp", resultData["data"]["telp"]);
    prefs.setInt("makerID", resultData["data"]["maker_id"]);
    prefs.setString("username", resultData["data"]["username"]);
    prefs.setString("role", resultData["data"]["role"]);
  }

  stanDataList() async {
    final prefs = await SharedPreferences.getInstance();

    var result = await http.post(Uri.parse(_apiSiswa.getStanData), headers: {
      "Authorization": "Bearer ${prefs.getString("token")}",
      "makerID": "${Api.makerID}",
    });
    Map resultDataStanConvert = jsonDecode(result.body);

    if (resultDataStanConvert["status"] == true) {
      dataStan().setDataStan(resultDataStanConvert["data"]);
    } else {
      print("Error...");
    }
  }
}
