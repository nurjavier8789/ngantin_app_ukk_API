import 'package:flutter/material.dart';

import '../../../../../misc/styles.dart';
import '../../../../../misc/fonts.dart';
import '../../../misc/functions.dart';

class addDiskonPage extends StatefulWidget {
  const addDiskonPage({super.key});

  @override
  State<addDiskonPage> createState() => _addDiskonPageState();
}

class _addDiskonPageState extends State<addDiskonPage> {
  final forming = GlobalKey<FormState>();

  final inputNamaDiskon = TextEditingController();
  final inputPersentaseDiskon = TextEditingController();

  DateTime dateStart = DateTime.now();
  DateTime dateEnd = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Form(
              key: forming,
              child: Container(
                margin: EdgeInsets.only(right: 24, left: 24, top: 120),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    TextFormField(
                      controller: inputNamaDiskon,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Harap Masukkan Nama Diskon';
                        }
                        return null;
                      },
                      cursorRadius: Radius.circular(69),
                      decoration: const InputDecoration(
                        labelText: "Nama Nama Diskon",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(14))
                        ),
                      ),
                    ),
                    SizedBox(height: 18),
                    TextFormField(
                      controller: inputPersentaseDiskon,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Harap Masukkan Persentase Diskon';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      cursorRadius: Radius.circular(69),
                      decoration: const InputDecoration(
                        labelText: "Persentase Diskon",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(14))
                        ),
                      ),
                    ),
                    SizedBox(height: 18),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Masa berlaku diskon", style: fonts().googleSansBold(Colors.black, 24)),
                        Text("Tanggal awal - Tanggal akhir", style: fonts().googleSansBold(Colors.black, 18)),
                        Text(
                          "${dateStart.day.toString().padLeft(2, "0")}-${dateStart.month.toString().padLeft(2, "0")}-${dateStart.year} "
                              "- ${dateEnd.day.toString().padLeft(2, "0")}-${dateEnd.month.toString().padLeft(2, "0")}-${dateEnd.year}",
                          style: fonts().googleSansRegular(Colors.black, 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        showDateRangePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(Duration(days: 730)),
                          initialDateRange: DateTimeRange(start: DateTime.now(), end: DateTime.now().add(Duration(days: 1))),
                          initialEntryMode: DatePickerEntryMode.calendar,
                          helpText: "Tentukan masa berlaku diskon",
                          cancelText: "Batal",
                          saveText: "Simpan",
                          fieldStartLabelText: "Tanggal awal",
                          fieldEndLabelText: "Tanggal akhir",
                          builder: (context, child) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  // margin: EdgeInsets.all(48),
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height-90,
                                  child: child,
                                ),
                              ],
                            );
                          },
                        ).then((value) {
                          if (value != null) {
                            dateStart = value.start;
                            dateEnd = value.end;
                          }
                          setState(() {});
                        });
                      },
                      style: style().buttonDefaultColor(18, FontWeight.bold),
                      child: Text("Tentukan masa berlaku diskon"),
                    ),
                    SizedBox(height: 18),
                    ElevatedButton(
                      onPressed: () async {
                        if (forming.currentState!.validate()) {
                          await addDiskon(context, inputNamaDiskon.text, inputPersentaseDiskon.text, dateStart.toString(), dateEnd.toString());
                        }
                      },
                      style: style().buttonCustom(Colors.green, Colors.white, 18, FontWeight.bold),
                      child: Text("Tambah diskon"),
                    ),
                    SizedBox(height: 18),
                  ],
                ),
              ),
            ),

            Column(
              children: [
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(28),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: Color.fromARGB(255, 218, 131, 0),
                          ),
                          child: Icon(Icons.arrow_back_rounded, size: 26, color: Colors.white),
                        ),
                      ),
                      SizedBox(width: 24),
                      Text("Tambah Diskon", style: fonts().googleSansBold(Colors.black, 28)),
                    ],
                  ),
                ),
                Divider(height: 0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

