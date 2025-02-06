import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../api.dart';
import 'userData.dart';

class Get {
  profileSiswa() async {
    api Api = new api();
    apiSiswa _apiSiswa = new apiSiswa();
    final prefs = await SharedPreferences.getInstance();
    
    var result = await http.get(Uri.parse(_apiSiswa.getProfile), headers: {
      "Authorization": "Bearer ${prefs.getString("token")}",
      "makerID": "${Api.makerID}",
    });
    Map<String, dynamic> resultData = jsonDecode(result.body);

    if (resultData["status"] == true) {
      dataUser().setDataSiswa(
        resultData["data"]["nama_siswa"],
        resultData["data"]["alamat"],
        resultData["data"]["telp"],
        "${Api.baseUrlRil}${resultData["data"]["foto"]}",
        resultData["data"]["id_user"],
        resultData["data"]["username"],
      );
      
      prefs.setString("nama", resultData["data"]["nama_siswa"]);
      prefs.setString("alamat", resultData["data"]["alamat"]);
      prefs.setString("telp", resultData["data"]["telp"]);
      prefs.setString("foto", resultData["data"]["foto"]);
      prefs.setInt("id_user", resultData["data"]["id_user"]);
      prefs.setString("username", resultData["data"]["username"]);
      prefs.setString("role", resultData["data"]["role"]);
    }
  }

  profileStan() async {
  }
}
