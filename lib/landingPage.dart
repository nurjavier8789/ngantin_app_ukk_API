import 'package:flutter/material.dart';

import 'loginPage.dart';
import 'registerPage/regisPage1.dart';

import 'misc/styles.dart';
import 'misc/fonts.dart';

class landingPage extends StatefulWidget {
  const landingPage({super.key});

  @override
  State<landingPage> createState() => _landingPageState();
}

class _landingPageState extends State<landingPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 172, 65, 1.0),
      body: SafeArea(
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Selamat datang di Ngantin!", style: fonts().googleSansBold(Colors.white, 40), textAlign: TextAlign.center),
                Text("Silahkan masuk atau daftar jika tidak punya akun!", style: fonts().googleSansBold(Colors.white, 24), textAlign: TextAlign.center),
                SizedBox(height: 24),
                Container(
                  margin: EdgeInsets.only(right: 32, left: 32),
                  height: 48,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => loginPage()));
                    },
                    style: style().buttonCustom(Colors.blueAccent, Colors.white, 20, FontWeight.bold),
                    child: Text("Masuk"),
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  margin: EdgeInsets.only(right: 32, left: 32),
                  height: 48,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => registerPage()));
                    },
                    style: style().buttonCustom(Color.fromRGBO(231, 0, 0, 1), Colors.white, 20, FontWeight.bold),
                    child: Text("Daftar"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}