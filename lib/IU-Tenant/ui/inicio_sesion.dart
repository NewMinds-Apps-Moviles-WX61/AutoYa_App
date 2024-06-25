import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
            ),
          ),
          Container(color: Color.fromRGBO(255, 255, 255, 0.5)),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  'assets/logoautoya.png',
                  height: 100,
                ),
                Center(
                  // Para centrar los elementos dentro del contenedor
                  // ignore: prefer_const_constructors
                  child: Column(
                    // Column para organizar los elementos en una columna
                    mainAxisAlignment: MainAxisAlignment
                        .center, // Alinear los elementos verticalmente al centro
                    crossAxisAlignment: CrossAxisAlignment
                        .start, // Alinear los elementos horizontalmente al inicio
                    children: [
                      Text(
                        'Register or log in', // Primer texto
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
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.white,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Continue with GOOGLE',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
