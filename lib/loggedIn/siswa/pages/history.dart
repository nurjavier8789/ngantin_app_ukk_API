import 'package:flutter/material.dart';
import 'package:yukan_app_ukk/loggedIn/siswa/misc/functions.dart';

import '../misc/widgets.dart';
import '../../../misc/fonts.dart';

class pesanan extends StatefulWidget {
  const pesanan({super.key});

  @override
  State<pesanan> createState() => _pesananState();
}

class _pesananState extends State<pesanan> {

  String getOrderStatusInit = 'Semua';

  List<String> getOrderStatusList = [
    'Belum Dikonfirmasi',
    'Dimasak',
    'Diantar',
    'Sampai',
  ];

  List notConfirmOrderData = [];
  List cookOrderData = [];
  List sentOrderData = [];
  List arriveOrderData = [];
  List allOrderData = [];

  fetchOrder() async {
    notConfirmOrderData = await getNotConfirmOrder();
    cookOrderData = await getCookOrder();
    sentOrderData = await getDeliveredOrder();
    arriveOrderData = await getArriveOrder();
    allOrderData = [
      notConfirmOrderData,  // 0 Belum Dikonfirmasi
      cookOrderData,        // 1 Dimasak
      sentOrderData,        // 2 Diantar
      arriveOrderData       // 3 Sampai
    ];

    await Future.delayed(Duration(seconds: 1));
    setState(() {});
  }

  @override
  void initState() {
    getOrderStatusInit = "Belum Dikonfirmasi";
    fetchOrder();
    super.initState();
  }

  @override
  void dispose() {
    getOrderStatusInit = "Belum Dikonfirmasi";
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(28),
              child: Text("Pesanan", style: fonts().googleSansBold(Colors.black, 28)),
            ),
            Divider(height: 0),
            SizedBox(height: 28),
            Container(
              margin: EdgeInsets.only(left: 28, right: 28),
              child: InputDecorator(
                decoration: widgets().dropDownDecoration_history(),
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
            SizedBox(height: 28),
            if (allOrderData.isEmpty)
              Center(child: Text("Memuat Pesanan..."))
            else Padding(
              padding: EdgeInsets.only(left: 28, right: 28),
              child: Center(
                child: RefreshIndicator(
                  onRefresh: () {
                    return Future.delayed(Duration(seconds: 1), () {
                      fetchOrder();
                      setState(() {});
                    });
                  },
                  child: widgets().cardOrder(context, getOrderStatusInit, allOrderData),
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}

