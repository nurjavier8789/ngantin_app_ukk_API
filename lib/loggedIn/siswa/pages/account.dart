import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:yukan_app_ukk/loggedIn/siswa/pages/subPages/editProfile.dart';
import 'package:yukan_app_ukk/misc/styles.dart';

import '../../../landingPage.dart';
import '../../../misc/fonts.dart';
import '../../userData.dart';

class akun extends StatefulWidget {
  const akun({super.key});

  @override
  State<akun> createState() => _akunState();
}

class _akunState extends State<akun> {
  refreshPage() {
    Future.delayed(Duration(seconds: 1));
    setState(() {});
  }

  @override
  void initState() {
    refreshPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(28),
              child: Text("Akun", style: fonts().googleSansBold(Colors.black, 28)),
            ),
            Divider(height: 0),
            Container(
              height: MediaQuery.of(context).size.height-186,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Card(
                    margin: EdgeInsets.all(28),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                child: dataUser().getUrlFoto().isEmpty ? Image.asset("assets/noIcon.png", width: 100,) : Image.network(dataUser().getUrlFoto(), width: 100,),
                                borderRadius: BorderRadius.circular(911),
                              ),
                              SizedBox(width: 26),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${dataUser().getNama()}", style: fonts().googleSansCustom(Colors.black, 20, FontWeight.w600), softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis),
                                  Text("${dataUser().getUsername()}", style: fonts().googleSansCustom(Colors.black, 16, FontWeight.w100), softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Divider(height: 0),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              Text("Username", style: fonts().googleSansCustom(Colors.black, 16, FontWeight.w100)),
                              SizedBox(width: 16),
                              Text(": ${dataUser().getUsername()}", style: fonts().googleSansBold(Colors.black, 16), softWrap: true, maxLines: 1, overflow: TextOverflow.ellipsis),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Nama Siswa", style: fonts().googleSansCustom(Colors.black, 16, FontWeight.w100)),
                              SizedBox(width: 4),
                              Text(": ${dataUser().getNama()}", style: fonts().googleSansBold(Colors.black, 16), softWrap: true, maxLines: 1, overflow: TextOverflow.ellipsis),
                            ],
                          ),
                          Row(
                            children: [
                              Text("No. Telp", style: fonts().googleSansCustom(Colors.black, 16, FontWeight.w100)),
                              SizedBox(width: 30),
                              Text(": ${dataUser().getNoTelp()}", style: fonts().googleSansBold(Colors.black, 16), softWrap: true, maxLines: 1, overflow: TextOverflow.ellipsis),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Alamat", style: fonts().googleSansCustom(Colors.black, 16, FontWeight.w100)),
                              SizedBox(width: 36),
                              Text(": ${dataUser().getAlamat()}", style: fonts().googleSansBold(Colors.black, 16), softWrap: true, maxLines: 1, overflow: TextOverflow.ellipsis),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 28, right: 28),
                    child: ElevatedButton(
                      onPressed: () async {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => editProfilePage())).whenComplete(() {
                          Future.delayed(Duration(seconds: 1));
                          setState(() {});
                        });
                      },
                      style: style().buttonCustom(Colors.blueAccent, Colors.white, 18, FontWeight.bold),
                      child: Text("Edit Profil"),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 28, right: 28),
                    child: ElevatedButton(
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.clear();

                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => landingPage()), (route) => false);
                      },
                      style: style().buttonCustom(Colors.red, Colors.white, 18, FontWeight.bold),
                      child: Text("Keluar"),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 28, right: 28),
                    child: ElevatedButton(
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setString("token", "");
                        print("Token cleared!");
                      },
                      style: style().buttonCustom(Colors.grey, Colors.white, 18, FontWeight.bold),
                      child: Text("Clear Token"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

