import 'package:flutter/material.dart';

import 'pages/setAnything.dart';
import 'pages/account.dart';
import 'pages/order.dart';
import 'pages/home.dart';

class overlayHomeA extends StatefulWidget {
  overlayHomeA({super.key});

  @override
  State<overlayHomeA> createState() => _overlayHomeAState();
}

class _overlayHomeAState extends State<overlayHomeA> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            IndexedStack(
              index: selectedIndex,
              children: <Widget>[
                beranda(),
                orderPage(),
                setAnything(),
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
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_outlined),
            activeIcon: Icon(Icons.receipt),
            label: 'Pesanan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tune_outlined),
            activeIcon: Icon(Icons.tune),
            label: 'Atur',
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
