import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../landingPage.dart';
import '../../../misc/styles.dart';
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              shrinkWrap: true,
              children: [
                SizedBox(height: 96),
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
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Stan ${dataUser().getNamaStan()}", style: fonts().googleSansCustom(Colors.black, 20, FontWeight.w600), softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis),
                                Text("Pemilik ${dataUser().getNama()}", style: fonts().googleSansCustom(Colors.black, 16, FontWeight.w100), softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Divider(height: 0),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Text("Nama Pemilik", style: fonts().googleSansCustom(Colors.black, 16, FontWeight.w100)),
                            SizedBox(width: 4),
                            Text(": ${dataUser().getNama()}", style: fonts().googleSansBold(Colors.black, 16), softWrap: true, maxLines: 1, overflow: TextOverflow.ellipsis),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Username", style: fonts().googleSansCustom(Colors.black, 16, FontWeight.w100)),
                            SizedBox(width: 26),
                            Text(": ${dataUser().getUsername()}", style: fonts().googleSansBold(Colors.black, 16), softWrap: true, maxLines: 1, overflow: TextOverflow.ellipsis),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Nama Stan", style: fonts().googleSansCustom(Colors.black, 16, FontWeight.w100)),
                            SizedBox(width: 23),
                            Text(": ${dataUser().getNamaStan()}", style: fonts().googleSansBold(Colors.black, 16), softWrap: true, maxLines: 1, overflow: TextOverflow.ellipsis),
                          ],
                        ),
                        Row(
                          children: [
                            Text("No. Telp", style: fonts().googleSansCustom(Colors.black, 16, FontWeight.w100)),
                            SizedBox(width: 40),
                            Text(": ${dataUser().getNoTelp()}", style: fonts().googleSansBold(Colors.black, 16), softWrap: true, maxLines: 1, overflow: TextOverflow.ellipsis),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 28, right: 28),
                  child: ElevatedButton(
                    // onPressed: () async {
                      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => editProfilePage())).whenComplete(() {
                      //   Future.delayed(Duration(seconds: 1));
                      //   setState(() {});
                      // });
                    // },
                    onPressed: null,
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
                SizedBox(height: 24),
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(28),
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  child: Text("Akun", style: fonts().googleSansBold(Colors.black, 28)),
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
