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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(28),
              child: Text("Pesanan", style: fonts().googleSansBold(Colors.black, 28)),
            ),
            Divider(height: 0),
            ListView(
              shrinkWrap: true,
              children: [
                SizedBox(height: 24),
                Container(
                  margin: EdgeInsets.all(14),
                  child: Text("Belum dikonfirmasi", style: fonts().googleSansBold(Colors.black, 20),),
                ),
                Divider(height: 0),
                SizedBox(height: 24),
                Container(
                  margin: EdgeInsets.all(14),
                  child: Text("Dimasak", style: fonts().googleSansBold(Colors.black, 20),),
                ),
                Divider(height: 0),
                SizedBox(height: 24),
                Container(
                  margin: EdgeInsets.all(14),
                  child: Text("Diantar", style: fonts().googleSansBold(Colors.black, 20),),
                ),
                Divider(height: 0),
                SizedBox(height: 24),
                Container(
                  margin: EdgeInsets.all(14),
                  child: Text("Sampai", style: fonts().googleSansBold(Colors.black, 20),),
                ),
                Divider(height: 0),
                SizedBox(height: 24),
                Container(
                  margin: EdgeInsets.all(14),
                  child: Text("Selesai", style: fonts().googleSansBold(Colors.black, 20),),
                ),
                Divider(height: 0),
                SizedBox(height: 24),
              ],
            ),
          ],
        )
      ),
    );
  }
}

