import 'dart:io';
import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';

import '../../misc/fonts.dart';
import '../../misc/styles.dart';

import '../../misc/authProcess.dart';

class registerSiswa extends StatefulWidget {
  registerSiswa({super.key, required this.nama_siswa, required this.username});

  final String nama_siswa;
  final String username;

  @override
  State<registerSiswa> createState() => _registerSiswaState();
}

class _registerSiswaState extends State<registerSiswa> {
  final forming = GlobalKey<FormState>();

  final inputAlamat = TextEditingController();
  final inputTelp = TextEditingController();
  final inputPass = TextEditingController();
  final inputConfirmPass = TextEditingController();

  bool hidePass = true;
  bool hidePass2 = true;

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
      backgroundColor: Color.fromRGBO(226, 255, 211, 1.0),
      body: SafeArea(
        child: Align(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 24),
                Text("Daftar sebagai siswa", style: fonts().googleSansBold(Colors.black, 32)),
                Text("yuk lengkapi dulu datanya!", style: fonts().googleSansRegular(Colors.black, 20)),
                SizedBox(height: 24),
                Text("Nama Lengkap: ${widget.nama_siswa}", style: fonts().googleSansRegular(Colors.black, 24)),
                Text("Username: ${widget.username}", style: fonts().googleSansRegular(Colors.black, 24)),
                SizedBox(height: 18),
                Form(
                  key: forming,
                  child: Container(
                    margin: EdgeInsets.only(right: 24, left: 24),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: inputAlamat,
                          validator: (value) {
                            if (value == null ||  value.isEmpty) {
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
                        SizedBox(height: 12),
                        TextFormField(
                          controller: inputTelp,
                          validator: (value) {
                            if (value == null ||  value.isEmpty) {
                              return 'Harap Masukkan Telepon';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          cursorRadius: Radius.circular(69),
                          decoration: const InputDecoration(
                            labelText: "Telepon",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(14))
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        TextFormField(
                          controller: inputPass,
                          validator: (value) {
                            if (value == null ||  value.isEmpty) {
                              return 'Harap Masukkan Password';
                            } else if (value.length < 6) {
                              return 'Password harus lebih dari 6 karakter';
                            }
                            return null;
                          },
                          enableSuggestions: false,
                          autocorrect: false,
                          obscureText: hidePass,
                          cursorRadius: Radius.circular(69),
                          decoration: InputDecoration(
                            labelText: "Password",
                            border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(14))
                            ),
                            suffixIcon: IconButton(
                              color: const Color.fromRGBO(0, 0, 0, 120),
                              icon: Icon(hidePass
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  hidePass = !hidePass;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        TextFormField(
                          controller: inputConfirmPass,
                          validator: (value) {
                            if (value == null ||  value.isEmpty) {
                              return 'Harap Konfirmasi Password';
                            } else if (value.length < 6) {
                              return 'Password harus lebih dari 6 karakter';
                            } else if (inputPass.text != inputConfirmPass.text) {
                              return 'Password tidak sama!';
                            }
                            return null;
                          },
                          enableSuggestions: false,
                          autocorrect: false,
                          obscureText: hidePass2,
                          cursorRadius: Radius.circular(69),
                          decoration: InputDecoration(
                            labelText: "Konfirmasi Password",
                            border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(14))
                            ),
                            suffixIcon: IconButton(
                              color: const Color.fromRGBO(0, 0, 0, 120),
                              icon: Icon(hidePass2
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  hidePass2 = !hidePass2;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 12),
                Container(
                  margin: EdgeInsets.only(right: 24, left: 24),
                  child: Column(
                    children: [
                      Text("Foto Profil", style: fonts().googleSansBold(Colors.black, 24)),
                      Text("(Opsional, bisa diunggah nanti)", style: fonts().googleSansRegular(Colors.black, 16)),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              await pickImage();
                            },
                            style: style().buttonCustomSize(Colors.deepOrange, Colors.white, 18, FontWeight.bold, 196, 20),
                            child: Row(
                              children: [
                                Icon(Icons.upload, size: 20, color: Colors.white),
                                SizedBox(width: 8),
                                Text("Unggah Gambar"),
                              ],
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
                ),

                SizedBox(height: 12),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(right: 24, left: 24),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (forming.currentState!.validate()) {
                        await auth().registerSiswa(widget.nama_siswa, inputAlamat.text, inputTelp.text, widget.username, inputPass.text, filePath, context);
                      }
                    },
                    style: style().buttonCustom(Colors.blueAccent, Colors.white, 18, FontWeight.bold),
                    child: Text("Daftar"),
                  ),
                ),
                SizedBox(height: 6),
                Container(
                  margin: EdgeInsets.only(right: 24, left: 24),
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: style().buttonCustom(Colors.red, Colors.white, 18, FontWeight.bold),
                    child: Text("Kembali"),
                  ),
                ),
                SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
