import 'package:flutter/material.dart';

import '../../resources/AppColors.dart';
import '../cart_history.dart';
import 'HomePage.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  var _selectedPage = 0;
  List pages = [
    HomePage(),
    Container(
      child: Text("Fuck"),
    ),
    CartHistoryPage(),
    Container(
      child: Text("Fuck me harder"),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) => setState(() {
          _selectedPage = index;
        }),
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: Colors.black87,
        showUnselectedLabels: false,
        currentIndex: _selectedPage,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.archive), label: "Archive"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined), label: "ShoppingCart"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
