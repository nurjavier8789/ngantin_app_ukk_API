import 'package:flutter/material.dart';

import 'landingPage.dart';

void main() {
  runApp(const mainApp());
}

class mainApp extends StatelessWidget {
  const mainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ngantin!",
      home: landingPage(),
    );
  }
}

