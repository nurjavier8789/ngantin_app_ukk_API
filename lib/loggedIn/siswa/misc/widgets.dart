import 'package:flutter/material.dart';

import '../../../misc/fonts.dart';
import '../../userData.dart';

class widgets {
  Text greeting() {
    String teks = "";

    if (DateTime.now().hour >= 00 && DateTime.now().hour <= 09) {
      teks = "Selamat Pagi";
    } else if (DateTime.now().hour >= 10 && DateTime.now().hour <= 14) {
      teks = "Selamat Siang";
    } else if (DateTime.now().hour >= 15 && DateTime.now().hour <= 17) {
      teks = "Selamat Sore";
    } else if (DateTime.now().hour >= 18 && DateTime.now().hour <= 23) {
      teks = "Selamat Malam";
    }

    return Text("${teks} ${dataUser().getNama()}!", style: fonts().googleSansCustom(Colors.black, 28, FontWeight.w600), softWrap: true, maxLines: 2);
  }
}
