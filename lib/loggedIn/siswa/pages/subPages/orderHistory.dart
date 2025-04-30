// For now this file is trash
// idk maybe in the future i'll use this

import 'package:flutter/material.dart';

import 'package:month_picker_dialog/month_picker_dialog.dart';

import '../../../../misc/fonts.dart';
import '../../misc/functions.dart';
import '../../misc/widgets.dart';

class orderHistory extends StatefulWidget {
  const orderHistory({super.key});

  @override
  State<orderHistory> createState() => _orderHistoryState();
}

class _orderHistoryState extends State<orderHistory> {
  String year = DateTime.now().year.toString();
  String month = DateTime.now().month.toString();
  late String dateFilter = "$year-$month";

  List allOrderHistory = [];
  bool isItLoading = true;

  fetchOrderHistory() async {
    isItLoading = true;
    allOrderHistory = [];

    await Future.delayed(Duration(seconds: 1));
    setState(() {});

    allOrderHistory = await getOrderHistory(dateFilter);
    isItLoading = false;

    await Future.delayed(Duration(seconds: 1));
    setState(() {});
  }

  @override
  void initState() {
    isItLoading = true;
    fetchOrderHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(left: 28, right: 28, top: 120),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                              "${month == "1" ? "Januari" : month == "2" ? "Februari" : month == "3" ? "Maret" : month == "4" ? "April" : month == "5" ? "Mei" : month == "6" ? "Juni"
                                  : month == "7" ? "Juli" : month == "8" ? "Agustus" : month == "9" ? "September" : month == "10" ? "Oktober" : month == "11" ? "November" : month == "12" ? "Desember"
                                  : "Bulan"
                              } - ${year}",
                              style: fonts().googleSansBold(Colors.black, 20)
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Container(
                        height: 45,
                        width: 45,
                        margin: EdgeInsets.only(left: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color.fromARGB(255, 218, 131, 0),
                        ),
                        child: InkWell(
                          onTap: () {
                            showMonthPicker(
                              context: context,
                              initialDate: DateTime(int.parse(year), int.parse(month)),
                              lastDate: DateTime.now(),
                            ).then((value) async {
                              if (value != null) {
                                setState(() {
                                  month = value.month.toString();
                                  year = value.year.toString();
                                });
                                dateFilter = "$year-$month";
                                await fetchOrderHistory();
                                setState(() {});
                              }
                            });
                          },
                          child: Icon(Icons.filter_alt, color: Colors.white, size: 28),
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 28),
                  SizedBox(
                    height: MediaQuery.of(context).size.height-231,
                    child: RefreshIndicator(
                      onRefresh: () {
                        return Future.delayed(Duration(seconds: 1), () async {
                          await fetchOrderHistory();
                        });
                      },
                      child: isItLoading ? Text("Memuat riwayat pesanan...") :
                      allOrderHistory.length == 0 ? Text("Tidak ada pesanan untuk saat ini") :
                      widgets().cardOrderHistory(context, allOrderHistory),
                    ),
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
                      Text("Riwayat Pesanan", style: fonts().googleSansBold(Colors.black, 28)),
                    ],
                  ),
                ),
                Divider(height: 0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

