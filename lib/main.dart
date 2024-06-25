
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/Page-Init/InicioSesion.dart';
import 'IU-Tenant/ui/tenant_home_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'lib/assets/car2.png',
                  height: 30,
                ),
              ),
              Text(
                'AutoYa',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFA0F0F),
                  fontSize: 35,
                ),
              ),
            ],
          ),
          backgroundColor: Color(0xFF03253C), // Púrpura oscuro
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: InicioSesion(),
            ),
          ],
        ),
      ),
      routes: {
        '/tenant_home': (context) => TenantHomeScreen(),
        // Ruta para la nueva vista
      },
    );
  }
}


