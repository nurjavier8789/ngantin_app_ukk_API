import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/subPages/subSubPages/successOrder.dart';
import '../../../misc/authProcess.dart';
import '../../../misc/fonts.dart';
import '../../userData.dart';
import '../../../api.dart';

apiSiswa _apiSiswa = new apiSiswa();

// -= BERANDA =- //

sendOrder(Map cartData, BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();

  List pesanan = cartData["pesan"];

  List<String> queryPesanan = [];
  for (int i = 0; i < pesanan.length; i++) {
    queryPesanan.add("pesan[$i][id_menu]=${pesanan[i]["id_menu"]}");
    queryPesanan.add("pesan[$i][qty]=${pesanan[i]["qty"]}");
  }
  String queryString = queryPesanan.join("&");

  var headers = {
    "Authorization": "Bearer ${prefs.getString("token")}",
    "makerID": "${prefs.getInt("makerID")}"
  };

  var result = await http.get(Uri.parse(
      "${_apiSiswa.pesan}?id_stan=${cartData["id_stan"]}&${queryString}"
  ), headers: headers);

  Map resultData = jsonDecode(result.body);

  if (result.statusCode == 200) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => orderSuccessful()));
  } else {
    print(resultData);
    print("Gagal");
  }
}

getFood() async {
  final prefs = await SharedPreferences.getInstance();

  List realFoodList = [];

  var headers = {
    "Authorization": "Bearer ${prefs.getString("token")}",
    "makerID": "${prefs.getInt("makerID")}"
  };

  var result = await http.post(Uri.parse(_apiSiswa.getMenuMakanan), body: {
    "search": ""
  }, headers: headers);

  Map resultData = jsonDecode(result.body);

  if (result.statusCode == 200) {
    for (int i = 0; i < resultData["data"].length; i++) {
      for (int j = 0; j < dataStan().getDataStan().length; j++) {
        if (dataStan().getDataStan()[j]["id"] == resultData["data"][i]["id_stan"]) {
          realFoodList.add(resultData["data"][i]);
        }
      }
    }

    return realFoodList;
  } else if (result.statusCode == 401 && resultData["status"] == false && resultData["message"].contains("token invalid")) {
    await auth().refreshTokenLogin();

    var headersReload = {
      "Authorization": "Bearer ${prefs.getString("token")}",
      "makerID": "${prefs.getInt("makerID")}"
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

  List realDrinkList = [];

  var headers = {
    "Authorization": "Bearer ${prefs.getString("token")}",
    "makerID": "${prefs.getInt("makerID")}"
  };

  var result = await http.post(Uri.parse(_apiSiswa.getMenuMinuman), body: {
    "search": ""
  }, headers: headers);

  Map resultData = jsonDecode(result.body);

  if (result.statusCode == 200) {
    for (int i = 0; i < resultData["data"].length; i++) {
      for (int j = 0; j < dataStan().getDataStan().length; j++) {
        if (dataStan().getDataStan()[j]["id"] == resultData["data"][i]["id_stan"]) {
          realDrinkList.add(resultData["data"][i]);
        }
      }
    }

    return realDrinkList;
  } else if (result.statusCode == 401 && resultData["status"] == false && resultData["message"].contains("token invalid")) {
    await auth().refreshTokenLogin();

    var headersReload = {
      "Authorization": "Bearer ${prefs.getString("token")}",
      "makerID": "${prefs.getInt("makerID")}"
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

  List realOrderList = [];

  var headers = {
    "Authorization": "Bearer ${prefs.getString("token")}",
    "makerID": "${prefs.getInt("makerID")}"
  };

  var resultBelumOrder = await http.get(Uri.parse(_apiSiswa.getOrder_belum_dikonfirm), headers: headers);

  Map resultDataBelumOrder = jsonDecode(resultBelumOrder.body);

  if (resultBelumOrder.statusCode == 200) {
    for (int i = 0; i < resultDataBelumOrder["data"].length; i++) {
      for (int j = 0; j < dataStan().getDataStan().length; j++) {
        if (dataStan().getDataStan()[j]["id"] == resultDataBelumOrder["data"][i]["id_stan"]) {
          realOrderList.add(resultDataBelumOrder["data"][i]);
        }
      }
    }

    return realOrderList;
  } else {
    print("Gagal");
  }

}

getCookOrder() async {
  final prefs = await SharedPreferences.getInstance();

  List realOrderList = [];

  var headers = {
    "Authorization": "Bearer ${prefs.getString("token")}",
    "makerID": "${prefs.getInt("makerID")}"
  };

  var resultDimasak = await http.get(Uri.parse(_apiSiswa.getOrder_dimasak), headers: headers);

  Map resultDataDimasak = jsonDecode(resultDimasak.body);

  if (resultDimasak.statusCode == 200) {
    for (int i = 0; i < resultDataDimasak["data"].length; i++) {
      for (int j = 0; j < dataStan().getDataStan().length; j++) {
        if (dataStan().getDataStan()[j]["id"] == resultDataDimasak["data"][i]["id_stan"]) {
          realOrderList.add(resultDataDimasak["data"][i]);
        }
      }
    }

    return realOrderList;
  } else {
    print("Gagal");
  }
}

getDeliveredOrder() async {
  final prefs = await SharedPreferences.getInstance();

  List realOrderList = [];

  var headers = {
    "Authorization": "Bearer ${prefs.getString("token")}",
    "makerID": "${prefs.getInt("makerID")}"
  };

  var resultDiantar = await http.get(Uri.parse(_apiSiswa.getOrder_diantar), headers: headers);

  Map resultDataDiantar = jsonDecode(resultDiantar.body);

  if (resultDiantar.statusCode == 200) {
    for (int i = 0; i < resultDataDiantar["data"].length; i++) {
      for (int j = 0; j < dataStan().getDataStan().length; j++) {
        if (dataStan().getDataStan()[j]["id"] == resultDataDiantar["data"][i]["id_stan"]) {
          realOrderList.add(resultDataDiantar["data"][i]);
        }
      }
    }

    return realOrderList;
  } else {
    print("Gagal");
  }
}

getArriveOrder() async {
  final prefs = await SharedPreferences.getInstance();

  List realOrderList = [];

  var headers = {
    "Authorization": "Bearer ${prefs.getString("token")}",
    "makerID": "${prefs.getInt("makerID")}"
  };

  var resultSampai = await http.get(Uri.parse(_apiSiswa.getOrder_sampai), headers: headers);

  Map resultDataSampai = jsonDecode(resultSampai.body);

  if (resultSampai.statusCode == 200) {
    for (int i = 0; i < resultDataSampai["data"].length; i++) {
      for (int j = 0; j < dataStan().getDataStan().length; j++) {
        if (dataStan().getDataStan()[j]["id"] == resultDataSampai["data"][i]["id_stan"]) {
          realOrderList.add(resultDataSampai["data"][i]);
        }
      }
    }

    return realOrderList;
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

  var result = await http.get(Uri.parse("${_apiSiswa.getOrderAll}/$date"), headers: headers);
  Map resultData = jsonDecode(result.body);

  if (result.statusCode == 200) {
    return resultData["data"];
  } else {
    print("Gagal");
  }
}

getFoodNameThing(int idMenu) async {
  final prefs = await SharedPreferences.getInstance();

  var headers = {
    "Authorization": "Bearer ${prefs.getString("token")}",
    "makerID": "${prefs.getInt("makerID")}"
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

getPriceThing(int idMenu) async {
  final prefs = await SharedPreferences.getInstance();

  var headers = {
    "Authorization": "Bearer ${prefs.getString("token")}",
    "makerID": "${prefs.getInt("makerID")}"
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
        return resultDataFood["data"][i]["harga"];
      } else if (resultDrink.statusCode == 200) {
        for (int i = 0; i < resultDataDrink["data"].length; i++) {
          if (resultDataDrink["data"][i]["id_menu"] == idMenu) {
            return resultDataDrink["data"][i]["harga"];
          }
        }
      }
    }
  }
}

// -= AKUN =- //

editProfile(String nama_siswa, String alamat, String telp, String username, BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();

  String urlThing = "${_apiSiswa.updateProfile}/${prefs.get("id_user")}";

  var headers = {
    "Authorization": "Bearer ${prefs.getString("token")}",
    "makerID": "${prefs.getInt("makerID")}"
  };

  var result = await http.post(Uri.parse(urlThing), body: {
    "nama_siswa": nama_siswa,
    "alamat": alamat,
    "telp": telp,
    "username": username,
  }, headers: headers);

  // Map resultData = jsonDecode(result.body);

  if (result.statusCode == 200) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Profile telah diupdate!", style: fonts().googleSansRegular(Colors.white, 16)),
          ],
        ),
        showCloseIcon: true,
        duration: Duration(seconds: 20),
      ),
    );
    return true;
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Maaf ada kendala saat memperbarui profil.", style: fonts().googleSansRegular(Colors.white, 16)),
            Text("Silahkan cek kembali data yang dimasukkan", style: fonts().googleSansRegular(Colors.white, 16)),
            Text("dan coba lagi", style: fonts().googleSansRegular(Colors.white, 16)),
          ],
        ),
        showCloseIcon: true,
        duration: Duration(seconds: 20),
      ),
    );
    return false;
  }
}
