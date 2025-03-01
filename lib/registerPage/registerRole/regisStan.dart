import 'package:flutter/material.dart';

import '../../misc/fonts.dart';
import '../../misc/styles.dart';

import '../../misc/authProcess.dart';

class registerStanAdmin extends StatefulWidget {
  registerStanAdmin({super.key, required this.nama_pemilik, required this.username});

  final String nama_pemilik;
  final String username;

  @override
  State<registerStanAdmin> createState() => _registerStanAdminState();
}

class _registerStanAdminState extends State<registerStanAdmin> {
  final forming = GlobalKey<FormState>();

  final inputNamaStan = TextEditingController();
  final inputTelp = TextEditingController();
  final inputPass = TextEditingController();
  final inputConfirmPass = TextEditingController();

  bool hidePass = true;
  bool hidePass2 = true;

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
                Text("Daftar sebagai Pemilik Stan", style: fonts().googleSansBold(Colors.black, 32)),
                Text("yuk lengkapi dulu datanya!", style: fonts().googleSansRegular(Colors.black, 20)),
                SizedBox(height: 24),
                Text("Nama Lengkap: ${widget.nama_pemilik}", style: fonts().googleSansRegular(Colors.black, 24)),
                Text("Username: ${widget.username}", style: fonts().googleSansRegular(Colors.black, 24)),
                SizedBox(height: 18),
                Form(
                  key: forming,
                  child: Container(
                    margin: EdgeInsets.only(right: 24, left: 24),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: inputNamaStan,
                          validator: (value) {
                            if (value == null ||  value.isEmpty) {
                              return 'Harap Masukkan Nama Stan';
                            }
                            return null;
                          },
                          cursorRadius: Radius.circular(69),
                          decoration: const InputDecoration(
                            labelText: "Nama Stan",
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
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(right: 24, left: 24),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (forming.currentState!.validate()) {
                        await auth().registerStan(widget.nama_pemilik, inputNamaStan.text, inputTelp.text, widget.username, inputPass.text, context);
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

