import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../../../../misc/fonts.dart';
import '../../../../misc/styles.dart';
import '../../misc/functions.dart';

class orderDetail extends StatefulWidget {
  const orderDetail({super.key, required this.dataTransaksi});

  final Map dataTransaksi;

  @override
  State<orderDetail> createState() => _orderDetailState();
}

class _orderDetailState extends State<orderDetail> {
  var numberFormat = NumberFormat("#,###", "id_ID");

  num jumlah = 0;
  num totalHarga = 0;
  num totalHargaAkhir = 0;

  List itemName = [];
  List pricePerItem = [];

  String getOrderStatus = "Belum Dikonfirmasi";
  List<String> getOrderStatusList = [
    'Belum Dikonfirmasi',
    'Dimasak',
    'Diantar',
    'Sampai',
  ];

  totalItemAndPrice() {
    List listJumlah = List.filled(widget.dataTransaksi["detail_trans"].length, 0);

    for (int i = 0; i < widget.dataTransaksi["detail_trans"].length; i++) {
      jumlah += widget.dataTransaksi["detail_trans"][i]["qty"];
      listJumlah[i] = widget.dataTransaksi["detail_trans"][i]["qty"];
      totalHarga += widget.dataTransaksi["detail_trans"][i]["harga_beli"];
    }
  }

  totalHargaRealAkhir() {
    totalHargaAkhir += totalHarga;
  }

  getItemName() async {
    itemName = List.filled(widget.dataTransaksi["detail_trans"].length, "...");
    pricePerItem = List.filled(widget.dataTransaksi["detail_trans"].length, 0);

    for (int i = 0; i < widget.dataTransaksi["detail_trans"].length; i++) {
      itemName[i] = await getFoodNameThing(widget.dataTransaksi["detail_trans"][i]["id_menu"]);
      pricePerItem[i] = await getPriceThing(widget.dataTransaksi["detail_trans"][i]["id_menu"]);
    }

    Future.delayed(Duration(seconds: 1));
    setState(() {});
  }

  changeStatusDialog(int id) {
    Widget backButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 218, 131, 0),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: const Text("Kembali", style: TextStyle(color: Colors.white)),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    Widget changeButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: const Text("Ubah", style: TextStyle(color: Colors.white)),
      onPressed: () async {
        await changeStatus(context, id, getOrderStatus).then((value) {
          if (value == "belum dikonfirm") {
            widget.dataTransaksi["status"] = "belum dikonfirm";
          } else if (value == "dimasak") {
            widget.dataTransaksi["status"] = "dimasak";
          } else if (value == "diantar") {
            widget.dataTransaksi["status"] = "diantar";
          } else if (value == "sampai") {
            widget.dataTransaksi["status"] = "sampai";
          }
        });
        Future.delayed(Duration(seconds: 1));
        setState(() {});
      },
    );

    AlertDialog details = AlertDialog(
      contentPadding: EdgeInsets.all(24),
      title: Text("Ubah status pesanan", style: fonts().googleSansBold(Colors.black, 26), textAlign: TextAlign.center),
      content: Container(
        margin: EdgeInsets.only(left: 28, right: 28),
        child: InputDecorator(
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: EdgeInsets.only(right: 14, left: 14),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              isExpanded: true,
              style: fonts().googleSansRegular(Colors.black, 16),
              borderRadius: BorderRadius.circular(8),
              value: getOrderStatus,
              items: getOrderStatusList.map((String E) {
                return DropdownMenuItem(
                  value: E,
                  child: Text(E),
                );
              }).toList(),
              onChanged: (value) {
                getOrderStatus = value!;
                Navigator.pop(context);
                changeStatusDialog(id);
              },
            ),
          ),
        ),
      ),
      actions: [backButton, changeButton],
    );

    return showDialog(
      context: context,
      builder: (context) {
        return details;
      },
    );
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
                                style: fonts().googleSansBold(Colors.black, 18),
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
                                      ? Colors.deepOrangeAccent
                                      : widget.dataTransaksi["status"] == "diantar"
                                      ? Colors.orange
                                      : widget.dataTransaksi["status"] == "sampai"
                                      ? Colors.green
                                      : Colors.black,
                                  18,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 6),
                          Text(
                            "${jumlah} item - "
                                "Rp${numberFormat.format(totalHarga)}",
                            style: fonts().googleSansBold(Colors.black, 16),
                          ),
                          SizedBox(height: 18),
                          Divider(height: 0),
                          SizedBox(height: 18),
                          for (int i = 0; i < widget.dataTransaksi["detail_trans"].length; i++)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${widget.dataTransaksi["detail_trans"][i]["qty"]} x ${itemName[i]}",
                                      style: fonts().googleSansBold(Colors.black, 20),
                                      softWrap: true,
                                    ),
                                    Text("Rp${numberFormat.format(pricePerItem[i])}"),
                                    SizedBox(height: 8),
                                  ],
                                ),
                                Expanded(child: SizedBox()),
                                Text("Rp${numberFormat.format(widget.dataTransaksi["detail_trans"][i]["harga_beli"])}", style: fonts().googleSansBold(Colors.black, 16)),
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
                  Container(
                    margin: EdgeInsets.only(left: 24, right: 24),
                    child: ElevatedButton(
                      onPressed: () {
                        changeStatusDialog(widget.dataTransaksi["id"]);
                      },
                      style: style().buttonDefaultColor(20, FontWeight.bold),
                      child: Text("Ubah status pesanan"),
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

