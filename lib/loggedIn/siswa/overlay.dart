import 'package:flutter/material.dart';


import 'pages/home.dart';
import 'pages/history.dart';
import 'pages/account.dart';
import '../userData.dart';

class overlayHomeS extends StatefulWidget {
  overlayHomeS({super.key});

  @override
  State<overlayHomeS> createState() => _overlayHomeSState();
}

class _overlayHomeSState extends State<overlayHomeS> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            IndexedStack(
              index: selectedIndex,
              children: const <Widget>[
                beranda(),
                pesanan(),
                akun(),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_outlined),
            activeIcon: Icon(Icons.receipt),
            label: 'Pesanan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Akun',
          ),
        ],
        onTap: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        selectedItemColor: Color.fromARGB(255, 218, 131, 0),
        unselectedItemColor: Color.fromARGB(255, 164, 164, 164),
        showUnselectedLabels: true,
        currentIndex: selectedIndex,
      ),
    );
  }
}
