import 'package:flutter/material.dart';

import '../IU-OWNER/botons/chat/ChatScreen.dart';
import '../IU-OWNER/botons/profile/ProfileScreen.dart';
import '../IU-OWNER/botons/registerCars/RegisterCar.dart';
import '../IU-OWNER/botons/search/SearchCarsScreen.dart';
import '../IU-OWNER/home/PopularServicesScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    PopularServicesScreen(),
    RegisterCar(),
    SearchCarsScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        color: Color(0xFF03253C),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.app_registration),
              label: 'Register Car',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search Cars',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: 'Chats',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Color(0xFFF10303),
          unselectedItemColor: Colors.white,
          backgroundColor: Color(0xFF03253C),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
