import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../../../../misc/styles.dart';
import '../../../../misc/fonts.dart';
import '../../misc/functions.dart';
import '../../../userData.dart';

class cartPage extends StatefulWidget {
  cartPage({super.key, required this.cartData, required this.dataMakanan, required this.dataMinuman, required this.id});

  final int id;
  Map cartData = {};
  final List dataMakanan;
  final List dataMinuman;

  @override
  State<cartPage> createState() => _cartPageState();
}

class _cartPageState extends State<cartPage> {
  var numberFormat = NumberFormat("#,###", "id_ID");

  int grandTotal = 0;

  getNamaBarang(int idMenu) {
    for (int i = 0; i < widget.dataMakanan.length; i++) {
      if (widget.dataMakanan[i]["id_menu"] == idMenu) {
        return widget.dataMakanan[i]["nama_makanan"];
      } else {
        for (int i = 0; i < widget.dataMinuman.length; i++) {
          if (widget.dataMinuman[i]["id_menu"] == idMenu) {
            return widget.dataMinuman[i]["nama_makanan"];
          }
        }
      }
    }
  }

  getHargaBarang(int idMenu) {
    for (int i = 0; i < widget.dataMakanan.length; i++) {
      if (widget.dataMakanan[i]["id_menu"] == idMenu) {
        return widget.dataMakanan[i]["harga"];
      } else {
        for (int i = 0; i < widget.dataMinuman.length; i++) {
          if (widget.dataMinuman[i]["id_menu"] == idMenu) {
            return widget.dataMinuman[i]["harga"];
          }
        }
      }
    }
  }

  countTotalHarga(int jumlah, int harga) {
    int total = jumlah * harga;
    grandTotal += total;
    return total;
  }

  @override
  void initState() {
    grandTotal = 0;
    super.initState();
  }

  @override
  void dispose() {
    grandTotal = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(left: 24, right: 24, top: 114),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Text("Stan ${dataStan().getDataStan()[widget.id]["nama_stan"]}", style: fonts().googleSansBold(Colors.black, 20)),
                  SizedBox(height: 16),
                  Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Nama Barang", style: fonts().googleSansRegular(Colors.black, 16)),
                              Text("QTY | Harga per item", style: fonts().googleSansBold(Colors.black, 16)),
                            ],
                          ),
                          SizedBox(width: 16),
                          Expanded(child: Divider(thickness: 1, color: Colors.black,)),
                          SizedBox(width: 16),
                          Text("Total harga", style: fonts().googleSansBold(Colors.black, 16)),
                        ],
                      ),
                      SizedBox(height: 8),
                      Divider(height: 0),
                      SizedBox(height: 8),
                      Divider(thickness: 4, height: 0),
                      SizedBox(height: 8),
                    ],
                  ),
                  for (int i = 0; i < widget.cartData["pesan"].length; i++)
                  Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(getNamaBarang(widget.cartData["pesan"][i]["id_menu"]), style: fonts().googleSansRegular(Colors.black, 16)),
                              Text("${widget.cartData["pesan"][i]["qty"]}x | Rp${numberFormat.format(getHargaBarang(widget.cartData["pesan"][i]["id_menu"]))}", style: fonts().googleSansBold(Colors.black, 16)),
                            ],
                          ),
                          SizedBox(width: 16),
                          Expanded(child: Divider(thickness: 1, color: Colors.black,)),
                          SizedBox(width: 16),
                          Text("Rp${numberFormat.format(countTotalHarga(widget.cartData["pesan"][i]["qty"], getHargaBarang(widget.cartData["pesan"][i]["id_menu"])))}", style: fonts().googleSansBold(Colors.black, 16)),
                        ],
                      ),
                      SizedBox(height: 8),
                      Divider(height: 0),
                      SizedBox(height: 8),
                    ],
                  ),
                  Divider(height: 0, thickness: 4),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Text("Total Akhir", style: fonts().googleSansBold(Colors.black, 20)),
                      SizedBox(width: 16),
                      Expanded(child: Divider(thickness: 1, color: Colors.black,)),
                      SizedBox(width: 16),
                      Text("Rp.${numberFormat.format(grandTotal)}", style: fonts().googleSansBold(Colors.black, 20)),
                    ],
                  ),
                ],
              ),
            ),

            Column(
              children: [
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(28),
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
                      Text("Konfirmasi Pesanan", style: fonts().googleSansBold(Colors.black, 28)),
                    ],
                  ),
                ),
                Divider(height: 0),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 70,
                padding: EdgeInsets.all(12),
                child: ElevatedButton(
                  onPressed: () {
                    sendOrder(widget.cartData, context);
                  },
                  style: style().buttonDefaultColor(20, FontWeight.bold),
                  child: Text("Pesan"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

