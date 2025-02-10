import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../api.dart';
import '../../../misc/fonts.dart';

apiSiswa _apiSiswa = new apiSiswa();
var numberFormat = NumberFormat("#,###");

getFood() async {
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

getDrink() async {
  final prefs = await SharedPreferences.getInstance();

  var headers = {
    "Authorization": "Bearer ${prefs.getString("token")}",
    "makerID": "${_apiSiswa.makerID}"
  };

  var result = await http.post(Uri.parse(_apiSiswa.getMenuMinuman), body: {
    "search": ""
  }, headers: headers);

  Map resultData = jsonDecode(result.body);

  if (result.statusCode == 200) {
    return resultData["data"];

  } else {
    print("Gagal");
  }
}

showDetail(BuildContext context, List foodData, int idFood) {
  Widget okButton = Padding(
    padding: const EdgeInsetsDirectional.symmetric(horizontal: 8),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 218, 131, 0),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: const Text("OK", style: TextStyle(color: Colors.white)),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
  );

  AlertDialog details = AlertDialog(
    contentPadding: EdgeInsets.all(24),
    title: Text("Detail Makanan", style: fonts().googleSansBold(Colors.black, 26), textAlign: TextAlign.center),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: ClipRRect(
            child: foodData[idFood]["foto"].isEmpty ? Image.asset("assets/noImage.png", width: 100,) : Image.network("${_apiSiswa.baseUrlRil}${foodData[idFood]["foto"]}", fit: BoxFit.cover, width: 1080, height: 200),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        SizedBox(height: 12),
        Text('${foodData[idFood]["nama_makanan"]}', style: fonts().googleSansBold(Colors.black, 24), softWrap: true,),
        SizedBox(height: 10),
        Text('${foodData[idFood]["deskripsi"]}', softWrap: true, style: fonts().googleSansRegular(Colors.black, 16)),
        SizedBox(height: 30),
        Text('Rp.${numberFormat.format(foodData[idFood]["harga"])}', style: fonts().googleSansBold(Colors.black, 16)),
      ],
    ),
    actions: [okButton],
  );

  return showDialog(
    context: context,
    builder: (context) {
      return details;
    },
  );
}
