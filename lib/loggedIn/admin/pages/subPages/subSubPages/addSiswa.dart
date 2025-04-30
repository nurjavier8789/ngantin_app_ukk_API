import 'dart:io';
import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';

import '../../../../../misc/styles.dart';
import '../../../../../misc/fonts.dart';
import '../../../misc/functions.dart';

class addAkunSiswaPage extends StatefulWidget {
  const addAkunSiswaPage({super.key});

  @override
  State<addAkunSiswaPage> createState() => _addAkunSiswaPageState();
}

class _addAkunSiswaPageState extends State<addAkunSiswaPage> {
  final forming = GlobalKey<FormState>();

  final inputNamaSiswa = TextEditingController();
  final inputUsername = TextEditingController();
  final inputAlamat = TextEditingController();
  final inputTelp = TextEditingController();
  final inputPassword = TextEditingController();

  File? uploadfile;
  String nameFile = "Belum ada file yang dipilih";
  String filePath = "";

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
                      controller: inputNamaSiswa,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Harap Masukkan Nama Siswa';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      cursorRadius: Radius.circular(69),
                      decoration: const InputDecoration(
                        labelText: "Nama Nama Siswa",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(14))
                        ),
                      ),
                    ),
                    SizedBox(height: 18),
                    TextFormField(
                      controller: inputUsername,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Harap Username';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      cursorRadius: Radius.circular(69),
                      decoration: const InputDecoration(
                        labelText: "Username",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(14))
                        ),
                      ),
                    ),
                    SizedBox(height: 18),
                    TextFormField(
                      controller: inputAlamat,
                      maxLines: null,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Harap Masukkan Alamat';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.streetAddress,
                      cursorRadius: Radius.circular(69),
                      decoration: const InputDecoration(
                        labelText: "Alamat",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(14))
                        ),
                      ),
                    ),
                    SizedBox(height: 18),
                    TextFormField(
                      controller: inputTelp,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Harap Masukkan No. HP';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                      cursorRadius: Radius.circular(69),
                      decoration: const InputDecoration(
                        labelText: "No. HP",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(14))
                        ),
                      ),
                    ),
                    SizedBox(height: 18),
                    TextFormField(
                      controller: inputPassword,
                      validator: (value) {
                        if (value == null || value.isEmpty && value.length >= 6) {
                          return 'Harap Masukkan Password';
                        } else if (value.length < 6) {
                          return "Password setidaknya 6 karakter atau lebih!";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.visiblePassword,
                      cursorRadius: Radius.circular(69),
                      decoration: const InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(14))
                        ),
                      ),
                    ),
                    SizedBox(height: 18),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Foto Profil", style: fonts().googleSansBold(Colors.black, 24)),
                        Text("(Opsional)", style: fonts().googleSansBold(Colors.black38, 16)),
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
                        if (forming.currentState!.validate()) {
                          addAkunSiswa(context, inputNamaSiswa.text, inputAlamat.text, inputTelp.text, inputUsername.text, inputPassword.text, filePath);
                        }
                      },
                      style: style().buttonCustom(Colors.green, Colors.white, 18, FontWeight.bold),
                      child: Text("Tambah Akun Siswa"),
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
                      Text("Tambah Akun Siswa", style: fonts().googleSansBold(Colors.black, 28)),
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

