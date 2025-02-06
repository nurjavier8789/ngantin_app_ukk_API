import 'package:flutter/material.dart';

import '../../../misc/fonts.dart';

class pesanan extends StatefulWidget {
  const pesanan({super.key});

  @override
  State<pesanan> createState() => _pesananState();
}

class _pesananState extends State<pesanan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.all(28),
              child: Text("Pesanan", style: fonts().googleSansBold(Colors.black, 28)),
            ),
            Divider(height: 0),
          ],
        )
      ),
    );
  }
}

