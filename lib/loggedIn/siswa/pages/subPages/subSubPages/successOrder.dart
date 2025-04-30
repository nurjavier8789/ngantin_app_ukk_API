import 'package:flutter/material.dart';

import '../../../../../misc/fonts.dart';
import '../../../overlay.dart';

class orderSuccessful extends StatefulWidget {
  const orderSuccessful({super.key});

  @override
  State<orderSuccessful> createState() => _orderSuccessfulState();
}

class _orderSuccessfulState extends State<orderSuccessful> {

  initPage() {
    Future.delayed(Duration(milliseconds: 1500)).then(
      (value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Berhasil melakukan pesanan!", style: fonts().googleSansRegular(Colors.white, 16), softWrap: true),
                Text("Silahkan cek pesanan di menu pesanan!", style: fonts().googleSansRegular(Colors.white, 16), softWrap: true),
              ],
            ),
            backgroundColor: Colors.green,
            showCloseIcon: true,
            duration: Duration(seconds: 20),
          ),
        );
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => overlayHomeS()), (route) => false);
      },
    );
  }

  @override
  void initState() {
    initPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Align(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/checkmark1.gif"),
              SizedBox(height: 12),
              Text("Pesanan Berhasil!", style: fonts().googleSansBold(Colors.black, 24)),
            ],
          ),
        ),
      ),
    );
  }
}

