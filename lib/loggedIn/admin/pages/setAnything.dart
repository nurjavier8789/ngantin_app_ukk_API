import 'package:flutter/material.dart';

import '../../../misc/styles.dart';
import '../../../misc/fonts.dart';
import 'subPages/listDiskon.dart';

import 'subPages/listSiswa.dart';
import 'subPages/listMenu.dart';

class setAnything extends StatefulWidget {
  const setAnything({super.key});

  @override
  State<setAnything> createState() => _setAnythingState();
}

class _setAnythingState extends State<setAnything> {
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
                SizedBox(height: 100),
                Card(
                  margin: EdgeInsets.all(28),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width-180,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Atur Menu", style: fonts().googleSansBold(Colors.black, 24), softWrap: true),
                                  Text("Buat, hapus atau perbarui semua menu makanan dan minuman anda disini!", style: fonts().googleSansRegular(Colors.black, 14), softWrap: true),
                                ],
                              ),
                            ),
                            Expanded(child: Container()),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => listMenu()));
                              },
                              style: style().buttonDefaultColor(16, FontWeight.bold),
                              child: Text("Atur"),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Divider(height: 0),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width-180,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Atur Diskon", style: fonts().googleSansBold(Colors.black, 24), softWrap: true),
                                  Text("Buat atau perbarui semua diskon anda disini!", style: fonts().googleSansRegular(Colors.black, 14), softWrap: true),
                                  Text("Maintenance", style: fonts().googleSansBold(Colors.red, 14), softWrap: true),
                                ],
                              ),
                            ),
                            Expanded(child: Container()),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => listDiskon()));
                              },
                              style: style().buttonDefaultColor(16, FontWeight.bold),
                              child: Text("Atur"),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Divider(height: 0),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width-180,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Atur Diskon Pada Menu", style: fonts().googleSansBold(Colors.black, 24), softWrap: true),
                                  Text("Tambahkan atau perbarui semua diskon pada menu makanan atau minuman anda disini!", style: fonts().googleSansRegular(Colors.black, 14), softWrap: true),
                                  Text("Segera Datang!", style: fonts().googleSansBold(Colors.black, 14), softWrap: true),
                                ],
                              ),
                            ),
                            Expanded(child: Container()),
                            ElevatedButton(
                              // onPressed: () {},
                              onPressed: null,
                              style: style().buttonDefaultColor(16, FontWeight.bold),
                              child: Text("Atur"),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Divider(height: 0),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width-180,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Atur Akun Siswa", style: fonts().googleSansBold(Colors.black, 24), softWrap: true),
                                  Text("Buat, hapus atau perbarui semua akun siswa disini!", style: fonts().googleSansRegular(Colors.black, 14), softWrap: true),
                                  Text("Hanya bisa mengubah detail. Tidak bisa mengatur ulang kata sandi", style: fonts().googleSansBold(Colors.black, 14), softWrap: true),
                                ],
                              ),
                            ),
                            Expanded(child: Container()),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => listSiswa()));
                              },
                              style: style().buttonDefaultColor(16, FontWeight.bold),
                              child: Text("Atur"),
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
                      Text("Atur kebutuhan stan", style: fonts().googleSansBold(Colors.black, 28)),
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

