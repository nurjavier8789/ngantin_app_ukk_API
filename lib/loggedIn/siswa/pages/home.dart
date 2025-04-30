import 'package:flutter/material.dart';

import '../../../misc/fonts.dart';
import 'subPages/detailStan.dart';
import '../misc/functions.dart';
import '../misc/widgets.dart';
import '../../userData.dart';
import '../../../api.dart';


class beranda extends StatefulWidget {
  const beranda({super.key});

  @override
  State<beranda> createState() => _berandaState();
}

class _berandaState extends State<beranda> {
  api _Api = new api();

  List dataStanList = [];
  List jumlahMenuPerStan = [];
  List gambarMenuPerStan = [];

  List foodMenu = [];
  List drinkMenu = [];

  fetchStan() async {
    int jumlahTemp = 0;
    List listTemp = [];

    dataStanList = dataStan().getDataStan();
    foodMenu = await getFood();
    drinkMenu = await getDrink();

    for (int h = 0; h < dataStanList.length; h++) {
      for (int i = 0; i < foodMenu.length; i++) {
        if (dataStanList[h]["id"] == foodMenu[i]["id_stan"]) {
          listTemp.add(foodMenu[i]["foto"]);
          jumlahTemp++;
        }
      }
      for (int i = 0; i < drinkMenu.length; i++) {
        if (dataStanList[h]["id"] == drinkMenu[i]["id_stan"]) {
          listTemp.add(drinkMenu[i]["foto"]);
          jumlahTemp++;
        }
      }
      jumlahMenuPerStan.add(jumlahTemp);
      jumlahTemp = 0;

      gambarMenuPerStan.add(listTemp);
      listTemp = [];
    }

    Future.delayed(Duration(seconds: 1));
    setState(() {});
  }

  @override
  void initState() {
    fetchStan();
    super.initState();
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
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () {
                      return Future.delayed(
                        Duration(seconds: 1), () async {
                          await fetchStan();
                        },
                      );
                    },
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        SizedBox(height: 28),
                        Center(
                          child: jumlahMenuPerStan.isEmpty ? Text("Memuat...") : Column(
                            children: [
                              for (int i = 0; i < dataStanList.length; i++)
                              Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(left: 28, right: 28, bottom: 16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Color.fromRGBO(240, 240, 240, 1.0),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => stanDetails(id: i, makanan: foodMenu, minuman: drinkMenu)));
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${dataStanList[i]["nama_stan"]}", style: fonts().googleSansBold(Colors.black, 20)),
                                        Text("${jumlahMenuPerStan[i]} Menu", style: fonts().googleSansRegular(Colors.black, 18)),
                                        SizedBox(height: 8),
                                        Container(
                                          height: 100,
                                          child: ListView(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            children: [
                                              for (int j = 0; j < jumlahMenuPerStan[i]; j++)
                                                Container(
                                                  margin: EdgeInsets.only(right: 12),
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(8),
                                                    child: Image.network("${_Api.baseUrlRil}${gambarMenuPerStan[i][j]}", height: 100, width: 100, fit: BoxFit.cover),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        )
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
                ),
              ],
            ),
            // Container(
            //   alignment: Alignment.bottomRight,
            //   margin: EdgeInsets.all(24),
            //   child: ElevatedButton(
            //     // onPressed: () {},
            //     onPressed: null,
            //     style: ElevatedButton.styleFrom(
            //       fixedSize: Size(110, 70),
            //       backgroundColor: Color.fromARGB(255, 218, 131, 0),
            //       foregroundColor: Colors.white,
            //
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(8),
            //       ),
            //     ),
            //     child: Row(
            //       children: [
            //         Icon(Icons.shopping_cart_outlined, color: Colors.white, size: 32),
            //         SizedBox(width: 12),
            //         Text("-", style: fonts().googleSansCustom(Colors.white, 24, FontWeight.bold)),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

