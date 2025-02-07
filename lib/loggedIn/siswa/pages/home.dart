import 'package:flutter/material.dart';
import 'package:yukan_app_ukk/misc/styles.dart';

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

  _getFoodandBeverage() async {
    foodData = await getFood();

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
            ListView(
              shrinkWrap: true,
              children: [
                SizedBox(height: 28),

                foodData.isEmpty
                    ? Center(child: Text("Loading Menu..."))
                    : Center(
                  child: Column(
                    children: [
                      Column(
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
                              padding: const EdgeInsets.only(left: 16, right: 16),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    child: foodData[i]["foto"].isEmpty ? Image.asset("assets/noImage.png", width: 100,) : Image.network("${_apiSiswa.baseUrlRil}${foodData[i]["foto"]}", width: 100),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  SizedBox(width: 16),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('${foodData[i]["nama_makanan"]}', style: fonts().googleSansBold(Colors.black, 14), softWrap: true),
                                      Text('${foodData[i]["deskripsi"]}', softWrap: true),
                                      Text('Rp.${foodData[i]["harga"]}'),
                                    ],
                                  ),
                                  Expanded(child: Container()),
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    alignment: Alignment.center,
                                    child: InkWell(
                                      onTap: () {
                                        print(i);
                                      },
                                      child: Text("+", style: fonts().googleSansBold(Colors.white, 28)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

