import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../api.dart';

getFood() async {
  apiSiswa _apiSiswa = new apiSiswa();
  final prefs = await SharedPreferences.getInstance();


  var headers = {
    "Authorization": "Bearer ${prefs.getString("token")}",
    "makerID": "${_apiSiswa.makerID}"
  };

  var result = await http.post(Uri.parse(_apiSiswa.getMenuMakanan), body: {
    "search": ""
  }, headers: headers);

  Map resultData = jsonDecode(result.body);

  if (result.statusCode == 200) {
    return resultData["data"];

  } else {
    print("Gagal");
  }
}