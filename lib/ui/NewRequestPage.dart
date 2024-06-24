import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewRequestPage extends StatefulWidget {
  final int carId; // Recibe el ID del auto como argumento

  NewRequestPage({required this.carId});
  @override
  _NewRequestPageState createState() => _NewRequestPageState();
}

class _NewRequestPageState extends State<NewRequestPage> {
  final baseUrl = 'https://auto-ya-moviles-backend.azurewebsites.net/api/v1/cars/';
  Future<Map<String, dynamic>> obtenerDatos() async {
    final url = Uri.parse('$baseUrl${widget.carId}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Error al obtener datos: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children:[
          Text('Car Rental Service', style: TextStyle(fontSize:25, fontWeight: FontWeight.bold, color: Colors.blue),textAlign: TextAlign.left,),
          Row(
            children:[
              Image.network(
                'https://cloudfront-us-east-1.images.arcpublishing.com/elcomercio/ZF53L74CXRGNXEMZXILAOLUZB4.jpg', // Reemplaza con la URL de tu imagen
                width: 200, // Ajusta el tamaño de la imagen según tus necesidades
                height: 200,
              ),
              FutureBuilder<Map<String, dynamic>>(
                future: obtenerDatos(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Muestra un indicador de carga mientras se obtienen los datos
                  } else if (snapshot.hasError) {
                    return Text('Error al cargar datos');
                  } else if (snapshot.hasData) {
                    final datos = snapshot.data!;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Brand: ${datos['brand']}', style: TextStyle(fontSize: 20)),
                        Text('Model: ${datos['model']}', style: TextStyle(fontSize: 20)),
                        Text('from: \S/.${datos['price']}\ day', style: TextStyle(fontSize: 20)),
                      ],
                    );
                  } else {
                    return Text('No se encontraron datos');
                  }
                },
              ),
            ],
          ),

          Text('Insert your bid for the service', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
          TextFormField(
            decoration: InputDecoration(
                label: const Text('Enter your bid'),
                hintText: 'Enter your bid',
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(15),
                )
            ),
          ),
          Text('The minimum amount is S/.20', textAlign: TextAlign.center,),
          Text('What do you need', textAlign: TextAlign.start, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
          SizedBox(
            height: 100,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Write what you need',
                filled: true,
              ),
              maxLines: null,
              expands: true,
              keyboardType: TextInputType.multiline,
            ),
          ),
          Text('Once you make the request, you will have to wait the freelancers aproval to begin the service', textAlign: TextAlign.center,),
          ElevatedButton(onPressed: (){}, child: Text('Send request', style: TextStyle(color: Colors.white),), style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple,
          ),)
        ],
      ),
    );
  }
}