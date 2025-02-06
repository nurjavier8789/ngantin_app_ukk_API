import 'package:flutter/material.dart';

class fonts {
  TextStyle googleSansBold(Color warna, double ukuran) {
    return TextStyle(
      fontFamily: "Google Sans",
      fontStyle: FontStyle.normal,
      color: warna,
      fontWeight: FontWeight.bold,
      fontSize: ukuran,
    );
  }

  TextStyle googleSansRegular(Color warna, double ukuran) {
    return TextStyle(
      fontFamily: "Google Sans",
      fontStyle: FontStyle.normal,
      color: warna,
      fontSize: ukuran,
    );
  }

  TextStyle googleSansCustom(Color warna, double ukuran, FontWeight tebel) {
    return TextStyle(
      fontFamily: "Google Sans",
      fontStyle: FontStyle.normal,
      color: warna,
      fontSize: ukuran,
      fontWeight: tebel,
    );
  }
}
