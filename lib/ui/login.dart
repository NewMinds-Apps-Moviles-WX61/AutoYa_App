import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/gestures.dart';

class Login extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 30), // Espaciado vertical
              child: Image.asset(
                'assets/logoautoya.png',
                height: 140,
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
                    .push(MaterialPageRoute(builder: (context) => Login()));
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Colors.black), // Color de fondo negro
              ),
              child: Text(
                'Login in Client',
                style: TextStyle(
                  fontFamily: 'Arial', // Tipografía Arial
                  color: Colors.white,
                  fontSize: 20, // Color del texto blanco
                ),
              ),
            ),
            //boton de car owner
            SizedBox(height: 20.0),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    //cambiar para redireccion de pagina
                    .push(MaterialPageRoute(builder: (context) => Login()));
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Colors.black), // Color de fondo negro
              ),
              child: Text(
                'Login in Car Owner',
                style: TextStyle(
                  fontFamily: 'Arial', // Tipografía Arial
                  color: Colors.white,
                  fontSize: 20, // Color del texto blanco
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
