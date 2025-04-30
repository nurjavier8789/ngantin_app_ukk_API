import 'dart:io';
import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';

import '../../../../../misc/styles.dart';
import '../../../../../misc/fonts.dart';
import '../../../misc/functions.dart';

class addMenuPage extends StatefulWidget {
  const addMenuPage({super.key});

  @override
  State<addMenuPage> createState() => _addMenuPageState();
}

class _addMenuPageState extends State<addMenuPage> {
  final forming = GlobalKey<FormState>();

  final inputNamaMakanan = TextEditingController();
  final inputJenis = TextEditingController();
  final inputHarga = TextEditingController();
  final inputDeskripsi = TextEditingController();

  File? uploadfile;
  String nameFile = "Belum ada file yang dipilih";
  String filePath = "";

  String foodTypeInit = 'Makanan';

  List<String> foodTypeList = [
    'Makanan',
    'Minuman',
  ];

  pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      PlatformFile pickedFile = result.files.first;
      uploadfile = File(result.files.single.path ?? " ");

      if (pickedFile.size <= 200000) {
        setState(() {
          nameFile = uploadfile!.path.split('/').last;
          filePath = uploadfile!.path;
        });
      } else {
        setState(() {
          nameFile = "Belum ada file yang dipilih";
          filePath = "";
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Gambar yang anda unggah melebihi batas maksinal!", style: fonts().googleSansRegular(Colors.white, 16)),
                Text("Batas ukuran gambar adalah 2MB", style: fonts().googleSansRegular(Colors.white, 16)),
              ],
            ),
            showCloseIcon: true,
            duration: Duration(seconds: 20),
          ),
        );
      }
    } else {
      // User canceled the picker
      print("User cancelled Picking File");
    }
  }

  @override
  void initState() {
    filePath = "";
    foodTypeInit = 'Makanan';
    nameFile = "Belum ada file yang dipilih";
    super.initState();
  }

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
                      controller: inputNamaMakanan,
                      validator: (value) {
                        if (value == null ||  value.isEmpty) {
                          return 'Harap Masukkan Nama Makanan/Minuman';
                        }
                        return null;
                      },
                      cursorRadius: Radius.circular(69),
                      decoration: const InputDecoration(
                        labelText: "Nama Makanan/Minuman",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(14))
                        ),
                      ),
                    ),
                    SizedBox(height: 18),
                    Container(
                      child: InputDecorator(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          contentPadding: EdgeInsets.only(right: 14, left: 14),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            isExpanded: true,
                            style: fonts().googleSansRegular(Colors.black, 16),
                            borderRadius: BorderRadius.circular(8),
                            value: foodTypeInit,
                            items: foodTypeList.map((String E) {
                              return DropdownMenuItem(
                                value: E,
                                child: Text(E),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                foodTypeInit = value!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 18),
                    TextFormField(
                      controller: inputHarga,
                      validator: (value) {
                        if (value == null ||  value.isEmpty) {
                          return 'Harap Masukkan Harga';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      cursorRadius: Radius.circular(69),
                      decoration: const InputDecoration(
                        hintText: "Contoh: 10000",
                        hintStyle: TextStyle(color: Colors.black26),
                        labelText: "Harga",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(14))
                        ),
                      ),
                    ),
                    SizedBox(height: 18),
                    TextFormField(
                      controller: inputDeskripsi,
                      maxLines: null,
                      validator: (value) {
                        if (value == null ||  value.isEmpty) {
                          return 'Harap Masukkan Deskripsi';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.multiline,
                      cursorRadius: Radius.circular(69),
                      decoration: const InputDecoration(
                        labelText: "Deskripsi",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(14))
                        ),
                      ),
                    ),
                    SizedBox(height: 18),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Foto Makanan/Minuman", style: fonts().googleSansBold(Colors.black, 24)),
                        Text("(Diperlukan)", style: fonts().googleSansBold(Colors.red, 16)),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            SizedBox(
                              width: 196,
                              child: ElevatedButton(
                                onPressed: () async {
                                  await pickImage();
                                },
                                style: style().buttonCustom(Color.fromARGB(255, 218, 131, 0), Colors.white, 18, FontWeight.bold),
                                child: Row(
                                  children: [
                                    Icon(Icons.upload, size: 20, color: Colors.white),
                                    SizedBox(width: 8),
                                    Text("Unggah Gambar"),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 12),
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 256,
                              child: Text("${nameFile}", style: fonts().googleSansRegular(Colors.black, 16), overflow: TextOverflow.ellipsis, softWrap: true , maxLines: 2),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 18),
                    ElevatedButton(
                      onPressed: () async {
                        if (forming.currentState!.validate() && filePath != "") {
                          await addMenu(context, inputNamaMakanan.text, foodTypeInit, inputHarga.text, filePath, inputDeskripsi.text);
                        } else if (filePath == "") {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Fotonya tidak boleh kosong!", style: fonts().googleSansRegular(Colors.white, 16)),
                                ],
                              ),
                              showCloseIcon: true,
                              duration: Duration(seconds: 10),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      style: style().buttonCustom(Colors.green, Colors.white, 18, FontWeight.bold),
                      child: Text("Tambah Menu"),
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
                      Text("Tambah Menu", style: fonts().googleSansBold(Colors.black, 28)),
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

