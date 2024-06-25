import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

class SearchCarsScreen extends StatefulWidget {
  @override
  _SearchCarsScreenState createState() => _SearchCarsScreenState();
}

class _SearchCarsScreenState extends State<SearchCarsScreen> {
  List<dynamic> cars = [];
  List<dynamic> filteredCars = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCars();
  }

  Future<void> fetchCars() async {
    final response = await http.get(Uri.parse(
        'https://auto-ya-moviles-backend.azurewebsites.net/api/v1/cars'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      setState(() {
        cars = jsonResponse;
        filteredCars = cars;
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load cars');
    }
  }

  void filterCars(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredCars = cars;
      } else {
        filteredCars = cars.where((car) {
          String brand = car['brand'].toString().toLowerCase();
          String model = car['model'].toString().toLowerCase();
          String fuelType = car['fuelType'].toString().toLowerCase();
          String transmission = car['transmission'].toString().toLowerCase();
          String location = car['location'].toString().toLowerCase();
          String searchQuery = query.toLowerCase();

          return brand.contains(searchQuery) ||
              model.contains(searchQuery) ||
              fuelType.contains(searchQuery) ||
              transmission.contains(searchQuery) ||
              location.contains(searchQuery);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search Cars',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 26,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF03253C),
        automaticallyImplyLeading: false,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                filterCars(value);
              },
              decoration: InputDecoration(
                hintText: 'Search for cars',
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    filterCars('');
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: BrandsList(filteredCars),
          ),
        ],

      ),
    );
  }
}

class BrandsList extends StatelessWidget {
  final List<dynamic> filteredCars;
  final List<String> placeholderImageUrls = [
    'https://static.retail.autofact.cl/blog/20161018170049_740x3708932509314539659214.jpg',
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

  BrandsList(this.filteredCars);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: filteredCars.length,
      itemBuilder: (context, index) {
        final car = filteredCars[index];
        final randomIndex = Random().nextInt(placeholderImageUrls.length);
        final randomImageUrl = placeholderImageUrls[randomIndex];

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 5,
            child: ListTile(
              leading: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(randomImageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text(
                '${car['brand']} ${car['model']}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Fuel Type: ${car['fuelType']}'),
                  Text('Transmission: ${car['transmission']}'),
                  Text('Location: ${car['location']}'),
                  Text('Price: \$${car['price']}'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
