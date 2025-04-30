import 'package:flutter/material.dart';

import 'package:month_picker_dialog/month_picker_dialog.dart';

import '../../../../misc/fonts.dart';
import '../misc/functions.dart';
import '../misc/widgets.dart';

class orderPage extends StatefulWidget {
  const orderPage({super.key});

  @override
  State<orderPage> createState() => _orderPageState();
}

class _orderPageState extends State<orderPage> {
  String loadingPage = "Memuat Pesanan...";
  String getOrderStatusInit = 'Belum Dikonfirmasi';
  bool isLoading = true; // true = loading, vice versa

  List<String> getOrderStatusList = [
    'Belum Dikonfirmasi',
    'Dimasak',
    'Diantar',
    'Sampai',
  ];

  List orderDataNotComfirm = [];
  List orderDataCooking = [];
  List orderDataDelivery = [];
  List orderDataArrived = [];

  List orderDataNotConfirmFiltered = [];
  List orderDataCookingFiltered = [];
  List orderDataDeliveryFiltered = [];
  List orderDataArrivedFiltered = [];

  List allOrderData = [];

  String year = DateTime.now().year.toString();
  String month = DateTime.now().month.toString();
  late String dateFilter = "$year-$month";
  bool isFilterClear = true; // true = no filter, vice versa

  Color colorBackgroundON = Color.fromARGB(255, 218, 131, 0);
  Color colorBackgroundOFF = Colors.grey;
  Color colorIconON = Colors.white;
  Color colorIconOFF = Color.fromRGBO(200, 200, 200, 1.0);

  late Color colorBackgroundButton;
  late Color colorIconButton;

  checkFilter() {
    if (isFilterClear) {
      colorBackgroundButton = colorBackgroundOFF;
      colorIconButton = colorIconOFF;
    } else {
      colorBackgroundButton = colorBackgroundON;
      colorIconButton = colorIconON;
    }

    Future.delayed(Duration(seconds: 1));
    setState(() {});
  }

  fetchOrder() async {
    orderDataNotComfirm.clear();
    orderDataCooking.clear();
    orderDataDelivery.clear();
    orderDataArrived.clear();

    orderDataNotConfirmFiltered.clear();
    orderDataCookingFiltered.clear();
    orderDataDeliveryFiltered.clear();
    orderDataArrivedFiltered.clear();

    allOrderData.clear();
    isLoading = true;
    await Future.delayed(Duration(seconds: 1));
    setState(() {});

    if (isFilterClear) {
      orderDataNotComfirm = await getNotConfirmOrder();
      orderDataCooking = await getCookOrder();
      orderDataDelivery = await getDeliveredOrder();
      orderDataArrived = await getArriveOrder();
      allOrderData = [
        orderDataNotComfirm,  // 0 Belum Dikonfirmasi
        orderDataCooking,     // 1 Dimasak
        orderDataDelivery,    // 2 Diantar
        orderDataArrived      // 3 Sampai
      ];
    } else {
      orderDataNotComfirm = await getNotConfirmOrder();
      orderDataCooking = await getCookOrder();
      orderDataDelivery = await getDeliveredOrder();
      orderDataArrived = await getArriveOrder();

      for (int i = 0; i < orderDataNotComfirm.length; i++) {
        if (DateTime.parse(orderDataNotComfirm[i]["tanggal"]).year.toString() == year && DateTime.parse(orderDataNotComfirm[i]["tanggal"]).month.toString() == month) {
          orderDataNotConfirmFiltered.add(orderDataNotComfirm[i]);
        }
      }
      for (int i = 0; i < orderDataCooking.length; i++) {
        if (DateTime.parse(orderDataCooking[i]["tanggal"]).year.toString() == year && DateTime.parse(orderDataCooking[i]["tanggal"]).month.toString() == month) {
          orderDataCookingFiltered.add(orderDataCooking[i]);
        }
      }
      for (int i = 0; i < orderDataDelivery.length; i++) {
        if (DateTime.parse(orderDataDelivery[i]["tanggal"]).month.toString() == month && DateTime.parse(orderDataDelivery[i]["tanggal"]).year.toString() == year) {
          orderDataDeliveryFiltered.add(orderDataDelivery[i]);
        }
      }
      for (int i = 0; i < orderDataArrived.length; i++) {
        if (DateTime.parse(orderDataArrived[i]["tanggal"]).month.toString() == month && DateTime.parse(orderDataArrived[i]["tanggal"]).year.toString() == year) {
          orderDataArrivedFiltered.add(orderDataArrived[i]);
        }
      }

      allOrderData = [
        orderDataNotConfirmFiltered,  // 0 Belum Dikonfirmasi
        orderDataCookingFiltered,     // 1 Dimasak
        orderDataDeliveryFiltered,    // 2 Diantar
        orderDataArrivedFiltered      // 3 Sampai
      ];
    }

    await Future.delayed(Duration(seconds: 1));
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    getOrderStatusInit = "Belum Dikonfirmasi";
    isFilterClear = true;
    isLoading = true;
    checkFilter();
    fetchOrder();
    super.initState();
  }

  @override
  void dispose() {
    getOrderStatusInit = "Belum Dikonfirmasi";
    isFilterClear = true;
    isLoading = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 24, right: 24, top: 132),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 45,
                            width: 45,
                            margin: EdgeInsets.only(right: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: colorBackgroundButton,
                            ),
                            child: InkWell(
                              onTap: ()  async {
                                if (!isFilterClear) {
                                  isFilterClear = true;
                                  await checkFilter();
                                  await fetchOrder();
                                }
                              },
                              child: Icon(Icons.filter_alt_off, color: colorIconButton),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: isFilterClear ? Text("Tidak difilter", style: fonts().googleSansBold(Colors.black, 20),) : Text(
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
                                    lastDate: DateTime.now()
                                ).then((value) async {
                                  if (value != null) {
                                    isFilterClear = false;
                                    await checkFilter();
                                    setState(() {
                                      month = value.month.toString();
                                      year = value.year.toString();
                                    });
                                    dateFilter = "$year-$month";
                                    await fetchOrder();
                                    setState(() {});
                                  }
                                });
                              },
                              child: Icon(Icons.filter_alt, color: Colors.white, size: 28),
                            ),
                          ),
                        ],
                      ),
                      Divider(height: 30),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height-301,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Container(
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
                              value: getOrderStatusInit,
                              items: getOrderStatusList.map((String E) {
                                return DropdownMenuItem(
                                  value: E,
                                  child: Text(E),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  getOrderStatusInit = value!;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: EdgeInsets.only(left: 28, right: 28),
                        child: Center(
                          child: RefreshIndicator(
                            onRefresh: () {
                              return Future.delayed(Duration(seconds: 1), () async {
                                await fetchOrder();
                                setState(() {});
                              });
                            },
                            child: isLoading ? Text("Memuat Pesanan...", textAlign: TextAlign.center) : widgets().cardOrder(context, getOrderStatusInit, allOrderData),
                            // child: Container(),
                          ),
                        ),
                      ),
                    ],
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
                  child: Row(
                    children: [
                      Text("Pesanan", style: fonts().googleSansBold(Colors.black, 28)),
                      Expanded(child: Container()),
                      Container(
                        height: 45,
                        width: 45,
                        margin: EdgeInsets.only(left: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color.fromARGB(255, 218, 131, 0),
                        ),
                        child: InkWell(
                          onTap: () async {
                            await fetchOrder();
                          },
                          child: Icon(Icons.refresh, color: Colors.white, size: 28),
                        ),
                      ),
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
