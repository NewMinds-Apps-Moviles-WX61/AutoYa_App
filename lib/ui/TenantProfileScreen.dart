import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/tenant_home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'SearchCarPage.dart';

class TenantProfileScreen extends StatefulWidget {
  @override
  _TenantProfileScreenState createState() => _TenantProfileScreenState();
}

class _TenantProfileScreenState extends State<TenantProfileScreen> {
  int _selectedIndex = 0;
  late Future<User> _futureUser;

  Future<User> fetchUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');

    if (userId == null) {
      throw Exception('User ID not found in SharedPreferences');
    }

    final response = await http.get(Uri.parse('https://auto-ya-moviles-backend.azurewebsites.net/api/v1/users/$userId'));

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }

  @override
  void initState() {
    super.initState();
    _futureUser = fetchUser();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Aquí puedes implementar la lógica para redirigir a la pantalla correspondiente
    switch (index) {
      case 0: // Home
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TenantHomeScreen()),
        );
        break;
      case 1: // Cars
      // Redirigir a la pantalla Cars
        break;
      case 2: // Search
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchCarPage()),
        );
        break;
      case 3: // Chats
      // Redirigir a la pantalla Chats
        break;
      case 4: // Profile
      // Redirigir a la pantalla Profile
        break;
      default:
      // No hacer nada
        break;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tenant Profile'),
      ),
      body: FutureBuilder<User>(
        future: _futureUser,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data found'));
          } else {
            final user = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(user.photoURL),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text('Name: ${user.name}', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 8),
                  Text('Email: ${user.email}', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 8),
                  Text('Phone Number: ${user.phoneNumber}', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 8),
                  Text('DNI: ${user.dni}', style: TextStyle(fontSize: 18)),
                ],
              ),
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFF03253C),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.car_rental),
            label: 'Cars',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
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
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

class User {
  final int id;
  final String name;
  final String email;
  final String phoneNumber;
  final String dni;
  final String photoURL;
  final String type;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.dni,
    required this.photoURL,
    required this.type,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      dni: json['dni'],
      photoURL: json['photoURL'],
      type: json['type'],
    );
  }
}
