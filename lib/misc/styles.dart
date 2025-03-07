import 'package:flutter/material.dart';

import 'fonts.dart';

class style {
  ButtonStyle buttonCustom(Color warnaBG, Color warnaFont, double fontSize, FontWeight tebalFont) {
    return ElevatedButton.styleFrom(
      backgroundColor: warnaBG,
      foregroundColor: warnaFont,
      textStyle: fonts().googleSansCustom(warnaFont, fontSize, tebalFont),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  ButtonStyle buttonCustomSize(Color warnaBG, Color warnaFont, double fontSize, FontWeight tebalFont, double panjang, double tinggi) {
    return ElevatedButton.styleFrom(
      fixedSize: Size(panjang, tinggi),
      backgroundColor: warnaBG,
      foregroundColor: warnaFont,
      textStyle: fonts().googleSansCustom(warnaFont, fontSize, tebalFont),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
