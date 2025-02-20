// This page is no use for now
// Just ignore this file

import 'package:flutter/material.dart';

import '../../../misc/fonts.dart';

class widgetsInWidgets {
  showDetailTransaction(BuildContext context) {
    Widget okButton = Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 218, 131, 0),
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text("OK", style: TextStyle(color: Colors.white)),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );

    AlertDialog details = AlertDialog(
      contentPadding: EdgeInsets.all(24),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Detail Pesanan", style: fonts().googleSansBold(Colors.black, 14), textAlign: TextAlign.start, softWrap: true),
              Text("Belum Dikonfirmasi", style: fonts().googleSansBold(Colors.red, 14), textAlign: TextAlign.end, softWrap: true),
            ],
          ),
          SizedBox(height: 2),
          Text('1 item - Rp. 10.000', style: fonts().googleSansBold(Colors.black, 14)),
          SizedBox(height: 10),
          Divider(height: 0),
          SizedBox(height: 10),
          Text('1 x Nama Barang', style: fonts().googleSansBold(Colors.black, 20), softWrap: true,),
          Text('Harga', style: fonts().googleSansRegular(Colors.black, 16), softWrap: true,),
          SizedBox(height: 10),
          Divider(height: 0),
          SizedBox(height: 10),
          Text('Detail Pembayaran', style: fonts().googleSansBold(Colors.black, 16), softWrap: true,),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Subtotal", style: fonts().googleSansRegular(Colors.black38, 14)),
              Text("Rp. 10.000", style: fonts().googleSansBold(Colors.black, 14)),
            ],
          ),
          SizedBox(height: 10),
          Divider(height: 0),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total', style: fonts().googleSansBold(Colors.black, 16), softWrap: true,),
              Text('Rp. 10.000', style: fonts().googleSansBold(Colors.black, 16), softWrap: true,),
            ],
          ),
        ],
      ),
      actions: [okButton],
    );

    return showDialog(
      context: context,
      builder: (context) {
        return details;
      },
    );
  }
}
