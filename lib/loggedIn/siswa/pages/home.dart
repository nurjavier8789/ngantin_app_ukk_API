import 'package:flutter/material.dart';

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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widgets().greeting(),
                    Text("Mau beli apa hari ini?", style: fonts().googleSansRegular(Colors.black, 16)),
                  ],
                ),
              ),
              Divider(height: 0),
              SizedBox(height: 28),
              foodData.isEmpty
                  ? Center(child: Text("Loading Menu..."))
                  : Center(
                child: Container(
                  height: MediaQuery.of(context).size.height-236,
                  child: ListView.builder(
                    itemCount: foodData.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            height: 100,
                            margin: EdgeInsets.only(left: 28, right: 28),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color.fromRGBO(240, 240, 240, 1.0),
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  child: foodData[index]["foto"].isEmpty ? Image.asset("assets/noImage.png", width: 100,) : Image.network("${_apiSiswa.baseUrlRil}${foodData[index]["foto"]}", width: 100),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                SizedBox(width: 16),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${foodData[index]["nama_makanan"]}'),
                                    Text('${foodData[index]["deskripsi"]}'),
                                    Text('Rp.${foodData[index]["harga"]}'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 12),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

