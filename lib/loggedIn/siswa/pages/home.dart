import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../misc/widgets.dart';
import '../misc/functions.dart';
import '../../../misc/fonts.dart';
import '../../../api.dart';

class beranda extends StatefulWidget {
  const beranda({super.key});

  @override
  State<beranda> createState() => _berandaState();
}

class _berandaState extends State<beranda> {
  apiSiswa _apiSiswa = new apiSiswa();

  List foodData = [];
  List drinkData = [];


  var numberFormat = NumberFormat("#,###", "id_ID");

  _getFoodandBeverage() async {
    foodData = await getFood();
    drinkData = await getDrink();

    await Future.delayed(Duration(seconds: 1));
    setState(() {});
  }

  @override
  void initState() {
    _getFoodandBeverage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          initialIndex: 0,
          animationDuration: Duration(milliseconds: 150),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(28),
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widgets().greeting(),
                    Text("Mau beli apa hari ini?", style: fonts().googleSansRegular(Colors.black, 16)),
                  ],
                ),
              ),
              Divider(height: 0),
              TabBar(
                indicatorColor: Color.fromARGB(255, 218, 131, 0),
                labelStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                unselectedLabelStyle: TextStyle(color: Color.fromARGB(255, 100, 100, 100)),
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 1,
                tabs: [
                  Tab(text: "Makanan"),
                  Tab(text: "Minuman"),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    RefreshIndicator(
                      onRefresh: () {
                        return Future.delayed(
                          Duration(seconds: 1), () {
                            _getFoodandBeverage();
                          },
                        );
                      },
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          SizedBox(height: 28),
                          foodData.isEmpty
                              ? Center(child: Text("Memuat Menu..."))
                              : Center(
                            child: Column(
                              children: [
                                for (int i = 0; i < foodData.length; i++)
                                Container(
                                  height: 100,
                                  margin: EdgeInsets.only(left: 28, right: 28, bottom: 16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color.fromRGBO(240, 240, 240, 1.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 16),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          child: foodData[i]["foto"].isEmpty ? Image.asset("assets/noImage.png", width: 100,) : Image.network("${_apiSiswa.baseUrlRil}${foodData[i]["foto"]}", fit: BoxFit.cover, width: 100, height: 100),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        SizedBox(width: 16),
                                        Container(
                                          width: MediaQuery.of(context).size.width-266,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('${foodData[i]["nama_makanan"]}', style: fonts().googleSansBold(Colors.black, 14), softWrap: true),
                                              Text('${foodData[i]["deskripsi"]}', style: fonts().googleSansRegular(Colors.black, 14), softWrap: true, maxLines: 1, overflow: TextOverflow.ellipsis),
                                              Text('Rp${numberFormat.format(foodData[i]["harga"])}', style: fonts().googleSansRegular(Colors.black, 14)),
                                            ],
                                          ),
                                        ),
                                        Expanded(child: Container()),
                                        Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: Color.fromARGB(255, 218, 131, 0),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          alignment: Alignment.center,
                                          child: InkWell(
                                            onTap: () {
                                              widgets().showDetail(context, foodData, i);
                                            },
                                            child: Icon(Icons.info, color: Colors.white),
                                          ),
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

                    RefreshIndicator(
                      onRefresh: () {
                        return Future.delayed(
                          Duration(seconds: 1), () {
                            _getFoodandBeverage();
                          },
                        );
                      },
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          SizedBox(height: 28),
                          drinkData.isEmpty
                              ? Center(child: Text("Memuat Menu..."))
                              : Center(
                            child: Column(
                              children: [
                                for (int i = 0; i < drinkData.length; i++)
                                  Container(
                                    height: 100,
                                    margin: EdgeInsets.only(left: 28, right: 28, bottom: 16),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Color.fromRGBO(240, 240, 240, 1.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 16),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            child: drinkData[i]["foto"].isEmpty ? Image.asset("assets/noImage.png", width: 100,) : Image.network("${_apiSiswa.baseUrlRil}${drinkData[i]["foto"]}", fit: BoxFit.cover, width: 100, height: 100),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          SizedBox(width: 16),
                                          Container(
                                            width: MediaQuery.of(context).size.width-266,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('${drinkData[i]["nama_makanan"]}', style: fonts().googleSansBold(Colors.black, 14), softWrap: true),
                                                Text('${drinkData[i]["deskripsi"]}', style: fonts().googleSansRegular(Colors.black, 14), softWrap: true, maxLines: 1, overflow: TextOverflow.ellipsis),
                                                Text('Rp${numberFormat.format(drinkData[i]["harga"])}', style: fonts().googleSansRegular(Colors.black, 14)),
                                              ],
                                            ),
                                          ),
                                          Expanded(child: Container()),
                                          Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(255, 218, 131, 0),
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            alignment: Alignment.center,
                                            child: InkWell(
                                              onTap: () {
                                                widgets().showDetail(context, drinkData, i);
                                              },
                                              child: Icon(Icons.info, color: Colors.white),
                                            ),
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

