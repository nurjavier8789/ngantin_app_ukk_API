import 'package:flutter/material.dart';

import '../misc/styles.dart';
import '../misc/fonts.dart';

import 'registerRole/regisSiswa.dart';
import 'registerRole/regisStan.dart';
import '../landingPage.dart';
import '../loginPage.dart';

class registerPage extends StatefulWidget {
  const registerPage({super.key});

  @override
  State<registerPage> createState() => _registerPageState();
}

class _registerPageState extends State<registerPage> {
  final forming = GlobalKey<FormState>();

  final inputName = TextEditingController();
  final inputUser = TextEditingController();

  String role = "siswa";

  @override
  void dispose() {
    inputName.dispose();
    inputUser.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(226, 255, 211, 1.0),
      body: SafeArea(
        child: Align(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Daftar", style: fonts().googleSansBold(Colors.black, 32)),
                  SizedBox(height: 24),
                  Form(
                    key: forming,
                    child: Container(
                      margin: EdgeInsets.only(right: 24, left: 24),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: inputName,
                            validator: (value) {
                              if (value == null ||  value.isEmpty) {
                                return 'Harap Masukkan Nama';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            cursorRadius: Radius.circular(69),
                            decoration: const InputDecoration(
                              labelText: "Nama Lengkap",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(14))
                              ),
                            ),
                            onTapOutside: (event) {
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                          ),

                          SizedBox(height: 12),

                          TextFormField(
                            controller: inputUser,
                            validator: (value) {
                              if (value == null ||  value.isEmpty) {
                                return 'Harap Masukkan Username';
                              }
                              return null;
                            },
                            cursorRadius: Radius.circular(69),
                            decoration: const InputDecoration(
                              labelText: "Username",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(14))
                              ),
                            ),
                            onTapOutside: (event) {
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                          ),

                          SizedBox(height: 16),
                          Text("Pilih Role", style: fonts().googleSansBold(Colors.black, 18)),
                          SizedBox(height: 16),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 150,
                                child: ListTile(
                                  leading: Radio<String>(
                                    value: "siswa",
                                    groupValue: role,
                                    onChanged: (value) {
                                      setState(() {
                                        role = value!;
                                      });
                                    },
                                  ),
                                  title: Text("Siswa", style: fonts().googleSansRegular(Colors.black, 16)),
                                ),
                              ),

                              SizedBox(
                                width: 190,
                                child: ListTile(
                                  leading: Radio<String>(
                                    value: "admin_stan",
                                    groupValue: role,
                                    onChanged: (value) {
                                      setState(() {
                                        role = value!;
                                      });
                                    },
                                  ),
                                  title: Text("Pemilik Stan", style: fonts().googleSansRegular(Colors.black, 16)),
                                ),
                              ),
                            ],
                          ),

                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (forming.currentState!.validate()) {
                                      if (role == "siswa") {
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => registerSiswa(nama_siswa: inputName.text, username: inputUser.text)));
                                      } else if (role == "admin_stan") {
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => registerStanAdmin(nama_pemilik: inputName.text, username: inputUser.text,)));
                                      }
                                    }
                                  },
                                  style: style().buttonCustom(Colors.blueAccent, Colors.white, 18, FontWeight.bold),
                                  child: Text("Berikutnya"),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 8),
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => landingPage()), (route) => false);
                                  },
                                  style: style().buttonCustom(Colors.red, Colors.white, 18, FontWeight.bold),
                                  child: Text("Kembali ke beranda"),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 32),

                          Text("Sudah punya akun?", textAlign: TextAlign.center, style: fonts().googleSansRegular(Colors.black, 16)),
                          SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => loginPage()), (route) => false);
                            },
                            style: style().buttonCustom(Color.fromRGBO(47, 218, 0, 1.0), Colors.white, 18, FontWeight.bold),
                            child: Text("Masuk!"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );;
  }
}
