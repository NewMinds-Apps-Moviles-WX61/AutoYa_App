import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../IU-Tenant/login/Login.dart';
import '../main.dart';
import 'links/InteractiveButtonemail.dart';
import 'links/InteractiveButtonfacebook.dart';
import 'links/InteractiveButtongoogle.dart';

class InicioSesion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'lib/assets/fon2.jpg',
            fit: BoxFit.cover,
          ),
          Container(color: Color.fromRGBO(2, 2, 2, 0.6)),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      'lib/assets/car2.png',
                      height: 140,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Register or log in',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(height: 20),
                    InteractiveButtongoogle(),
                    SizedBox(height: 10),
                    InteractiveButtonfacebook(),
                    SizedBox(height: 20),
                    Text(
                      'or continue with email',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    InteractiveButtonemail(),
                    SizedBox(height: 20),
                    RichText(
                      textAlign: TextAlign.center,
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
                                    builder: (context) => Login(),
                                  ),
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
          ),
        ],
      ),
    );
  }
}
