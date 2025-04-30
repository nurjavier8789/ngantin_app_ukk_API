import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../../../admin/misc/widgets.dart';
import '../../../../misc/styles.dart';
import '../../../../misc/fonts.dart';
import '../../misc/functions.dart';
import 'subSubPages/editMenu.dart';
import 'subSubPages/addMenu.dart';
import '../../../../api.dart';

class listMenu extends StatefulWidget {
  const listMenu({super.key});

  @override
  State<listMenu> createState() => _listMenuState();
}

class _listMenuState extends State<listMenu> {
  api _api = api();

  var numberFormat = NumberFormat("#,###", "id_ID");

  List foodData = [];
  List drinkData = [];
  List pickUpData = [];

  String statusList = "Memuat menu...";

  _separateTypes() async {
    statusList = "Memuat menu...";
    foodData = [];
    drinkData = [];
    setState(() {});

    pickUpData = await showListMenu();

    if (pickUpData.isNotEmpty) {
      for (int i = 0; i < pickUpData.length; i++) {
        if (pickUpData[i]["jenis"] == "makanan") {
          foodData.add(pickUpData[i]);
        } else if (pickUpData[i]["jenis"] == "minuman") {
          drinkData.add(pickUpData[i]);
        }
      }
    } else {
      statusList = "Tidak ada menu";
    }

    await Future.delayed(Duration(seconds: 1));
    setState(() {});
  }

  @override
  void initState() {
    _separateTypes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          initialIndex: 0,
          animationDuration: Duration(milliseconds: 150),
          child: Column(
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
                    Text("Atur Menu", style: fonts().googleSansBold(Colors.black, 28)),
                  ],
                ),
              ),
              Divider(height: 0),
              Container(
                margin: EdgeInsets.all(24),
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => addMenuPage())).then((value) {
                      _separateTypes();
                    });
                  },
                  style: style().buttonDefaultColor(18, FontWeight.bold),
                  child: Text("Tambah Menu"),
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
                          _separateTypes();
                        },
                        );
                      },
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          SizedBox(height: 28),
                          if (foodData.isEmpty)
                            Center(child: Text(statusList))
                          else Center(
                            child: Column(
                              children: [
                                for (int i = 0; i < foodData.length; i++)
                                  InkWell(
                                    onTap: () {
                                      widgets().showDetailMenu(context, foodData, i);
                                    },
                                    child: Container(
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
                                              child: foodData[i]["foto"].isEmpty ? Image.asset("assets/noImage.png", width: 100,) : Image.network("${_api.baseUrlRil}${foodData[i]["foto"]}", fit: BoxFit.cover, width: 100, height: 100),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            SizedBox(width: 16),
                                            Container(
                                              width: MediaQuery.of(context).size.width-290,
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
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => editMenuPage(foodData: foodData[i]))).then((value) {
                                                    _separateTypes();
                                                  });
                                                },
                                                child: Icon(Icons.edit, color: Colors.white),
                                              ),
                                            ),
                                            SizedBox(width: 12),
                                            Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              alignment: Alignment.center,
                                              child: InkWell(
                                                onTap: () {
                                                  widgets().deleteMenuConfirm(context, foodData[i]["nama_makanan"], foodData[i]["id"]).then((value) {
                                                    if (value == "delete") {
                                                      _separateTypes();
                                                    }
                                                  });
                                                },
                                                child: Icon(Icons.delete, color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
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
                            _separateTypes();
                          },
                        );
                      },
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          SizedBox(height: 28),
                          if (drinkData.isEmpty)
                            Center(child: Text(statusList))
                          else Center(
                            child: Column(
                              children: [
                                for (int i = 0; i < drinkData.length; i++)
                                  InkWell(
                                    onTap: () {
                                      widgets().showDetailMenu(context, drinkData, i);
                                    },
                                    child: Container(
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
                                              child: drinkData[i]["foto"].isEmpty ? Image.asset("assets/noImage.png", width: 100,) : Image.network("${_api.baseUrlRil}${drinkData[i]["foto"]}", fit: BoxFit.cover, width: 100, height: 100),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            SizedBox(width: 16),
                                            Container(
                                              width: MediaQuery.of(context).size.width-290,
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
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => editMenuPage(foodData: drinkData[i]))).then((value) {
                                                    _separateTypes();
                                                  });
                                                },
                                                child: Icon(Icons.edit, color: Colors.white),
                                              ),
                                            ),
                                            SizedBox(width: 12),
                                            Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              alignment: Alignment.center,
                                              child: InkWell(
                                                onTap: () {
                                                  widgets().deleteMenuConfirm(context, drinkData[i]["nama_makanan"], drinkData[i]["id"]).then((value) {
                                                    if (value == "delete") {
                                                      _separateTypes();
                                                    }
                                                  });
                                                },
                                                child: Icon(Icons.delete, color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
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

