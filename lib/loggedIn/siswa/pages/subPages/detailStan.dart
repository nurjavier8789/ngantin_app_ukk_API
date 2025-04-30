import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../../../../misc/styles.dart';
import '../../../../misc/fonts.dart';
import '../../misc/widgets.dart';
import '../../../userData.dart';
import '../../../../api.dart';
import 'cart.dart';

class stanDetails extends StatefulWidget {
  stanDetails({super.key, required this.id, required this.makanan, required this.minuman});

  final int id;
  final List makanan;
  final List minuman;

  @override
  State<stanDetails> createState() => _stanDetailsState();
}

class _stanDetailsState extends State<stanDetails> {
  api _api = new api();
  var numberFormat = NumberFormat("#,###", "id_ID");

  List foodList = [];
  List drinkList = [];
  List jumlahItemCartFood = [];
  List jumlahItemCartDrink = [];
  late Map cart = {
    "id_stan": dataStan().getDataStan()[widget.id]["id"],
    "pesan": []
  };

  bool emptyCheck = false;

  buttonCheck() {
    for (int i = 0; i < jumlahItemCartFood.length; i++) {
      if (jumlahItemCartFood[i] >= 1) {
        emptyCheck = true;
        break;
      } else {
        for (int i = 0; i < jumlahItemCartDrink.length; i++) {
          if (jumlahItemCartDrink[i] >= 1) {
            emptyCheck = true;
            break;
          } else {
            emptyCheck = false;
          }
        }
      }
    }

    if (emptyCheck) {
      return () async {
        await insertToCart();
        Navigator.push(context, MaterialPageRoute(builder: (context) => cartPage(cartData: cart, dataMakanan: widget.makanan, dataMinuman: widget.minuman, id: widget.id)));
      };
    } else if (!emptyCheck) {
      return null;
    }
  }

  foodDrinkList() {
    foodList.clear();
    drinkList.clear();

    for (int i = 0; i < widget.makanan.length; i++) {
      if (widget.makanan[i]["id_stan"] == dataStan().getDataStan()[widget.id]["id"]) {
        foodList.add(widget.makanan[i]);
      }
    }
    for (int i = 0; i < widget.minuman.length; i++) {
      if (widget.minuman[i]["id_stan"] == dataStan().getDataStan()[widget.id]["id"]) {
        drinkList.add(widget.minuman[i]);
      }
    }

    jumlahItemCartFood = List.filled(foodList.length, 0);
    jumlahItemCartDrink = List.filled(drinkList.length, 0);

    Future.delayed(Duration(seconds: 1));
    setState(() {});
  }

  insertToCart() {
    cart["pesan"] = [];

    for (int i = 0; i < jumlahItemCartFood.length; i++) {
      if (jumlahItemCartFood[i] >= 1) {
        cart["pesan"] += [
          {
            "id_menu": foodList[i]["id_menu"],
            "qty": jumlahItemCartFood[i]
          }
        ];
      }
    }
    for (int i = 0; i < jumlahItemCartDrink.length; i++) {
      if (jumlahItemCartDrink[i] >= 1) {
        cart["pesan"] += [
          {
            "id_menu": drinkList[i]["id_menu"],
            "qty": jumlahItemCartDrink[i]
          }
        ];
      }
    }
  }

  @override
  void initState() {
    foodDrinkList();
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
              margin: EdgeInsets.only(left: 24, right: 24, top: 114),
              child: RefreshIndicator(
                onRefresh: () {
                  return Future.delayed(
                    Duration(seconds: 1), () async {
                      await foodDrinkList();
                    },
                  );
                },
                child: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Makanan", style: fonts().googleSansBold(Colors.black, 24)),
                        for (int j = 0; j < foodList.length; j++)
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(bottom: 16, top: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color.fromRGBO(240, 240, 240, 1.0),
                          ),
                          child: InkWell(
                            onTap: () {
                              widgets().showDetail(context, foodList, j);
                            },
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      ClipRRect(
                                        child: foodList[j]["foto"].isEmpty ? Image.asset("assets/noImage.png", width: 100,) : Image.network("${_api.baseUrlRil}${foodList[j]["foto"]}", fit: BoxFit.cover, width: 100, height: 100),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      SizedBox(width: 16),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width-270,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("${foodList[j]["nama_makanan"]}", style: fonts().googleSansBold(Colors.black, 20)),
                                            Text("${foodList[j]["deskripsi"]}", style: fonts().googleSansRegular(Colors.black, 12), softWrap: true, overflow: TextOverflow.ellipsis, maxLines: 2),
                                            SizedBox(height: 8),
                                            Text('Rp${numberFormat.format(foodList[j]["harga"])}', style: fonts().googleSansBold(Colors.black, 16)),
                                          ],
                                        ),
                                      ),
                                      Expanded(child: Container()),
                                      Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                jumlahItemCartFood[j]++;
                                                buttonCheck();

                                                Future.delayed(Duration(seconds: 1));
                                                setState(() {});
                                              });
                                            },
                                            child: Container(
                                              width: 35,
                                              height: 35,
                                              decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              child: Icon(Icons.add, color: Colors.white, size: 18),
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text("${jumlahItemCartFood[j]}", style: fonts().googleSansBold(Colors.black, 14)),
                                          SizedBox(height: 4),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                if (jumlahItemCartFood[j] > 0) {
                                                  jumlahItemCartFood[j]--;
                                                }
                                                buttonCheck();

                                                Future.delayed(Duration(seconds: 1));
                                                setState(() {});
                                              });
                                            },
                                            child: Container(
                                              width: 35,
                                              height: 35,
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              child: Icon(Icons.delete, color: Colors.white, size: 18),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Divider(height: 0),
                        SizedBox(height: 16),
                        Text("Minuman", style: fonts().googleSansBold(Colors.black, 24)),
                        for (int j = 0; j < drinkList.length; j++)
                          Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(bottom: 16, top: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color.fromRGBO(240, 240, 240, 1.0),
                          ),
                          child: InkWell(
                            onTap: () {
                              widgets().showDetail(context, drinkList, j);
                            },
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      ClipRRect(
                                        child: drinkList[j]["foto"].isEmpty ? Image.asset("assets/noImage.png", width: 100,) : Image.network("${_api.baseUrlRil}${drinkList[j]["foto"]}", fit: BoxFit.cover, width: 100, height: 100),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      SizedBox(width: 16),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width-270,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("${drinkList[j]["nama_makanan"]}", style: fonts().googleSansBold(Colors.black, 20)),
                                            Text("${drinkList[j]["deskripsi"]}", style: fonts().googleSansRegular(Colors.black, 12), softWrap: true, overflow: TextOverflow.ellipsis, maxLines: 2),
                                            SizedBox(height: 8),
                                            Text('Rp${numberFormat.format(drinkList[j]["harga"])}', style: fonts().googleSansBold(Colors.black, 16)),
                                          ],
                                        ),
                                      ),
                                      Expanded(child: Container()),
                                      Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                jumlahItemCartDrink[j]++;
                                                buttonCheck();
                                              });
                                            },
                                            child: Container(
                                              width: 35,
                                              height: 35,
                                              decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              child: Icon(Icons.add, color: Colors.white, size: 18),
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text("${jumlahItemCartDrink[j]}", style: fonts().googleSansBold(Colors.black, 14)),
                                          SizedBox(height: 4),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                if (jumlahItemCartDrink[j] > 0) {
                                                  jumlahItemCartDrink[j]--;
                                                }
                                                buttonCheck();
                                              });
                                            },
                                            child: Container(
                                              width: 35,
                                              height: 35,
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              child: Icon(Icons.delete, color: Colors.white, size: 18),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 64),
                      ],
                    ),
                  ],
                ),
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
                      Text("Stan ${dataStan().getDataStan()[widget.id]["nama_stan"]}", style: fonts().googleSansBold(Colors.black, 28), overflow: TextOverflow.ellipsis, maxLines: 1),
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
                  onPressed: buttonCheck(),
                  style: style().buttonDefaultColor(20, FontWeight.bold),
                  child: Text("Tinjau pesanan"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

