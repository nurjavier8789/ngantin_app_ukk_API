import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../misc/fonts.dart';
import '../../../api.dart';

apiAdmin _apiAdmin = new apiAdmin();

// -= HOME =- //


getPemasukan(String date) async {
  final prefs = await SharedPreferences.getInstance();

  var headers = {
    "Authorization": "Bearer ${prefs.getString("token")}",
    "makerID": "${prefs.getInt("makerID")}"
  };

  var result = await http.get(Uri.parse("${_apiAdmin.getIncome}/$date"), headers: headers);

  Map resultData = jsonDecode(result.body);

  if (result.statusCode == 200) {
    return resultData["data"];
  } else {
    print("Gagal");
  }
}

// -= PESANAN =- //

getNotConfirmOrder() async {
  final prefs = await SharedPreferences.getInstance();

  var headers = {
    "Authorization": "Bearer ${prefs.getString("token")}",
    "makerID": "${prefs.getInt("makerID")}"
  };

  var resultBelumOrder = await http.get(Uri.parse(_apiAdmin.getOrder_belum_dikonfirm), headers: headers);

  Map resultDataBelumOrder = jsonDecode(resultBelumOrder.body);

  if (resultBelumOrder.statusCode == 200) {
    return resultDataBelumOrder["data"];
  } else {
    print("Gagal");
  }

}

getCookOrder() async {
  final prefs = await SharedPreferences.getInstance();

  var headers = {
    "Authorization": "Bearer ${prefs.getString("token")}",
    "makerID": "${prefs.getInt("makerID")}"
  };

  var resultDimasak = await http.get(Uri.parse(_apiAdmin.getOrder_dimasak), headers: headers);

  Map resultDataDimasak = jsonDecode(resultDimasak.body);

  if (resultDimasak.statusCode == 200) {
    return resultDataDimasak["data"];
  } else {
    print("Gagal");
  }
}

getDeliveredOrder() async {
  final prefs = await SharedPreferences.getInstance();

  var headers = {
    "Authorization": "Bearer ${prefs.getString("token")}",
    "makerID": "${prefs.getInt("makerID")}"
  };

  var resultDiantar = await http.get(Uri.parse(_apiAdmin.getOrder_diantar), headers: headers);

  Map resultDataDiantar = jsonDecode(resultDiantar.body);

  if (resultDiantar.statusCode == 200) {
    return resultDataDiantar["data"];
  } else {
    print("Gagal");
  }
}

getArriveOrder() async {
  final prefs = await SharedPreferences.getInstance();

  var headers = {
    "Authorization": "Bearer ${prefs.getString("token")}",
    "makerID": "${prefs.getInt("makerID")}"
  };

  var resultSampai = await http.get(Uri.parse(_apiAdmin.getOrder_sampai), headers: headers);

  Map resultDataSampai = jsonDecode(resultSampai.body);

  if (resultSampai.statusCode == 200) {
    return resultDataSampai["data"];
  } else {
    print("Gagal");
  }
}

getOrderHistory(String date) async {
  final prefs = await SharedPreferences.getInstance();

  var headers = {
    "Authorization": "Bearer ${prefs.getString("token")}",
    "makerID": "${prefs.getInt("makerID")}"
  };

  var result = await http.get(Uri.parse("${_apiAdmin.showOrderByMonth}/$date"), headers: headers);
  Map resultData = jsonDecode(result.body);

  if (result.statusCode == 200) {
    return resultData["data"];
  } else {
    print("Gagal");
  }
}

changeStatus(BuildContext context, int id, String status) async {
  final prefs = await SharedPreferences.getInstance();

  String realStatus = "";

  if (status == "Belum Dikonfirmasi") {
    realStatus = "belum dikonfirm";
  } else if (status == "Dimasak") {
    realStatus = "dimasak";
  } else if (status == "Diantar") {
    realStatus = "diantar";
  } else if (status == "Sampai") {
    realStatus = "sampai";
  }

  var headers = {
    "Authorization": "Bearer ${prefs.getString("token")}",
    "makerID": "${prefs.getInt("makerID")}"
  };

  var result = await http.put(Uri.parse("${_apiAdmin.updateStatusOrder}/${id}"), body: {
    "status": realStatus
  }, headers: headers);
  Map resultData = jsonDecode(result.body);

  if (result.statusCode == 200 && resultData["status"] == true) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Status pesanan berhasil diubah!", style: fonts().googleSansRegular(Colors.white, 16)),
          ],
        ),
        showCloseIcon: true,
        duration: Duration(seconds: 20),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.pop(context);
    return realStatus;
  } else {
    print("Gagal");
    return "gagal";
  }
}

getFoodNameThing(int idMenu) async {
  final prefs = await SharedPreferences.getInstance();

  var headers = {
    "Authorization": "Bearer ${prefs.getString("token")}",
    "makerID": "${prefs.getInt("makerID")}"
  };

  var resultFood = await http.post(Uri.parse(_apiAdmin.showMenu), body: {
    "search": ""
  }, headers: headers);

  Map resultDataFood = jsonDecode(resultFood.body);

  if (resultFood.statusCode == 200) {
    for (int i = 0; i < resultDataFood["data"].length; i++) {
      if (resultDataFood["data"][i]["id"] == idMenu) {
        return resultDataFood["data"][i]["nama_makanan"];
      }
    }
  }
}

getPriceThing(int idMenu) async {
  final prefs = await SharedPreferences.getInstance();

  var headers = {
    "Authorization": "Bearer ${prefs.getString("token")}",
    "makerID": "${prefs.getInt("makerID")}"
  };

  var resultFood = await http.post(Uri.parse(_apiAdmin.showMenu), body: {
    "search": ""
  }, headers: headers);

  Map resultDataFood = jsonDecode(resultFood.body);

  if (resultFood.statusCode == 200) {
    for (int i = 0; i < resultDataFood["data"].length; i++) {
      if (resultDataFood["data"][i]["id"] == idMenu) {
        return resultDataFood["data"][i]["harga"];
      }
    }
  }
}

//-=// -= ATUR =- //=-//

// -= MENU =- //
showListMenu() async {
  final prefs = await SharedPreferences.getInstance();

  var headers = {
    "Authorization": "Bearer ${prefs.getString("token")}",
    "makerID": "${prefs.getInt("makerID")}"
  };

  var result = await http.post(Uri.parse("${_apiAdmin.showMenu}"), body: {
    "search": ""
  }, headers: headers);
  Map resultData = jsonDecode(result.body);

  if (result.statusCode == 200) {
    return resultData["data"];
  } else {
    print(resultData);
    print("Gagal");
  }
}

addMenu(BuildContext context, String nama_makanan, String jenis, String harga, String filePath, String deskripsi) async {
  final prefs = await SharedPreferences.getInstance();

  String jenisMakanan = "";

  if (jenis == "Makanan") {
    jenisMakanan = "makanan";
  } else if (jenis == "Minuman") {
    jenisMakanan = "minuman";
  }

  var headers = {
    "Authorization": "Bearer ${prefs.getString("token")}",
    "makerID": "${prefs.getInt("makerID")}"
  };

  var request = http.MultipartRequest("POST", Uri.parse(_apiAdmin.addMenu));

  request.headers.addAll(headers);

  request.fields.addAll({
    "nama_makanan": nama_makanan,
    "jenis": jenisMakanan,
    "harga": harga,
    "deskripsi": deskripsi,
  });

  request.files.add(
    await http.MultipartFile.fromPath("foto", filePath),
  );

  http.StreamedResponse streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);

  if (response.statusCode == 200) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Menu berhasil ditambahkan!", style: fonts().googleSansRegular(Colors.white, 16)),
          ],
        ),
        showCloseIcon: true,
        duration: Duration(seconds: 20),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.of(context).pop();
  } else {
    print("Gagal");
  }
}

editMenu(BuildContext context, int id, String nama_makanan, String jenis, String harga, String filePath, String deskripsi) async {
  final prefs = await SharedPreferences.getInstance();

  String jenisMakanan = "";

  if (jenis == "Makanan") {
    jenisMakanan = "makanan";
  } else if (jenis == "Minuman") {
    jenisMakanan = "minuman";
  }

  var headers = {
    "Authorization": "Bearer ${prefs.getString("token")}",
    "makerID": "${prefs.getInt("makerID")}"
  };

  var request = http.MultipartRequest("POST", Uri.parse("${_apiAdmin.editMenu}/${id}"));

  request.headers.addAll(headers);

  request.fields.addAll({
    "nama_makanan": nama_makanan,
    "jenis": jenisMakanan,
    "harga": harga,
    "deskripsi": deskripsi,
  });

  request.files.add(
    await http.MultipartFile.fromPath("foto", filePath),
  );

  http.StreamedResponse streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);

  if (response.statusCode == 200) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Menu berhasil diubah!", style: fonts().googleSansRegular(Colors.white, 16)),
          ],
        ),
        showCloseIcon: true,
        duration: Duration(seconds: 10),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.of(context).pop();
  } else {
    print(response.body);
    print("Gagal");
  }
}

deleteDisMenu(int id, BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();

  var headers = {
    "Authorization": "Bearer ${prefs.getString("token")}",
    "makerID": "${prefs.getInt("makerID")}"
  };

  var result = await http.delete(Uri.parse("${_apiAdmin.deleteMenu}/${id}"), headers: headers);

  if (result.statusCode == 200) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Menu berhasil dihapus!", style: fonts().googleSansRegular(Colors.white, 16)),
          ],
        ),
        showCloseIcon: true,
        duration: Duration(seconds: 20),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.of(context).pop();
  } else {
    print("Gagal");
  }
}

// -= DISKON =- //
addDiskon(BuildContext context, String nama_diskon, String persentase_diskon, String tanggal_awal, String tanggal_akhir) async {
  final prefs = await SharedPreferences.getInstance();

  var headers = {
    "Authorization": "Bearer ${prefs.getString("token")}",
    "makerID": "${prefs.getInt("makerID")}"
  };

  var result = await http.post(Uri.parse("${_apiAdmin.addDiskon}"), body: {
    "nama_diskon": nama_diskon,
    "persentase_diskon": persentase_diskon,
    "tanggal_awal": tanggal_awal,
    "tanggal_akhir": tanggal_akhir,
  }, headers: headers);
  Map resultData = jsonDecode(result.body);

  if (result.statusCode == 200) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Diskon berhasil ditambahkan!", style: fonts().googleSansRegular(Colors.white, 16)),
          ],
        ),
        showCloseIcon: true,
        duration: Duration(seconds: 10),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.of(context).pop();
  } else {
    print("Gagal");
  }
}

// -= AKUN SISWA =- //
showListSiswa() async {
  final prefs = await SharedPreferences.getInstance();

  var headers = {
    "Authorization": "Bearer ${prefs.getString("token")}",
    "makerID": "${prefs.getInt("makerID")}"
  };

  var result = await http.post(Uri.parse("${_apiAdmin.showSiswaAccount}"), body: {
    "search": ""
  }, headers: headers);

  Map resultData = jsonDecode(result.body);

  if (result.statusCode == 200) {
    return resultData["data"];
  } else {
    print(resultData);
    print("Gagal");
  }
}

addAkunSiswa(BuildContext context, String nama_siswa, String alamat, String telp, String username, String password, String filePath) async {
  final prefs = await SharedPreferences.getInstance();

  var headers = {
    "Authorization": "Bearer ${prefs.getString("token")}",
    "makerID": "${prefs.getInt("makerID")}"
  };

  var request = http.MultipartRequest("POST", Uri.parse(_apiAdmin.addSiswaAccount));

  request.headers.addAll(headers);

  request.fields.addAll({
    'nama_siswa': nama_siswa,
    'alamat': alamat,
    'telp': telp,
    'username': username,
    'password': password
  });

  if (filePath.isNotEmpty) {
    request.files.add(
      await http.MultipartFile.fromPath("foto", filePath),
    );
  }

  http.StreamedResponse streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);

  if (response.statusCode == 200) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Akun Siswa berhasil ditambahkan!", style: fonts().googleSansRegular(Colors.white, 16)),
          ],
        ),
        showCloseIcon: true,
        duration: Duration(seconds: 10),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.of(context).pop();
  } else {
    print("Gagal");
  }
}

editAkunSiswa(BuildContext context, String nama_siswa, String alamat, String telp, String username, String filePath, int id) async {
  final prefs = await SharedPreferences.getInstance();

  var headers = {
    "Authorization": "Bearer ${prefs.getString("token")}",
    "makerID": "${prefs.getInt("makerID")}"
  };

  var request = http.MultipartRequest("POST", Uri.parse("${_apiAdmin.updateSiswaAccount}/${id}"));

  request.headers.addAll(headers);

  request.fields.addAll({
    'nama_siswa': nama_siswa,
    'alamat': alamat,
    'telp': telp,
    'username': username
  });

  // request.files.add(
  //   await http.MultipartFile.fromPath("foto", filePath),
  // );

  http.StreamedResponse streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);

  if (response.statusCode == 200) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Akun Siswa berhasil diperbarui!", style: fonts().googleSansRegular(Colors.white, 16)),
          ],
        ),
        showCloseIcon: true,
        duration: Duration(seconds: 10),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.of(context).pop();
  } else {
    print(response.body);
    print("Gagal");
  }
}

deleteAkunSiswa(int id, BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();

  var headers = {
    "Authorization": "Bearer ${prefs.getString("token")}",
    "makerID": "${prefs.getInt("makerID")}"
  };

  var result = await http.delete(Uri.parse("${_apiAdmin.deleteSiswaAccount}/${id}"), headers: headers);

  if (result.statusCode == 200) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Akun siswa berhasil dihapus!", style: fonts().googleSansRegular(Colors.white, 16)),
          ],
        ),
        showCloseIcon: true,
        duration: Duration(seconds: 20),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.of(context).pop();
  } else {
    print("Gagal");
  }
}
