import 'package:airsoftmarket/app/modules/home/views/home_view.dart';
import 'package:airsoftmarket/app/modules/profile/views/profile_view.dart';
import 'package:airsoftmarket/app/utils/color.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State {
  int _selectedIndex = 0;

  final _widgetOptions = [
    // Get.offAllNamed(Routes.HOME),
    HomeView(),
    // CartScreen(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.add_shopping_cart_outlined),
          //   label: 'Cart',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        fixedColor: mainColors,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
