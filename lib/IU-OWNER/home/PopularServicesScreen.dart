import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'StarRating.dart';


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
                imageUrl = placeholderImageUrls[
                random.nextInt(placeholderImageUrls.length)];
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
      appBar: AppBar(
        backgroundColor: Color(0xFF03253C),
        leading: GestureDetector(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'lib/assets/car2.png',
              height: 35,
            ),
          ),
        ),
        title: Row(
          children: [
            Text(
              'AutoYa',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
                color: Color(0xFFF10303),
              ),
            ),
          ],
        ),
      ),

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
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      // Imagen con borde...
                                      Container(
                                        width: double.infinity,
                                        height: 150,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                          image: DecorationImage(
                                            image: NetworkImage(service[
                                            'photoURL'] ??
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
                                          Icon(Icons.info,
                                              color: Colors.blue, size: 16),
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
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
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