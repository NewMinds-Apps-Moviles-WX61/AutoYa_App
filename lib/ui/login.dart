

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_application_1/ui/inicio_sesion.dart';
import 'package:flutter_application_1/ui/loginowner.dart';
import 'package:flutter_application_1/ui/registertenant.dart';

class Login extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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
                            text: 'Are you a Tenant? ',
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
                     
                     
                  ),
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
                SizedBox(
                  height: 30.0,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => RegisterTenant()));
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 65, 65, 65)),
                    minimumSize:
                        MaterialStateProperty.all(Size(double.infinity, 30)),
                  ),
                  child: Text(
                    'REGISTER AS A TENANT',
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
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Login()));
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 9, 207, 16)),
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
