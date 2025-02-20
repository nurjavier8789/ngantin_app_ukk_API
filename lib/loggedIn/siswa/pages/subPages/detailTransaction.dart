import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../../../../misc/fonts.dart';
import '../../misc/functions.dart';

class detailTransaction extends StatefulWidget {
  detailTransaction({super.key, required this.dataTransaksi});

  final Map dataTransaksi;

  @override
  State<detailTransaction> createState() => _detailTransactionState();
}

class _detailTransactionState extends State<detailTransaction> {
  var numberFormat = NumberFormat("#,###", "id_ID");
  num jumlah = 0;
  num totalHarga = 0;
  num totalHargaAkhir = 0;

  List itemName = [];

  totalItemAndPrice() {
    for (int i = 0; i < widget.dataTransaksi["detail_trans"].length; i++) {
      jumlah += widget.dataTransaksi["detail_trans"][i]["qty"];
      totalHarga += widget.dataTransaksi["detail_trans"][i]["harga_beli"];
    }
  }

  totalHargaRealAkhir() {
    totalHargaAkhir += totalHarga;
  }

  getItemName() async {
    itemName = List.filled(widget.dataTransaksi["detail_trans"].length, "...");
    for (int i = 0; i < widget.dataTransaksi["detail_trans"].length; i++) {
      itemName[i] = await getFoodNameThing(widget.dataTransaksi["detail_trans"][i]["id_menu"]);
    }
    Future.delayed(Duration(seconds: 1));
    setState(() {});
  }

  @override
  void initState() {
    getItemName();
    Future.delayed(Duration(seconds: 1));
    totalItemAndPrice();
    Future.delayed(Duration(seconds: 1));
    totalHargaRealAkhir();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Color.fromARGB(255, 218, 131, 0),
                      ),
                      child: Icon(Icons.arrow_back_rounded, size: 26, color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 24),
                  Text("Detail Pesanan", style: fonts().googleSansBold(Colors.black, 28)),
                ],
              ),
            ),
            Divider(height: 0),

            SizedBox(
              height: MediaQuery.of(context).size.height-122,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Card(
                    margin: EdgeInsets.all(26),
                    child: Container(
                      padding: EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Pesanan ${DateTime.parse(widget.dataTransaksi["tanggal"]).day.toString().padLeft(2, "0")}/"
                                    "${DateTime.parse(widget.dataTransaksi["tanggal"]).month.toString().padLeft(2, "0")}/"
                                    "${DateTime.parse(widget.dataTransaksi["tanggal"]).year}",
                                style: fonts().googleSansBold(Colors.black, 19),
                              ),
                              Text(
                                widget.dataTransaksi["status"] == "belum dikonfirm"
                                        ? "Belum Dikonfirmasi"
                                    : widget.dataTransaksi["status"] == "dimasak"
                                        ? "Dimasak"
                                    : widget.dataTransaksi["status"] == "diantar"
                                        ? "Diantar"
                                    : widget.dataTransaksi["status"] == "sampai"
                                        ? "Sampai"
                                    : "-",
                                style: fonts().googleSansBold(
                                    widget.dataTransaksi["status"] == "belum dikonfirm"
                                        ? Colors.red
                                      : widget.dataTransaksi["status"] == "dimasak"
                                        ? Colors.amber
                                      : widget.dataTransaksi["status"] == "diantar"
                                        ? Colors.amber
                                      : widget.dataTransaksi["status"] == "sampai"
                                        ? Colors.green
                                      : Colors.black,
                                    19,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            "${jumlah} item - "
                            "Rp${numberFormat.format(totalHarga)}",
                            style: fonts().googleSansBold(Colors.black, 16),
                          ),
                          SizedBox(height: 18),
                          Divider(height: 0),
                          SizedBox(height: 18),
                          for (int i = 0; i < widget.dataTransaksi["detail_trans"].length; i++)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${widget.dataTransaksi["detail_trans"][i]["qty"]} x ${itemName[i]}",
                                style: fonts().googleSansBold(Colors.black, 20),
                                softWrap: true,
                              ),
                              Text("Rp${numberFormat.format(widget.dataTransaksi["detail_trans"][i]["harga_beli"])}"),
                              SizedBox(height: 8),
                            ],
                          ),
                          SizedBox(height: 10),
                          Divider(height: 0),
                          SizedBox(height: 18),
                          Text('Detail Pembayaran', style: fonts().googleSansBold(Colors.black, 18), softWrap: true,),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Subtotal", style: fonts().googleSansRegular(Colors.black38, 16)),
                              Text("Rp${numberFormat.format(totalHarga)}", style: fonts().googleSansBold(Colors.black, 16)),
                            ],
                          ),
                          SizedBox(height: 18),
                          Divider(height: 0),
                          SizedBox(height: 18),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total', style: fonts().googleSansBold(Colors.black, 18), softWrap: true,),
                              Text('Rp${numberFormat.format(totalHargaAkhir)}', style: fonts().googleSansBold(Colors.black, 18), softWrap: true,),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
