import 'package:flutter/material.dart';

import '../../../../misc/styles.dart';
import '../../../../misc/fonts.dart';
import 'subSubPages/editSiswa.dart';
import '../../misc/functions.dart';
import 'subSubPages/addSiswa.dart';
import '../../misc/widgets.dart';
import '../../../../api.dart';

class listSiswa extends StatefulWidget {
  const listSiswa({super.key});

  @override
  State<listSiswa> createState() => _listSiswaState();
}

class _listSiswaState extends State<listSiswa> {
  api _api = api();
  List listDataSiswa = [];

  fetchSiswa() async {
    listDataSiswa = await showListSiswa();

    Future.delayed(Duration(seconds: 1));
    setState(() {});
  }

  @override
  void initState() {
    fetchSiswa();
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
              margin: EdgeInsets.only(right: 24, left: 24, top: 220),
              child: listDataSiswa.isEmpty ? Center(child: Text("Memuat akun siswa..."))
                  : RefreshIndicator(
                onRefresh: () {
                  return Future.delayed(Duration(seconds: 1), () {
                    fetchSiswa();
                  });
                },
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    for (int i = 0; i < listDataSiswa.length; i++)
                      InkWell(
                        onTap: () {
                          widgets().showDetailSiswa(context, listDataSiswa[i]);
                        },
                        child: Column(
                          children: [
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(69),
                                      child: listDataSiswa[i]["foto"] == null ? Image.asset("assets/noIcon.png", height: 80, width: 80, fit: BoxFit.cover) : Image.network("${_api.baseUrlRil}${listDataSiswa[i]["foto"]}", height: 80, width: 80, fit: BoxFit.cover),
                                    ),
                                    SizedBox(width: 18),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width-240,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(listDataSiswa[i]["nama_siswa"], style: fonts().googleSansBold(Colors.black, 20), overflow: TextOverflow.ellipsis),
                                          Text(listDataSiswa[i]["username"], style: fonts().googleSansRegular(Colors.black, 16), overflow: TextOverflow.ellipsis),
                                          Text(listDataSiswa[i]["alamat"], style: fonts().googleSansRegular(Colors.black, 16), overflow: TextOverflow.ellipsis),
                                          Text(listDataSiswa[i]["telp"], style: fonts().googleSansRegular(Colors.black, 16), overflow: TextOverflow.ellipsis),
                                        ],
                                      ),
                                    ),
                                    Expanded(child: Container()),
                                    Column(
                                      children: [
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
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => editAkunSiswaPage(dataSiswa: listDataSiswa[i],))).then((value) {
                                                fetchSiswa();
                                              });
                                            },
                                            child: Icon(Icons.edit, color: Colors.white),
                                          ),
                                        ),
                                        SizedBox(height: 12),
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
                                              widgets().deleteAkunSiswaConfirm(context, listDataSiswa[i]["nama_siswa"], listDataSiswa[i]["id"]).then((value) {
                                                if (value == "delete") {
                                                  fetchSiswa();
                                                }
                                              });
                                            },
                                            child: Icon(Icons.delete, color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                          ],
                        ),
                      ),
                    SizedBox(height: 16),
                  ],
                ),
              )
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
                      Text("Atur Akun Siswa", style: fonts().googleSansBold(Colors.black, 28)),
                    ],
                  ),
                ),
                Divider(height: 0),
                Container(
                  margin: EdgeInsets.all(24),
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => addAkunSiswaPage())).then((value) {
                        fetchSiswa();
                      });
                    },
                    style: style().buttonDefaultColor(18, FontWeight.bold),
                    child: Text("Tambah Akun Siswa"),
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

