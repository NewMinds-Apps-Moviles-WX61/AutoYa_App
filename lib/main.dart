import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/tenant_home_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:shared_preferences/shared_preferences.dart';

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
        '/tenant_home': (context) => TenantHomeScreen(), // Ruta para la nueva vista
      },
    );
  }
}

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
      appBar: _selectedIndex != 0
          ? AppBar(
        backgroundColor: Color(0xFF03253C),
        leading: GestureDetector(
          onTap: () {
            setState(() {
              _selectedIndex = 0;
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'lib/assets/car2.png',
              height: 30,
            ),
          ),
        ),
      )
          : AppBar(
        backgroundColor: Color(0xFF03253C),
        leading: GestureDetector(
          onTap: () {
            // Aquí dirige al Home
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
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
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: _selectedIndex != 1 &&
          _selectedIndex != 2 &&
          _selectedIndex != 3 &&
          _selectedIndex != 4
          ? Container(
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
      )
          : null,
    );
  }
}


/**********************************************************/

class InicioSesion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Image.asset(
                'assets/fon2.jpg',
                fit: BoxFit.cover
            ),
          ),
          Container(color: Color.fromRGBO(2, 2, 2, 0.6)),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Image.asset(
                        'lib/assets/car2.png',
                        height: 140,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Register or log in',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //------------------google
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: InteractiveButtongoogle(),
                    ),
                    //-------------------facebook
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: InteractiveButtonfacebook(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'or continue with email',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //-------------------email
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: InteractiveButtonemail(),
                    ),
                    //---------------------------------
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'Already have an account ',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'SIGN UP',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.blue,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Login()),
                                        );
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

/*login de ambos*/
class Login extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  // ---------------------------------------------------------------------

  Future<void> _login(BuildContext context) async {
    String email = _emailController.text;
    String password = _passwordController.text;

    // Realizar la solicitud HTTP al backend
    var url = Uri.parse(
        'https://auto-ya-moviles-backend.azurewebsites.net/api/v1/users/login');
    var response = await http.post(
      url,
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TenantHomeScreen()),
      );
    } else {
      // Si hay un error, mostrar un mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: Usuario o contraseña incorrectos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 19, 19, 19),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 30, top: 50),
                  child: Image.asset(
                    'lib/assets/car2.png',
                    height: 100,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Sign in Tenant',
                            style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 239, 16, 0)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Are you a Car Owner? ',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                            children: [
                              TextSpan(
                                text: 'Go to car Owner',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: const Color.fromARGB(255, 9, 207, 16),
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginOwner()),
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),


                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(
                        color: const Color.fromARGB(255, 187, 187, 187)),
                    border: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.white), // Borde blanco
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Color.fromARGB(255, 42, 235, 48)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red[400]!, width: 2.0),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.white),
                ),

                SizedBox(height: 20.0),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                        color: const Color.fromARGB(255, 187, 187, 187)),
                    border: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.white), // Borde blanco
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Color.fromARGB(255, 42, 235, 48)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red[400]!, width: 2.0),
                    ),
                  ),
                  obscureText: true,
                  style: TextStyle(color: Colors.white),
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: 20, top: 20),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'FORGOT YOUR PASSWORD',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: const Color.fromARGB(255, 9, 207, 16),
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Login()),
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => RegisterTenant()));
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 65, 65, 65)),
                    minimumSize:
                    MaterialStateProperty.all(Size(double.infinity, 30)),
                  ),
                  child: Text(
                    'REGISTER AS A TENANT',
                    style: TextStyle(
                      fontFamily: 'Arial',
                      color: Colors.white,
                      fontSize: 26,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                  width: 18.0,
                ),
                TextButton(
                  onPressed: () => _login(context),
                  // Llamar a la función de inicio de sesión
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 9, 207, 16)),
                    minimumSize:
                    MaterialStateProperty.all(Size(double.infinity, 30)),
                  ),
                  child: Text(
                    'SIGN IN',
                    style: TextStyle(
                      fontFamily: 'Arial',
                      color: Colors.white,
                      fontSize: 32,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginOwner extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  // ---------------------------------------------------------------------

  Future<void> _login(BuildContext context) async {
    String email = _emailController.text;
    String password = _passwordController.text;

    // Realizar la solicitud HTTP al backend
    var url = Uri.parse(
        'https://auto-ya-moviles-backend.azurewebsites.net/api/v1/users/login');
    var response = await http.post(
      url,
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      // Si el inicio de sesión es exitoso, redirigir al usuario a la página de inicio de sesión
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      // Si hay un error, mostrar un mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: Usuario o contraseña incorrectos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 19, 19, 19),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 30, top: 80),
                  child: Image.asset(
                    'lib/assets/car2.png',
                    height: 100,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Sign in Owner',
                            style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 239, 16, 0)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Are you a Car Owner? ',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                            children: [
                              TextSpan(
                                text: 'Go to Tenant',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: const Color.fromARGB(255, 9, 207, 16),
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Login()),
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),


                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(
                        color: const Color.fromARGB(255, 187, 187, 187)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white), // Borde blanco
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 42, 235, 48)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red[400]!, width: 2.0),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.white),
                ),

                SizedBox(height: 20.0),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                        color: const Color.fromARGB(255, 187, 187, 187)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white), // Borde blanco
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 42, 235, 48)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red[400]!, width: 2.0),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                  obscureText: true,
                ),


                Padding(
                  padding: EdgeInsets.only(bottom: 20, top: 20),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'FORGOT YOUR PASSWORD',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: const Color.fromARGB(255, 9, 207, 16),
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Login()),
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //boton de login
                SizedBox(
                  height: 30.0,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => RegisterOwner()));
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 65, 65, 65)),
                    minimumSize:
                    MaterialStateProperty.all(Size(double.infinity, 30)),
                  ),
                  child: Text(
                    'REGISTER AS A OWNER',
                    style: TextStyle(
                      fontFamily: 'Arial',
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextButton(
                  onPressed: () => _login(context), // Logeo
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 9, 207, 16)),
                    minimumSize:
                    MaterialStateProperty.all(Size(double.infinity, 30)),
                  ),
                  child: Text(
                    'Sign in',
                    style: TextStyle(
                      fontFamily: 'Arial',
                      color: Colors.white,
                      fontSize: 40,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*Register everyone*/
class RegisterTenant extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<RegisterTenant> {
  TextEditingController _nameController = TextEditingController();
  DateTime _birthday = DateTime.now();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _dniController = TextEditingController();
  TextEditingController _licencenumberController = TextEditingController();

  //-----------------------------------------------------------------
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _birthday,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _birthday) {
      setState(() {
        _birthday = picked;
      });
    }
  }

  Future<void> _register() async {
    final String apiUrl = "https://auto-ya-moviles-backend.azurewebsites.net/api/v1/tenants";
    final Map<String, dynamic> data = {
      "name": _nameController.text,
      "email": _emailController.text,
      "password": _passwordController.text,
      "phoneNumber": _phoneController.text,
      "dni": _dniController.text,
      "LicenceNumber": _licencenumberController.text,
      "photoURL": "https://i.postimg.cc/QMYLzms6/6326055.png",
      "CriminalRecordURL": "criminalrecord.com"
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(data),

    );

    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    } else {
      // Handle errors here
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration failed. Please try again.')),
      );
    }
  }

  //-----------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 19, 19, 19),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
            Padding(
            padding: const EdgeInsets.only(bottom: 20.0, top: 40),
            child: Text(
              'Register Tenant',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 252, 30, 14),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(

                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegisterOwner()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.grey[600]),
                  foregroundColor:
                  MaterialStateProperty.all(Colors.white),
                  textStyle: MaterialStateProperty.all(
                    TextStyle(fontSize: 20),
                  ),
                ),
                child: Text('OWNER'),
              ),
              SizedBox(width: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegisterTenant()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 9, 207, 16)),
                  foregroundColor:
                  MaterialStateProperty.all(Colors.white),
                  textStyle: MaterialStateProperty.all(
                    TextStyle(fontSize: 20),
                  ),
                ),
                child: Text('TENANT'),
              ),
            ],
          ),
          SizedBox(height: 20),
          _buildTextField(
            controller: _nameController,
            labelText: 'Name',
          ),
          SizedBox(height: 15),
          _buildTextField(
            controller: _phoneController,
            labelText: 'Phone',
          ),
          SizedBox(height: 15),
          _buildTextField(
            controller: _emailController,
            labelText: 'Email',
          ),
          SizedBox(height: 15),
          _buildTextField(
            controller: _dniController,
            labelText: 'DNI',
          ),
          SizedBox(height: 15),
          _buildTextField(
            controller: _passwordController,
            labelText: 'Password',
            obscureText: true,
          ),
          SizedBox(height: 15),
          _buildTextField(
            controller: _licencenumberController,
            labelText: 'Licence Number',
            obscureText: true,
          ),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: _register,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  Color.fromARGB(255, 4, 221, 4)),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              textStyle: MaterialStateProperty.all(
                TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'REGISTER',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),)
    ,
    )
    ,
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.white),
        floatingLabelStyle: TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 2.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red[400]!, width: 2.0),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      ),
    );
  }
}

class RegisterOwner extends StatefulWidget {
  @override
  _RegisterStateOwner createState() => _RegisterStateOwner();
}

class _RegisterStateOwner extends State<RegisterOwner> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dniController = TextEditingController();

  String _message = '';

  Future<void> _registerOwner() async {
    if (_formKey.currentState!.validate()) {
      final response = await http.post(
        Uri.parse('https://auto-ya-moviles-backend.azurewebsites.net/api/v1/propietaries'),
        body: jsonEncode({
          'name': _nameController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
          'phoneNumber': _phoneController.text,
          'dni': _dniController.text,
          'photoURL': 'https://i.postimg.cc/QMYLzms6/6326055.png',
          'ContractURL': 'contract.com',
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final userId = data['id'];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userId', userId.toString());
        await prefs.setString('userName', _nameController.text);
        await prefs.setString('userEmail', _emailController.text);
        await prefs.setString('userPhone', _phoneController.text);
        await prefs.setString('userDni', _dniController.text);

        setState(() {
          _message = 'Owner registered successfully';
        });

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginOwner()),
        );
      } else {
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        setState(() {
          _message = 'Failed to register owner';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 19, 19, 19),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0, top: 40),
                child: Container(
                  height: 100,
                  alignment: Alignment.center,
                  child: Text(
                    'Register Owner',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 252, 30, 14),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterOwner()),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 9, 207, 16)),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      textStyle: MaterialStateProperty.all(
                        TextStyle(fontSize: 20),
                      ),
                    ),
                    child: Text('OWNER'),
                  ),
                  SizedBox(width: 30),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterTenant()),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.grey),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      textStyle: MaterialStateProperty.all(
                        TextStyle(fontSize: 20),
                      ),
                    ),
                    child: Text('TENANT'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              _buildTextField(
                controller: _nameController,
                labelText: 'Name',
              ),
              SizedBox(height: 15),
              _buildTextField(
                controller: _phoneController,
                labelText: 'Phone',
              ),
              SizedBox(height: 15),
              _buildTextField(
                controller: _emailController,
                labelText: 'Email',
              ),
              SizedBox(height: 15),
              _buildTextField(
                controller: _passwordController,
                labelText: 'Password',
                obscureText: true,
              ),
              SizedBox(height: 15),
              _buildTextField(
                controller: _dniController,
                labelText: 'DNI',
                obscureText: false,
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: _registerOwner,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 9, 207, 16)),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  textStyle: MaterialStateProperty.all(
                    TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(width: 8),
                      Text('REGISTER'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(_message, style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.white),
        floatingLabelStyle: TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 2.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red[400]!, width: 2.0),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      ),
    );
  }
}


//boton de continue con google
class InteractiveButtongoogle extends StatefulWidget {
  @override
  _InteractiveButtonStategoogle createState() =>
      _InteractiveButtonStategoogle();
}

class _InteractiveButtonStategoogle extends State {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        width: _isPressed ? 180 : 200,
        height: _isPressed ? 60 : 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              child: Image.asset(
                'lib/assets/logogoogle.png',
              ),
            ),
            SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Continue with Google',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//boton de continue con facebook
class InteractiveButtonfacebook extends StatefulWidget {
  @override
  _InteractiveButtonStatefacebook createState() =>
      _InteractiveButtonStatefacebook();
}

class _InteractiveButtonStatefacebook extends State {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        width: _isPressed ? 180 : 200,
        height: _isPressed ? 60 : 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              child: Image.asset(
                'lib/assets/logofacebook.png',
              ),
            ),
            SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Continue with Facebook',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//boton de continue con email
class InteractiveButtonemail extends StatefulWidget {
  @override
  _InteractiveButtonStateemail createState() => _InteractiveButtonStateemail();
}

class _InteractiveButtonStateemail extends State {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        width: _isPressed ? 180 : 200,
        height: _isPressed ? 60 : 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 30,
              height: 30,
              child: Image.asset(
                'lib/assets/logoemail.png',
              ),
            ),
            SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Continue with Email',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


/**********************************************************/

class StarRating extends StatelessWidget {
  final int numberOfStars;

  StarRating({required this.numberOfStars});

  @override
  Widget build(BuildContext context) {
    final starString = '⭐' * numberOfStars;

    return Text(
      starString,
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class PopularServicesScreen extends StatefulWidget {
  @override
  _PopularServicesScreenState createState() => _PopularServicesScreenState();
}

class _PopularServicesScreenState extends State<PopularServicesScreen> {
  List<dynamic> popularServices = [];
  List<String> usedImageUrls = [];

  @override
  void initState() {
    super.initState();
    fetchPopularServices();
  }

  List<String> placeholderImageUrls = [
    'https://static.retail.autofact.cl/blog/20161018170049_740x3708932509314539659214.jpg',
    // Placeholder 1
    'https://derco-pe-prod.s3.amazonaws.com/images/versions/2021-05-06-changan_alsvin_640x400..jpg',
    'https://www.elcarrocolombiano.com/wp-content/uploads/2021/01/20210124-LOS-10-CARROS-MAS-VENDIDOS-DEL-MUNDO-EN-2020-01.jpg',
    'https://www.elcarrocolombiano.com/wp-content/uploads/2019/01/20190121-TOP-100-AUTOS-MAS-VENDIDOS-DEL-MUNDO-EN-2018-01.jpg',
    'https://lh4.googleusercontent.com/vr9VXG9EwtNrb5YKejtcPJ9BI6qsmOF10p-TJnvvswE0lMwR6NY0nCvu3UZkxna-a_BNmBy566Iu9QaG1T6k36raoYByLpVoqhwGeoZWJzECnSHtfXfnIZqpQzfWsTQIwfOXY6ND',
    'https://derco-pe-prod.s3.amazonaws.com/medias/changan/migration/front-image/new-van/SC6406A-F2K_Blanco.jpg',
    'https://enterados.pe/wp-content/uploads/2021/03/chevrolet-unlimited-vf.jpg',
    'https://http2.mlstatic.com/D_NQ_NP_758409-MLM75961796248_052024-O.webp',
    'https://acroadtrip.blob.core.windows.net/catalogo-imagenes/xl/RT_V_23e4c880eb844c96a5939f8bf8f5ccc0.jpg',
    'https://cloudfront-us-east-1.images.arcpublishing.com/elcomercio/ZF53L74CXRGNXEMZXILAOLUZB4.jpg',
    'https://quasar.com.pe/wp-content/uploads/2022/09/renting-pickup-equipada.jpg',
    'https://www.movilcarhuancayo.com/wp-content/uploads/2021/01/van2021-002.jpg',
    'https://acroadtrip.blob.core.windows.net/catalogo-imagenes/m/RT_V_9ddf350bde8944e58274c387b928ef1b.jpg',
  ];

  Future<void> fetchPopularServices() async {
    try {
      final response = await http.get(Uri.parse(
          'https://auto-ya-moviles-backend.azurewebsites.net/api/v1/cars'));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        setState(() {
          popularServices = jsonResponse.map((service) {
            if (service['photoURL'] == null) {
              String imageUrl;
              do {
                final random = Random();
                imageUrl = placeholderImageUrls[random.nextInt(
                    placeholderImageUrls.length)];
              } while (usedImageUrls.contains(imageUrl));
              service['photoURL'] = imageUrl;
              usedImageUrls.add(imageUrl);
            }
            return service;
          }).toList();
        });
      } else {
        throw Exception('Failed to load popular services');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(10.0),
            width: double.infinity,
            child: Text(
              'Popular Brand',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D26C5),
              ),
            ),
          ),
          Container(
            height: 120,
            color: Colors.orange[100],
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: popularServices.map((service) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(service['photoURL'] ??
                                  'https://via.placeholder.com/80'),
                              fit: BoxFit.contain,
                            ),
                            border: Border.all(
                              color: Colors.blue,
                              width: 3.0,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          service['brand'] ?? 'Unknown',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: popularServices.length,
              itemBuilder: (context, index) {
                final service = popularServices[index];
                final random = Random();
                final numberOfStars = random.nextInt(3) + 3;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    child: Card(
                      color: Colors.deepPurple[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 5,
                      child: Row(
                        children: [
                          // Imagen...
                          Container(
                            width: 150,
                            height: 150,
                            padding: EdgeInsets.all(10),
                            child: service['photoURL'] != null
                                ? Image.network(
                              service['photoURL'],
                              fit: BoxFit.contain,
                            )
                                : Placeholder(),
                          ),
                          // Detalles...
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFDED3E7),
                                  borderRadius: BorderRadius.circular(15.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      // Imagen con borde...
                                      Container(
                                        width: double.infinity,
                                        height: 150,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              10.0),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                service['photoURL'] ??
                                                    'https://via.placeholder.com/150'),
                                            fit: BoxFit.cover,
                                          ),
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      // Nombre del servicio...
                                      Text(
                                        service['brand'] ?? 'Unknown',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF03253C),
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      // Precio...
                                      Text(
                                        '${service['price'] ?? 'N/A'} PEN',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      // Ubicación...
                                      Row(
                                        children: [
                                          Icon(Icons.location_on,
                                              color: Colors.red, size: 16),
                                          SizedBox(width: 4),
                                          Text(
                                            service['location'] ??
                                                'Unknown location',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      // Estado...
                                      Row(
                                        children: [
                                          Icon(Icons.info, color: Colors.blue,
                                              size: 16),
                                          SizedBox(width: 4),
                                          Text(
                                            service['status'] ??
                                                'Unknown status',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      // Rating...
                                      StarRating(numberOfStars: numberOfStars),
                                      SizedBox(height: 10),
                                      // Botones...
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceEvenly,
                                        children: [
                                          // Botón de like...
                                          IconButton(
                                            onPressed: () {
                                              // Acción para dar like...
                                            },
                                            icon: Icon(Icons.thumb_up),
                                            color: Colors.green,
                                          ),
                                          // Botón de favorito...
                                          IconButton(
                                            onPressed: () {
                                              // Acción para marcar como favorito...
                                            },
                                            icon: Icon(Icons.favorite),
                                            color: Colors.red,
                                          ),
                                          // Botón de compartir...
                                          IconButton(
                                            onPressed: () {
                                              // Acción para compartir...
                                            },
                                            icon: Icon(Icons.share),
                                            color: Colors.blue,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )

                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

String generateRandomPlate() {
  Random random = Random();
  String letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  String numbers = '0123456789';
  String plate = '';

  // Genera tres letras aleatorias
  for (int i = 0; i < 3; i++) {
    plate += letters[random.nextInt(letters.length)];
  }

  // Genera tres números aleatorios
  for (int i = 0; i < 3; i++) {
    plate += numbers[random.nextInt(numbers.length)];
  }

  return plate;
}

class RegisterCar extends StatefulWidget {
  @override
  _RegisterCarState createState() => _RegisterCarState();
}

class _RegisterCarState extends State<RegisterCar> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _yearManufacturedController = TextEditingController();
  final TextEditingController _fuelTypeController = TextEditingController();
  final TextEditingController _transmissionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _passengerCapacityController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _mileageController = TextEditingController();
  final TextEditingController _conditionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  bool _acValue = false;
  bool _gpsValue = false;

  Future<void> _registerCar() async {
    if (_formKey.currentState!.validate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? propietaryID = prefs.getString('userId');

      if (propietaryID != null) {
        try {
          final carData = {
            'brand': _brandController.text,
            'model': _modelController.text,
            'yearManufactured': _yearManufacturedController.text,
            'fuelType': _fuelTypeController.text,
            'transmission': _transmissionController.text,
            'category': _categoryController.text,
            'passengerCapacity': _passengerCapacityController.text,
            'color': _colorController.text,
            'mileage': _mileageController.text,
            'condition': _conditionController.text,
            'price': _priceController.text,
            'ac': _acValue,
            'gps': _gpsValue,
            'location': _locationController.text,
            'status': _statusController.text,
            'PropietaryID': propietaryID,
            'Plate': generateRandomPlate(),
          };


          final response = await http.post(
            Uri.parse('https://auto-ya-moviles-backend.azurewebsites.net/api/v1/cars'),
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode(carData),
          );

          if (response.statusCode == 200) {
            _showSnackBar('Car registered successfully', Colors.green);
          } else if (response.statusCode == 400) {
            if (response.body.contains('Car with that plate already exists')) {
              _showSnackBar('Car with that plate already exists', Colors.red);
            } else {
              print('HTTP request failed with status: ${response.statusCode}');
              print('Response body: ${response.body}');
              _showSnackBar('Failed to register car', Colors.red);
            }
          } else {
            print('HTTP request failed with status: ${response.statusCode}');
            print('Response body: ${response.body}');
            _showSnackBar('Failed to register car', Colors.red);
          }
        } catch (error) {
          print('Error: $error');
          _showSnackBar('An error occurred', Colors.red);
        }
      } else {
        _showSnackBar('User ID not found', Colors.red);
      }
    }
  }

  void _showSnackBar(String message, Color color) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: color,
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/img_3.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.darken),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                SizedBox(height: 100),
                Center(
                  child: Text(
                    'Register Car',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(child: _buildTextFormField(_brandController, 'Brand')),
                    SizedBox(width: 20),
                    Expanded(child: _buildTextFormField(_modelController, 'Model')),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: _buildTextFormField(_yearManufacturedController, 'Year Manufactured')),
                    SizedBox(width: 20),
                    Expanded(child: _buildTextFormField(_fuelTypeController, 'Fuel Type')),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: _buildTextFormField(_transmissionController, 'Transmission')),
                    SizedBox(width: 20),
                    Expanded(child: _buildTextFormField(_categoryController, 'Category')),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: _buildTextFormField(_passengerCapacityController, 'Passenger Capacity')),
                    SizedBox(width: 20),
                    Expanded(child: _buildTextFormField(_colorController, 'Color')),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: _buildTextFormField(_mileageController, 'Mileage')),
                    SizedBox(width: 20),
                    Expanded(child: _buildTextFormField(_conditionController, 'Condition')),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: _buildTextFormField(_priceController, 'Price')),
                    SizedBox(width: 20),
                    Expanded(child: _buildTextFormField(_locationController, 'Location')),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: _buildTextFormField(_statusController, 'Status')),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: CheckboxListTile(
                        title: Text('AC', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        value: _acValue,
                        onChanged: (value) {
                          setState(() {
                            _acValue = value!;
                          });
                        },
                        activeColor: Colors.green,
                        checkColor: Colors.white,
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                    Expanded(
                      child: CheckboxListTile(
                        title: Text('GPS', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        value: _gpsValue,
                        onChanged: (value) {
                          setState(() {
                            _gpsValue = value!;
                          });
                        },
                        activeColor: Colors.green,
                        checkColor: Colors.white,
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _registerCar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Register Car',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(TextEditingController controller, String labelText) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter the $labelText';
          }
          return null;
        },
        style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          labelText: labelText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class SearchCarsScreen extends StatefulWidget {
  @override
  _FriendsScreenState createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<SearchCarsScreen> {
  List<dynamic> brands = [];

  @override
  void initState() {
    super.initState();
    fetchBrands();
  }

  Future<void> fetchBrands() async {
    final response =
    await http.get(Uri.parse('http://192.168.0.10:8080/api/favore/v1/all'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      setState(() {
        brands = jsonResponse['cars'];
      });
    } else {
      throw Exception('Failed to load brands');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SearchBar(brands),
        BrandsList(brands),
      ],
    );
  }
}


class SearchBar extends StatefulWidget {
  final List<dynamic> brands;

  SearchBar(this.brands);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _searchController = TextEditingController();
  List<dynamic> filteredBrands = [];
  List<dynamic> originalBrands = [];

  @override
  void initState() {
    super.initState();
    originalBrands = widget.brands;
    filteredBrands = widget.brands;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void filterBrands(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredBrands = originalBrands;
      } else {
        filteredBrands = originalBrands.where((brand) {
          String brandName = brand['name'].toLowerCase();
          String brandBrand = brand['brand'].toLowerCase();
          String searchQuery = query.toLowerCase();

          // Buscar coincidencias en el nombre y la marca
          return brandName.contains(searchQuery) ||
              brandBrand.contains(searchQuery);
        }).toList();

        // Ordenar los resultados por relevancia
        filteredBrands.sort((a, b) {
          int aScore = _calculateRelevanceScore(a, query);
          int bScore = _calculateRelevanceScore(b, query);
          return bScore.compareTo(aScore);
        });
      }
    });
  }

  int _calculateRelevanceScore(Map<String, dynamic> brand, String query) {
    String brandName = brand['name'].toLowerCase();
    String brandBrand = brand['brand'].toLowerCase();
    String searchQuery = query.toLowerCase();

    int nameScore =
    brandName.contains(searchQuery) ? brandName.indexOf(searchQuery) : -1;
    int brandScore =
    brandBrand.contains(searchQuery) ? brandBrand.indexOf(searchQuery) : -1;

    // Dar prioridad a las coincidencias en el nombre sobre las coincidencias en la marca
    return nameScore >= 0 ? nameScore : brandScore + 100;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _searchController,
            onChanged: (value) {
              filterBrands(value);
            },
            decoration: InputDecoration(
              hintText: 'Search',
              prefixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  filterBrands(_searchController.text);
                },
              ),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  _searchController.clear();
                  filterBrands('');
                },
              )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BrandsList extends StatelessWidget {
  final List<dynamic> filteredBrands;

  BrandsList(this.filteredBrands);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Brands',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF03253C),
            ),
          ),
        ),
        SizedBox(height: 8),
        if (filteredBrands.isEmpty)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'No matching brands found.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: filteredBrands.length,
            itemBuilder: (context, index) {
              final brand = filteredBrands[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 5,
                  child: ListTile(
                    leading: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: NetworkImage(brand['photoURL']),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(
                      brand['name'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow),
                        Icon(Icons.star, color: Colors.yellow),
                        Icon(Icons.star, color: Colors.yellow),
                        Icon(Icons.star, color: Colors.yellow),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];

  late String ownerName;
  late String ownerPhotoURL;

  @override
  void initState() {
    super.initState();
    _loadOwnerData();
  }

  Future<void> _loadOwnerData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      ownerName = prefs.getString('ownerName') ?? 'User1';
      ownerPhotoURL = prefs.getString('ownerPhotoURL') ?? 'https://i.postimg.cc/QMYLzms6/6326055.png';
    });
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    ChatMessage message = ChatMessage(
      text: text,
      ownerName: ownerName,
      ownerPhotoURL: ownerPhotoURL,
    );
    setState(() {
      _messages.insert(0, message);
    });
  }

  Widget _buildTextComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              decoration: InputDecoration(
                hintText: "Enviar un mensaje",
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 15.0,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: Colors.blue),
            onPressed: () => _handleSubmitted(_textController.text),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bandeja de mensajes"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (_, int index) => _messages[index],
            ),
          ),
          Divider(height: 1.0),
          _buildTextComposer(),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({required this.text, required this.ownerName, required this.ownerPhotoURL});

  final String text;
  final String ownerName;
  final String ownerPhotoURL;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              child: ClipOval(
                child: Image.network(
                  ownerPhotoURL,
                  height: 35,
                  width: 35,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ownerName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  width: 195,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade300,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0),
                    ),
                  ),
                  child: Text(text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



late String userPhotoURL = '';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String userName;
  late String userEmail;
  late String userPhone;
  late String userDni;
  late String userPhotoURL;

  bool _isEditing = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _dniController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? '';
      userEmail = prefs.getString('userEmail') ?? '';
      userPhone = prefs.getString('userPhone') ?? '';
      userDni = prefs.getString('userDni') ?? 'Unknown';
      userPhotoURL = prefs.getString('userPhotoURL') ?? 'https://i.postimg.cc/QMYLzms6/6326055.png';

      _nameController.text = userName;
      _emailController.text = userEmail;
      _phoneController.text = userPhone;
      _dniController.text = userDni;
    });
  }

  Future<void> _saveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', _nameController.text);
    await prefs.setString('userEmail', _emailController.text);
    await prefs.setString('userPhone', _phoneController.text);
    await prefs.setString('userDni', _dniController.text);
    await prefs.setString('userPhotoURL', userPhotoURL);
  }

  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      final response = await http.put(
        Uri.parse('https://auto-ya-moviles-backend.azurewebsites.net/api/v1/users'),
        body: jsonEncode({
          'name': _nameController.text,
          'email': _emailController.text,
          'phoneNumber': _phoneController.text,
          'dni': _dniController.text,
          'photoURL': userPhotoURL,
          // Otros campos necesarios para actualizar el perfil
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        _saveUserData();
        setState(() {
          _isEditing = false;
        });
      } else {
        print('Failed to update profile: ${response.statusCode}');
      }
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        userPhotoURL = pickedFile.path;
      });
      // Aquí puedes subir la imagen al servidor y actualizar `userPhotoURL`
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Información Personal"),
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: Colors.white),
            onPressed: () {
              setState(() {
                _isEditing = true;
              });
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        color: Colors.grey[200],
        child: _isEditing ? _buildEditForm() : _buildProfileInfo(),
      ),
    );
  }

  Widget _buildProfileInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: GestureDetector(
            onTap: _pickImage,
            child: CircleAvatar(
              radius: 50.0,
              backgroundColor: Colors.blue,
              backgroundImage: userPhotoURL.startsWith('http')
                  ? NetworkImage(userPhotoURL)
                  : FileImage(File(userPhotoURL)) as ImageProvider,
              child: userPhotoURL == ''
                  ? Icon(Icons.camera_alt, size: 50, color: Colors.white)
                  : null,
            ),
          ),
        ),
        SizedBox(height: 20.0),
        _buildInfoItem("Name:", userName),
        _buildInfoItem("Email:", userEmail),
        _buildInfoItem("Phone:", userPhone),
        _buildInfoItem("Documento de Identidad:", userDni),
      ],
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Color del texto del label
          ),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 16.0),
        ),
        SizedBox(height: 10.0),
      ],
    );
  }

  Widget _buildEditForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFormField("Name", _nameController),
          _buildFormField("Email", _emailController),
          _buildFormField("Phone", _phoneController),
          _buildFormField("Documento de Identidad", _dniController),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _updateProfile,
                child: Text("Save"),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue, // Color del texto del botón
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isEditing = false;
                  });
                },
                child: Text("Cancel"),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.grey, // Color del texto del botón
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFormField(String labelText, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $labelText';
        }
        return null;
      },
    );
  }
}










