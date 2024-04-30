import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_application_1/ui/login.dart';
import 'package:flutter_application_1/ui/registerowner.dart';

class LoginOwner extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment
                  .center, // Alinea la columna verticalmente al centro
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      bottom: 30, top: 80), // Espaciado vertical
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
                                color: Colors.black),
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
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: 'Go to Tenant',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.blue,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Aquí colocas la navegación hacia la página de registro
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
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 20.0),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                //texto de olvido la contraseña
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
                                  color: Colors.blue,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Aquí colocas la navegación hacia la página de registro
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
                    Navigator.of(context)
                        //cambiar para redireccion de pagina
                        .push(MaterialPageRoute(
                            builder: (context) => RegisterOwner()));
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Colors.grey), // Color de fondo de boton
                    minimumSize: MaterialStateProperty.all(Size(double.infinity,
                        30)), // Ancho mínimo del botón y altura fija de 50
                  ),
                  child: Text(
                    'REGISTER AS A OWNER',
                    style: TextStyle(
                      fontFamily: 'Arial', // Tipografía Arial
                      color: Colors.white,
                      fontSize: 20, // Color del texto blanco
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        //cambiar para redireccion de pagina
                        .push(MaterialPageRoute(builder: (context) => Login()));
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Colors.blue), // Color de fondo de boton
                    minimumSize: MaterialStateProperty.all(Size(double.infinity,
                        30)), // Ancho mínimo del botón y altura fija de 50
                  ),
                  child: Text(
                    'Sign in',
                    style: TextStyle(
                      fontFamily: 'Arial', // Tipografía Arial
                      color: Colors.white,
                      fontSize: 40, // Color del texto blanco
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
