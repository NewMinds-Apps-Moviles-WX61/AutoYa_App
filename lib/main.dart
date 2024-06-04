import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/booking_page.dart';
import 'package:flutter_application_1/ui/inicio_sesion.dart';
import 'package:flutter_application_1/ui/newRequest_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Autoya',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(
/*         colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true, */
          ),
      home: NewRequestPage(),
    );
  }
}

/* //-------------------------------------------------
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //menu desplegable
      drawer: Drawer(),

      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            //estilos de texto
            Text('$_counter', style: TextStyle(fontSize: 70)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        //iconos
        child: const Icon(Icons.add_to_queue),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
} */
