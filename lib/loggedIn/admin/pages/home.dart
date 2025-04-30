import 'package:flutter/material.dart';

import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:intl/intl.dart';
import 'package:yukan_app_ukk/loggedIn/admin/misc/functions.dart';

import '../../../misc/fonts.dart';
import '../misc/widgets.dart';

class beranda extends StatefulWidget {
  const beranda({super.key});

  @override
  State<beranda> createState() => _berandaState();
}

class _berandaState extends State<beranda> {
  String year = DateTime.now().year.toString();
  String month = DateTime.now().month.toString();
  late String dateFilter = "$year-$month";

  var numberFormat = NumberFormat("#,###", "id_ID");

  Map resultResponse = {};
  int totalPendapatanReal = 0;
  bool fetching = true; // true = loading, vice versa

  fetchIncome() async {
    totalPendapatanReal = 0;
    fetching = true;
    resultResponse = await getPemasukan(dateFilter);

    for (int i = 0; i < resultResponse["data_transaksi"].length; i++) {
      for (int j = 0; j < resultResponse["data_transaksi"][i]["detailTrans"].length; j++) {
        totalPendapatanReal = resultResponse["data_transaksi"][i]["detailTrans"][j]["harga_beli"] + totalPendapatanReal;
      }
    }

    fetching = false;

    Future.delayed(Duration(seconds: 1));
    setState(() {});
  }

  @override
  void initState() {
    fetchIncome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              shrinkWrap: true,
              children: [
                SizedBox(height: 112),
                Card(
                  margin: EdgeInsets.all(28),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Pemasukan Bulan Ini", style: fonts().googleSansBold(Colors.black, 20)),
                            InkWell(
                              onTap: () async {
                                await fetchIncome();
                              },
                              child: Icon(Icons.refresh_rounded),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Divider(height: 0),
                        SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () async {
                                int monthS = int.parse(month);
                                int yearS = int.parse(year);
                                monthS--;
                                if (monthS < 1) {
                                  yearS--;
                                  monthS = 12;
                                }
                                month = monthS.toString();
                                year = yearS.toString();
                                dateFilter = "$year-$month";
                                setState(() {});
                                await fetchIncome();
                                setState(() {});
                              },
                              child: Icon(Icons.arrow_back_ios_new_rounded),
                            ),
                            InkWell(
                              onTap: () {
                                showMonthPicker(
                                  context: context,
                                  initialDate: DateTime(int.parse(year), int.parse(month)),
                                  lastDate: DateTime.now()
                                ).then((value) async {
                                  if (value != null) {
                                    setState(() {
                                      month = value.month.toString();
                                      year = value.year.toString();
                                    });
                                    dateFilter = "$year-$month";
                                    setState(() {});
                                  }
                                });
                              },
                              child: Text(
                                  "${month == "1" ? "Januari" : month == "2" ? "Februari" : month == "3" ? "Maret" : month == "4" ? "April" : month == "5" ? "Mei" : month == "6" ? "Juni"
                                      : month == "7" ? "Juli" : month == "8" ? "Agustus" : month == "9" ? "September" : month == "10" ? "Oktober" : month == "11" ? "November" : month == "12" ? "Desember"
                                      : "Bulan"
                                  } - ${year}",
                                style: fonts().googleSansBold(Colors.black, 24),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                if (DateTime.now().month > int.parse(month) || DateTime.now().year > int.parse(year)) {
                                  int monthS = int.parse(month);
                                  int yearS = int.parse(year);
                                  monthS++;
                                  if (monthS > 12) {
                                    yearS++;
                                    monthS = 1;
                                  }
                                  month = monthS.toString();
                                  year = yearS.toString();
                                  dateFilter = "$year-$month";
                                  setState(() {});
                                  await fetchIncome();
                                  setState(() {});
                                }
                              },
                              child: Icon(Icons.arrow_forward_ios_rounded),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        Row(
                          children: [
                            Text("Total pendapatan: ", style: fonts().googleSansRegular(Colors.black, 20)),
                            Text(
                              fetching == true ? "..." :
                              "Rp${numberFormat.format(totalPendapatanReal)}",
                              style: fonts().googleSansBold(Colors.black, 20),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Pesanan yang masuk: ", style: fonts().googleSansRegular(Colors.black, 20)),
                            Text(
                              fetching == true ? "..." :
                              "${resultResponse["data_transaksi"].length}",
                              style: fonts().googleSansBold(Colors.black, 20),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(28),
                  alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widgets().greeting(),
                      Text("Bagaimana penjualan hari ini?", style: fonts().googleSansRegular(Colors.black, 16)),
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

