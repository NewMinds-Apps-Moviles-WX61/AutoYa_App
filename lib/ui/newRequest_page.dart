import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewRequestPage extends StatefulWidget{
  @override
  _NewRequestPageState createState() => _NewRequestPageState();
}

class _NewRequestPageState extends State<NewRequestPage>{
  List<dynamic> newRequest = [];
  List<String> usedImageUrlsNew = [];

  @override
  void initState(){
    super.initState();
    fetchNewRequest();
  }

  List<String> placeholderImageUrls2 = [
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

  Future<void>fetchNewRequest()async{
    try{
      final response = await http.get(Uri.parse('https://auto-ya-moviles-backend.azurewebsites.net/api/v1/cars/search/propietaryid/1'));
      if(response.statusCode == 200){
        final jsonResponse = json.decode(response.body);
        setState(() {
          newRequest = jsonResponse.map((service){
            if(service['photoURL']== null){
              String imageUrl;
              do{
                final random = Random();
                imageUrl = placeholderImageUrls2[random.nextInt(
                    placeholderImageUrls2.length)];
              } while (usedImageUrlsNew.contains(imageUrl));
              service['photoUrl']= imageUrl;
              usedImageUrlsNew.add(imageUrl);
            }
            return service;
          }).toList();
        });
      } else {
        throw Exception('Failed to load popular services');
      }
    } catch (e){
      print (e);
    }
  }
  @override
  void dispose(){
    super.dispose();
  }
  @override
  Widget build(BuildContext context){
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Text('Car Rental Service', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.blue),textAlign: TextAlign.left,),
          Container(
            height: 300,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: newRequest.map((service) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 100,
                              height: 80,
                              decoration: BoxDecoration(
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
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                                children:[
                                  SizedBox(height: 5),
                                  Text(
                                    service['brand'] ?? 'Unknown',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    service['model']??'Unknown',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),]),
                            Row(
                              children: [
                                Text('Precio de: /S.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  service['price'].toString(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
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