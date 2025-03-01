import 'package:flutter/material.dart';

import '../../../../misc/styles.dart';
import '../../../../misc/fonts.dart';
import '../../misc/functions.dart';
import '../../../getProfile.dart';
import '../../../userData.dart';

class editProfilePage extends StatefulWidget {
  const editProfilePage({super.key});

  @override
  State<editProfilePage> createState() => _editProfilePageState();
}

class _editProfilePageState extends State<editProfilePage> {
  final forming = GlobalKey<FormState>();

  final inputNamaSiswa = TextEditingController();
  final inputAlamat = TextEditingController();
  final inputTelp = TextEditingController();
  final inputUsername = TextEditingController();

  initValue() async {
    inputNamaSiswa.text = dataUser().getNama();
    inputAlamat.text = dataUser().getAlamat();
    inputTelp.text = dataUser().getNoTelp();
    inputUsername.text = dataUser().getUsername();
  }

  @override
  void initState() {
    initValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              Form(
                key: forming,
                child: Container(
                  margin: EdgeInsets.only(right: 24, left: 24, top: 120),
                  child: ListView(
                    children: [
                      TextFormField(
                        controller: inputUsername,
                        validator: (value) {
                          if (value == null ||  value.isEmpty) {
                            return 'Harap Masukkan Username';
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
                        controller: inputNamaSiswa,
                        validator: (value) {
                          if (value == null ||  value.isEmpty) {
                            return 'Harap Masukkan Nama Siswa';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.name,
                        cursorRadius: Radius.circular(69),
                        decoration: const InputDecoration(
                          labelText: "Nama Siswa",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(14))
                          ),
                        ),
                      ),
                      SizedBox(height: 18),
                      TextFormField(
                        controller: inputTelp,
                        validator: (value) {
                          if (value == null ||  value.isEmpty) {
                            return 'Harap Masukkan Nama Siswa';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        cursorRadius: Radius.circular(69),
                        decoration: const InputDecoration(
                          labelText: "Nomor Telepon",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(14))
                          ),
                        ),
                      ),
                      SizedBox(height: 18),
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
                      Row(
                        children: [
                          Text("Foto Profil", style: fonts().googleSansBold(Colors.black, 24)),
                          SizedBox(width: 16),
                          ElevatedButton(
                            onPressed: null,
                            // onPressed: () async {},
                            style: style().buttonCustom(Color.fromARGB(255, 218, 131, 0), Colors.white, 18, FontWeight.bold),
                            child: Row(
                              children: [
                                Icon(Icons.upload, size: 20, color: Colors.grey),
                                SizedBox(width: 8),
                                Text("Unggah Gambar"),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Text("Note: Untuk saat ini unggah gambar dalam perbaikan", softWrap: true, style: fonts().googleSansRegular(Colors.grey, 14)),
                      SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () async {
                          bool resultEdit = await editProfile(inputNamaSiswa.text, inputAlamat.text, inputTelp.text, inputUsername.text, context);
                          if (resultEdit == true) {
                            await Get().profileSiswa();
                            Navigator.of(context).pop();
                          } else {
                            Navigator.of(context).pop();
                          }
                        },
                        style: style().buttonCustom(Colors.green, Colors.white, 18, FontWeight.bold),
                        child: Text("Kirim Perubahan"),
                      ),
                      SizedBox(height: 12),
                    ],
                  ),
                ),
              ),

              Column(
                children: [
                  Padding(
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
                        Text("Edit Profil", style: fonts().googleSansBold(Colors.black, 28)),
                      ],
                    ),
                  ),
                  Divider(height: 0),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

