import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../pages/subPages/detailOrder.dart';
import '../pages/subPages/listSiswa.dart';
import '../../../misc/styles.dart';
import '../../../misc/fonts.dart';
import '../../userData.dart';
import '../../../api.dart';
import 'functions.dart';

api _api = new api();
var numberFormat = NumberFormat("#,###", "id_ID");

class widgets {

  // -= HOME =- //

  Text greeting() {
    String teks = "";

    if (DateTime.now().hour >= 00 && DateTime.now().hour <= 09) {
      teks = "Selamat Pagi";
    } else if (DateTime.now().hour >= 10 && DateTime.now().hour <= 14) {
      teks = "Selamat Siang";
    } else if (DateTime.now().hour >= 15 && DateTime.now().hour <= 17) {
      teks = "Selamat Sore";
    } else if (DateTime.now().hour >= 18 && DateTime.now().hour <= 23) {
      teks = "Selamat Malam";
    }

    return Text("${teks} ${dataUser().getNama()}!", style: fonts().googleSansCustom(Colors.black, 28, FontWeight.w600), softWrap: true, maxLines: 2);
  }

  // -= PESANAN =- //

  cardOrder(BuildContext context, String currentFilter, List dataOrder) {
    var numberFormat = NumberFormat("#,###", "id_ID");
    int showFiltered = 0;
    Color statusColorText = Colors.black;

    if (currentFilter.contains("Belum Dikonfirmasi")) {
      statusColorText = Colors.red;
      showFiltered = 0;
    } else if (currentFilter.contains("Dimasak")) {
      statusColorText = Colors.deepOrangeAccent;
      showFiltered = 1;
    } else if (currentFilter.contains("Diantar")) {
      statusColorText = Colors.orange;
      showFiltered = 2;
    } else if (currentFilter.contains("Sampai")) {
      statusColorText = Colors.green;
      showFiltered = 3;
    }

    List listJumlah = List.filled(dataOrder[showFiltered].length, 0);
    List listTotalHarga = List.filled(dataOrder[showFiltered].length, 0);
    num jumlah = 0;
    num totalHarga = 0;

    Future.delayed(Duration(seconds: 1));

    for (int i = 0; i < dataOrder[showFiltered].length; i++) {
      for (int j = 0; j < dataOrder[showFiltered][i]["detail_trans"].length; j++) {
        totalHarga += dataOrder[showFiltered][i]["detail_trans"][j]["harga_beli"];
        jumlah += dataOrder[showFiltered][i]["detail_trans"][j]["qty"];
      }

      listJumlah[i] = jumlah;
      listTotalHarga[i] = totalHarga;
      jumlah = 0;
      totalHarga = 0;
    }

    Future.delayed(Duration(seconds: 1));

    if (dataOrder[showFiltered].isEmpty) {
      return Container(
        margin: EdgeInsets.only(top: 12),
        child: Text("Tidak ada pesanan untuk saat ini"),
      );
    } else {
      return Container(
        height: MediaQuery.of(context).size.height-290,
        child: ListView(
          shrinkWrap: true,
          children: [
            for (int i = 0; i < dataOrder[showFiltered].length; i++)
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Pesanan ${DateTime.parse(dataOrder[showFiltered][i]["tanggal"]).day.toString().padLeft(2, "0")}/"
                                "${DateTime.parse(dataOrder[showFiltered][i]["tanggal"]).month.toString().padLeft(2, "0")}/"
                                "${DateTime.parse(dataOrder[showFiltered][i]["tanggal"]).year}",
                            style: fonts().googleSansBold(Colors.black, 18),
                          ),
                          Text(
                            dataOrder[showFiltered][i]["status"] == "belum dikonfirm"
                                ? "Belum Dikonfirmasi"
                              : dataOrder[showFiltered][i]["status"] == "dimasak"
                                ? "Dimasak"
                              : dataOrder[showFiltered][i]["status"] == "diantar"
                                ? "Diantar"
                              : dataOrder[showFiltered][i]["status"] == "sampai"
                                ? "Sampai"
                              : "-",
                            style: fonts().googleSansBold(statusColorText, 18),
                          ),
                        ],
                      ),
                      // Text("Dipesan oleh [User]"),
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${listJumlah[i]} item",
                                style: fonts().googleSansRegular(Colors.black, 15),
                              ),
                              Text("Rp${numberFormat.format(listTotalHarga[i])}"),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => orderDetail(dataTransaksi: dataOrder[showFiltered][i],)));
                            },
                            style: style().buttonDefaultColor(16, FontWeight.bold),
                            child: Text("Detail"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            SizedBox(height: 96),
          ],
        ),
      );
    }
  }

  cardOrderHistory(BuildContext context, List dataOrder) {
    Color statusColorText = Colors.black;

    for (int i = 0; i < dataOrder.length; i++) {
      if (dataOrder[i]["status"].contains("belum dikonfirm")) {
        statusColorText = Colors.red;
      } else if (dataOrder[i]["status"].contains("dimasak")) {
        statusColorText = Colors.deepOrangeAccent;
      } else if (dataOrder[i]["status"].contains("diantar")) {
        statusColorText = Colors.orange;
      } else if (dataOrder[i]["status"].contains("sampai")) {
        statusColorText = Colors.green;
      }
    }

    return ListView(
      shrinkWrap: true,
      children: [
        for (int i = 0; i < dataOrder.length; i++)
        Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Pesanan ${DateTime.parse(dataOrder[i]["tanggal"]).day.toString().padLeft(2, "0")}/"
                          "${DateTime.parse(dataOrder[i]["tanggal"]).month.toString().padLeft(2, "0")}/"
                          "${DateTime.parse(dataOrder[i]["tanggal"]).year}",
                      style: fonts().googleSansBold(Colors.black, 18),
                    ),
                    Text(
                      dataOrder[i]["status"] == "belum dikonfirm"
                          ? "Belum Dikonfirmasi"
                          : dataOrder[i]["status"] == "dimasak"
                          ? "Dimasak"
                          : dataOrder[i]["status"] == "diantar"
                          ? "Diantar"
                          : dataOrder[i]["status"] == "sampai"
                          ? "Sampai"
                          : "-",
                      style: fonts().googleSansBold(statusColorText, 18),
                    ),
                  ],
                ),
                Text("Dipesan oleh ${dataOrder[i]["nama_siswa"]}"),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // -= ATUR =- //

  // -= ATUR MENU =- //
  showDetailMenu(BuildContext context, List foodData, int idFood) {
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
      title: Text("Detail Item", style: fonts().googleSansBold(Colors.black, 26), textAlign: TextAlign.center),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ClipRRect(
              child: foodData[idFood]["foto"].isEmpty ? Image.asset("assets/noImage.png", width: 100,) : Image.network("${_api.baseUrlRil}${foodData[idFood]["foto"]}", fit: BoxFit.cover, width: 1080, height: 200),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          SizedBox(height: 12),
          Text('${foodData[idFood]["nama_makanan"]}', style: fonts().googleSansBold(Colors.black, 24), softWrap: true,),
          SizedBox(height: 10),
          Text('${foodData[idFood]["deskripsi"]}', softWrap: true, style: fonts().googleSansRegular(Colors.black, 16)),
          SizedBox(height: 30),
          Text('Rp. ${numberFormat.format(foodData[idFood]["harga"])}', style: fonts().googleSansBold(Colors.black, 16)),
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

  deleteMenuConfirm(BuildContext context, String namaMakanan, int id) {
    String backOrNot = "back";

    Widget backButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 218, 131, 0),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: const Text("Kembali", style: TextStyle(color: Colors.white)),
      onPressed: () {
        backOrNot = "back";
        Navigator.pop(context);
      },
    );

    Widget deleteButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: const Text("Hapus", style: TextStyle(color: Colors.white)),
      onPressed: () async {
        backOrNot = "delete";
        await deleteDisMenu(id, context);
      },
    );

    AlertDialog details = AlertDialog(
      contentPadding: EdgeInsets.all(24),
      title: Text("Konfirmasi Hapus Menu", style: fonts().googleSansBold(Colors.black, 26), textAlign: TextAlign.center),
      content: Text("Apakah anda ingin menghapus menu ${namaMakanan}?"),
      actions: [backButton, deleteButton],
    );

    return showDialog(
      context: context,
      builder: (context) {
        return details;
      },
    ).then((value) {
      return backOrNot;
    });
  }

  // -= ATUR AKUN SISWA =- //
  showDetailSiswa(BuildContext context, Map dataSiswa) {
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
      title: Text("Detail Akun Siswa", style: fonts().googleSansBold(Colors.black, 26), textAlign: TextAlign.center),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: dataSiswa["foto"] == null ? Image.asset("assets/noIcon.png", height: 100, width: 100, fit: BoxFit.cover) : Image.network("${_api.baseUrlRil}${dataSiswa["foto"]}", fit: BoxFit.cover, width: 100, height: 100),
            ),
          ),
          SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nama Siswa', style: fonts().googleSansRegular(Colors.black, 16), softWrap: true),
              SizedBox(width: 4),
              SizedBox(
                width: MediaQuery.of(context).size.width-220,
                child: Text(': ${dataSiswa["nama_siswa"]}', style: fonts().googleSansBold(Colors.black, 16), softWrap: true),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Username', style: fonts().googleSansRegular(Colors.black, 16), softWrap: true),
              SizedBox(width: 16),
              SizedBox(
                width: MediaQuery.of(context).size.width-220,
                child: Text(': ${dataSiswa["username"]}', style: fonts().googleSansBold(Colors.black, 16), softWrap: true),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Alamat', style: fonts().googleSansRegular(Colors.black, 16), softWrap: true),
              SizedBox(width: 38),
              Container(
                width: MediaQuery.of(context).size.width-220,
                child: Text(': ${dataSiswa["alamat"]}', style: fonts().googleSansBold(Colors.black, 16), softWrap: true),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('No. Telp.', style: fonts().googleSansRegular(Colors.black, 16), softWrap: true),
              SizedBox(width: 28),
              SizedBox(
                width: MediaQuery.of(context).size.width-220,
                child: Text(': ${dataSiswa["telp"]}', style: fonts().googleSansBold(Colors.black, 16), softWrap: true),
              ),
            ],
          ),
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

  deleteAkunSiswaConfirm(BuildContext context, String namaSiswa, int id) {
    String backOrNot = "back";

    Widget backButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 218, 131, 0),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: const Text("Kembali", style: TextStyle(color: Colors.white)),
      onPressed: () {
        backOrNot = "back";
        Navigator.pop(context);
      },
    );

    Widget deleteButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: const Text("Hapus", style: TextStyle(color: Colors.white)),
      onPressed: () async {
        backOrNot = "delete";
        await deleteAkunSiswa(id, context);
      },
    );

    AlertDialog details = AlertDialog(
      contentPadding: EdgeInsets.all(24),
      title: Text("Konfirmasi Hapus Akun Siswa", style: fonts().googleSansBold(Colors.black, 26), textAlign: TextAlign.center),
      content: Text("Apakah anda ingin menghapus akun \"${namaSiswa}\"?", style: fonts().googleSansRegular(Colors.black, 16), softWrap: true),
      actions: [backButton, deleteButton],
    );

    return showDialog(
      context: context,
      builder: (context) {
        return details;
      },
    ).then((value) {
      return backOrNot;
    });
  }
}
