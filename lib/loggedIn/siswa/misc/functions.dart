import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../api.dart';
import '../../../misc/authProcess.dart';

apiSiswa _apiSiswa = new apiSiswa();

// -= BERANDA =- //

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
  } else if (result.statusCode == 401 && resultData["status"] == false && resultData["message"].contains("token invalid")) {
    await auth().refreshTokenLogin();

    var headersReload = {
      "Authorization": "Bearer ${prefs.getString("token")}",
      "makerID": "${_apiSiswa.makerID}"
    };

    var resultReload = await http.post(Uri.parse(_apiSiswa.getMenuMakanan), body: {
      "search": ""
    }, headers: headersReload);

    Map resultDataReload = jsonDecode(resultReload.body);

    return resultDataReload["data"];
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

  } else if (result.statusCode == 401 && resultData["status"] == false && resultData["message"].contains("token invalid")) {
    await auth().refreshTokenLogin();

    var headersReload = {
      "Authorization": "Bearer ${prefs.getString("token")}",
      "makerID": "${_apiSiswa.makerID}"
    };

    var resultReload = await http.post(Uri.parse(_apiSiswa.getMenuMinuman), body: {
      "search": ""
    }, headers: headersReload);

    Map resultDataReload = jsonDecode(resultReload.body);

    return resultDataReload["data"];
  } else {
    print("Gagal");
  }
}

// -= PESANAN =- //

getNotConfirmOrder() async {
  final prefs = await SharedPreferences.getInstance();

  var headers = {
    "Authorization": "Bearer ${prefs.getString("token")}",
    "makerID": "${_apiSiswa.makerID}"
  };

  var resultBelumOrder = await http.get(Uri.parse(_apiSiswa.getOrder_belum_dikonfirm), headers: headers);

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
    "makerID": "${_apiSiswa.makerID}"
  };

  var resultDimasak = await http.get(Uri.parse(_apiSiswa.getOrder_dimasak), headers: headers);

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
    "makerID": "${_apiSiswa.makerID}"
  };

  var resultDiantar = await http.get(Uri.parse(_apiSiswa.getOrder_diantar), headers: headers);

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
    "makerID": "${_apiSiswa.makerID}"
  };

  var resultSampai = await http.get(Uri.parse(_apiSiswa.getOrder_sampai), headers: headers);

  Map resultDataSampai = jsonDecode(resultSampai.body);

  if (resultSampai.statusCode == 200) {
    return resultDataSampai["data"];
  } else {
    print("Gagal");
  }
}

getFoodNameThing(int idMenu) async {
  final prefs = await SharedPreferences.getInstance();

  var headers = {
    "Authorization": "Bearer ${prefs.getString("token")}",
    "makerID": "${_apiSiswa.makerID}"
  };

  var resultFood = await http.post(Uri.parse(_apiSiswa.getMenuMakanan), body: {
    "search": ""
  }, headers: headers);

  var resultDrink = await http.post(Uri.parse(_apiSiswa.getMenuMinuman), body: {
    "search": ""
  }, headers: headers);

  Map resultDataFood = jsonDecode(resultFood.body);
  Map resultDataDrink = jsonDecode(resultDrink.body);

  if (resultFood.statusCode == 200) {
    for (int i = 0; i < resultDataFood["data"].length; i++) {
      if (resultDataFood["data"][i]["id_menu"] == idMenu) {
        return resultDataFood["data"][i]["nama_makanan"];
      } else if (resultDrink.statusCode == 200) {
        for (int i = 0; i < resultDataDrink["data"].length; i++) {
          if (resultDataDrink["data"][i]["id_menu"] == idMenu) {
            return resultDataDrink["data"][i]["nama_makanan"];
          }
        }
      }
    }
  }
}
// -= AKUN =- //
