import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'landingPage.dart';

void main() {
  runApp(const mainApp());
}

class mainApp extends StatefulWidget {
  const mainApp({super.key});

  @override
  State<mainApp> createState() => _mainAppState();
}

class _mainAppState extends State<mainApp> {

  @override
  void initState() {
    Intl.defaultLocale = 'id_ID';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ngantin!",
      home: landingPage(),
    );
  }
}

