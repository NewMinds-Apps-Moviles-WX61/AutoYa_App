import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_application_1/ui/login.dart';
import 'package:flutter_application_1/ui/inicio_sesion.dart';

import 'package:flutter_application_1/ui/registerowner.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginOwner extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  // ---------------------------------------------------------------------

Future<void> _login(BuildContext context) async {
    String email = _emailController.text;
    String password = _passwordController.text;

    // Realizar la solicitud HTTP al backend
    var url = Uri.parse('https://auto-ya-moviles-backend.azurewebsites.net/api/v1/users/login');
    var response = await http.post(
      url,
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
    );

if (response.statusCode == 200) {
  
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginOwner()),
      );
    } else {
      // Si hay un error, mostrar un mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: Usuario o contraseña incorrectos')),
      );
    }
  }




   // ---------------------------------------------------------------------


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
                    'assets/logoautoya.png',
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
                     labelStyle: TextStyle(color: const Color.fromARGB(255, 187, 187, 187)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white), // Borde blanco
                    ),
                    enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(255, 42, 235, 48)),
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
                     labelStyle: TextStyle(color: const Color.fromARGB(255, 187, 187, 187)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white), // Borde blanco
                    ),
                    enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(255, 42, 235, 48)),
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
                    backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 65, 65, 65)),
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
