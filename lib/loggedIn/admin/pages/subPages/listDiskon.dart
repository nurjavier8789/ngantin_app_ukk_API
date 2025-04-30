import 'package:flutter/material.dart';

import '../../../../misc/styles.dart';
import '../../../../misc/fonts.dart';
import 'subSubPages/addDiskon.dart';
import '../../misc/functions.dart';
import '../../misc/widgets.dart';

class listDiskon extends StatefulWidget {
  const listDiskon({super.key});

  @override
  State<listDiskon> createState() => _listDiskonState();
}

class _listDiskonState extends State<listDiskon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(right: 24, left: 24, top: 220),
              child: ListView(
                children: [
                  Center(child: Text("[This is List Data]")),
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
                      Text("Atur Diskon", style: fonts().googleSansBold(Colors.black, 28)),
                    ],
                  ),
                ),
                Divider(height: 0),
                Container(
                  margin: EdgeInsets.all(24),
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => addDiskonPage()));
                    },
                    style: style().buttonDefaultColor(18, FontWeight.bold),
                    child: Text("Tambah Diskon"),
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

