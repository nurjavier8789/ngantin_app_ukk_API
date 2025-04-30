import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../pages/subPages/detailTransaction.dart';
import '../../../misc/styles.dart';
import '../../../misc/fonts.dart';
import '../../userData.dart';
import '../../../api.dart';

apiSiswa _apiSiswa = new apiSiswa();
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

  showDetail(BuildContext context, List foodData, int idFood) {
    String namaStan = "";

    for (int i = 0; i < dataStan().getDataStan().length; i++) {
      if (foodData[idFood]["id_stan"] == dataStan().getDataStan()[i]["id"]) {
        namaStan = dataStan().getDataStan()[i]["nama_stan"];
      }
    }

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
            child: Column(
              children: [
                Text('Stan $namaStan', style: fonts().googleSansBold(Colors.black, 20), softWrap: true, textAlign: TextAlign.center),
                SizedBox(height: 12),
                ClipRRect(
                  child: foodData[idFood]["foto"].isEmpty ? Image.asset("assets/noImage.png", width: 100,) : Image.network("${_apiSiswa.baseUrlRil}${foodData[idFood]["foto"]}", fit: BoxFit.cover, width: 1080, height: 200),
                  borderRadius: BorderRadius.circular(8),
                ),
              ],
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

  // -= PESANAN =- //

  InputDecoration dropDownDecoration_history() {
    return InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      contentPadding: EdgeInsets.only(right: 14, left: 14),
    );
  }

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
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => detailTransaction(dataTransaksi: dataOrder[showFiltered][i],)));
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
            SizedBox(height: 24),
          ],
        ),
      );
    }
  }

  cardOrderHistory(BuildContext context, List dataOrder) {
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
                        style: fonts().googleSansBold(
                          dataOrder[i]["status"].contains("belum dikonfirm") ? Colors.red :
                          dataOrder[i]["status"].contains("dimasak") ? Colors.deepOrangeAccent :
                          dataOrder[i]["status"].contains("diantar") ? Colors.orange :
                          dataOrder[i]["status"].contains("sampai") ? Colors.green :
                          Colors.black,
                          18,
                        ),
                      ),
                    ],
                  ),
                  Text("Dipesan oleh ${dataOrder[i]["nama_siswa"]}"),
                ],
              ),
            ),
          ),
        SizedBox(height: 12),
      ],
    );
  }
}
