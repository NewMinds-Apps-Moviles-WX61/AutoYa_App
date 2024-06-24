import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/TenantProfileScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'NewRequestPage.dart';
import 'SearchCarPage.dart';

class TenantHomeScreen extends StatefulWidget {
  @override
  _TenantHomeScreenState createState() => _TenantHomeScreenState();
}

class _TenantHomeScreenState extends State<TenantHomeScreen> {
  int _selectedIndex = 0;

  List<String> carBrands = []; // Lista para almacenar las marcas de autos
  List<dynamic> carList = [];

  @override
  void initState() {
    super.initState();
    // Llamar a la función para obtener las marcas de autos al cargar la vista
    fetchCarBrands().then((brands) {
      setState(() {
        carBrands = brands;
        if (carBrands.isNotEmpty) {
          fetchCars(carBrands[0]);
        }
      });
    }).catchError((error) {
      print('Error fetching car brands: $error');
    });
  }

  Future<List<String>> fetchCarBrands() async {
    var response = await http.get(Uri.parse('https://auto-ya-moviles-backend.azurewebsites.net/api/v1/cars/brands'));

    if (response.statusCode == 200) {
      List<dynamic> brandsJson = jsonDecode(response.body);
      List<String> brands = brandsJson.map((brand) => brand.toString()).toList();
      return brands;
    } else {
      throw Exception('Failed to load car brands');
    }
  }

  Future<void> fetchCars(String brandName) async {
    var response = await http.get(
        Uri.parse('https://auto-ya-moviles-backend.azurewebsites.net/api/v1/cars/brand/$brandName'));

    if (response.statusCode == 200) {
      setState(() {
        carList = jsonDecode(response.body);
      });
    } else {
      throw Exception('Failed to load cars for $brandName');
    }
  }

  Future<String> fetchFirstCarPhoto(int carId) async {
    var response = await http.get(
        Uri.parse('https://auto-ya-moviles-backend.azurewebsites.net/api/v1/carphotos/$carId'));

    if (response.statusCode == 200) {
      List<dynamic> photos = jsonDecode(response.body);
      if (photos.isNotEmpty) {
        return photos[0]['carPhotoURL']; // Obtener la primera imagen de la lista
      }
      // Si no hay fotos, retornar una imagen por defecto
      return 'lib/assets/carNotFound.png';
    } else {
      throw Exception('Failed to load car photo for ID: $carId');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Aquí puedes implementar la lógica para redirigir a la pantalla correspondiente
    switch (index) {
      case 0: // Home
      // Redirigir a la pantalla Home
        break;
      case 1: // Cars
      // Redirigir a la pantalla Cars
        break;
      case 2: // Search
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchCarPage()),
        );
        break;
      case 3: // Chats
      // Redirigir a la pantalla Chats
        break;
      case 4: // Profile
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TenantProfileScreen()),
        );
        break;
      default:
      // No hacer nada
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('AutoYa!'),
      ),
      body: Column(
        children: [
          // Aquí va la lista horizontal de imágenes de marcas
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: carBrands.map((brand) {
                String imagePath = 'lib/assets/${brand.toLowerCase()}.png';
                return GestureDetector(
                  onTap: () {
                    fetchCars(brand);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.lightBlueAccent,
                              width: 2.0,
                            ),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              imagePath,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                return Image.asset(
                                  'lib/assets/carNotFound.png', // Mostrar la imagen de carNotFound.png si la imagen de la marca no se encuentra
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          brand,
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: carList.length,
              itemBuilder: (context, index) {
                var car = carList[index];
                return FutureBuilder<String>(
                  future: fetchFirstCarPhoto(car['id']),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(snapshot.data!),
                        ),
                        title: Text('${car['brand']} ${car['model']}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Plate: ${car['plate']}'),
                            Text('Year Manufactured: ${car['yearManufactured']}'),
                            Text('Transmission: ${car['transmission']}'),
                            Text('Passenger Capacity: ${car['passengerCapacity']}'),
                            Text('Price: ${car['price']}'),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => NewRequestPage(carId: car["id"],)),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage('lib/assets/carNotFound.png'),
                        ),
                        title: Text('Error loading car photo'),
                      );
                    } else {
                      return ListTile(
                        leading: CircularProgressIndicator(),
                        title: Text('Loading...'),
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFF03253C),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.car_rental),
            label: 'Cars',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
