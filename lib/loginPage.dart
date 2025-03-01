import 'package:flutter/material.dart';

import 'misc/styles.dart';
import 'misc/fonts.dart';

import 'misc/authProcess.dart';
import 'registerPage/regisPage1.dart';
import 'landingPage.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final forming = GlobalKey<FormState>();

  final inputUser = TextEditingController();
  final inputPass = TextEditingController();

  bool hidePass = true;

  @override
  void dispose() {
    inputUser.dispose();
    inputPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 243, 224, 1.0),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Masuk", style: fonts().googleSansBold(Colors.black, 32)),
              SizedBox(height: 24),
              Form(
                key: forming,
                child: Container(
                  margin: EdgeInsets.only(right: 24, left: 24),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: inputUser,
                        validator: (value) {
                          if (value == null ||  value.isEmpty) {
                            return 'Harap Masukkan Username';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
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

                      SizedBox(height: 12),

                      TextFormField(
                        controller: inputPass,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
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
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(14)),
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
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                      ),

                      SizedBox(height: 24),

                      Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (forming.currentState!.validate()) {
                                  await auth().login(inputUser.text, inputPass.text, context);
                                }
                              },
                              style: style().buttonCustom(Color.fromRGBO(47, 218, 0, 1.0), Colors.white, 18, FontWeight.bold),
                              child: Text("Masuk"),
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

                      Text("Tidak punya akun? Daftar sekarang menggunakan tombol dibawah ini!", textAlign: TextAlign.center, style: fonts().googleSansRegular(Colors.black, 16)),
                      SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => registerPage()));
                        },
                        style: style().buttonCustom(Colors.blueAccent, Colors.white, 18, FontWeight.bold),
                        child: Text("Daftar Akun!"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

