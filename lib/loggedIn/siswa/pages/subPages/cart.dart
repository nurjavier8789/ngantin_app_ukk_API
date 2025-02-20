// This file is just test purpose
// but don't worry, this file will have a function later

import 'package:flutter/material.dart';

import '../../../../misc/fonts.dart';
import '../../../../misc/styles.dart';

class cartPage extends StatefulWidget {
  const cartPage({super.key});

  @override
  State<cartPage> createState() => _cartPageState();
}

class _cartPageState extends State<cartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
              style: style().buttonCustom(Colors.red, Colors.white, 18, FontWeight.bold),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Back", style: fonts().googleSansBold(Colors.white, 18)),
            ),
          ],
        ),
      ),
    );
  }
}

