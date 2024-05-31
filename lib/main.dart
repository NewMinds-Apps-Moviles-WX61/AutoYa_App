import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'lib/assets/car2.png',
                  height: 30,
                ),
              ),
              Text(
                'AutoYa',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFA0F0F),
                  fontSize: 35,
                ),
              ),
            ],
          ),
          backgroundColor: Color(0xFF03253C), // Púrpura oscuro
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: HomeScreen(),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    PopularServicesScreen(),
    RegisterCar(),
    SearchCarsScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 1 || _selectedIndex == 2 || _selectedIndex == 3 || _selectedIndex == 4
          ? AppBar(
        title: Text(_selectedIndex == 1 ? 'Register Car' : (_selectedIndex == 2 ? 'Search Cars' : (_selectedIndex == 3 ? 'Chats' : 'Profile'))),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              _selectedIndex = 0;
            });
          },
        ),
      )
          : null,
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: _selectedIndex != 1 && _selectedIndex != 2 && _selectedIndex != 3 && _selectedIndex != 4
          ? Container(
        color: Color(0xFF03253C),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.app_registration),
              label: 'Register Car',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search Cars',
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
          selectedItemColor: Color(0xFFF10303),
          unselectedItemColor: Colors.white,
          backgroundColor: Color(0xFF03253C),
          onTap: _onItemTapped,
        ),
      )
          : null,
    );
  }
}


class StarRating extends StatelessWidget {
  final int numberOfStars;

  StarRating({required this.numberOfStars});

  @override
  Widget build(BuildContext context) {
    final starString = '⭐' * numberOfStars;

    return Text(
      starString,
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
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
    'https://static.retail.autofact.cl/blog/20161018170049_740x3708932509314539659214.jpg', // Placeholder 1
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
                imageUrl = placeholderImageUrls[random.nextInt(placeholderImageUrls.length)];
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
                              image: NetworkImage(service['photoURL'] ?? 'https://via.placeholder.com/80'),
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Imagen con borde...
                                      Container(
                                        width: double.infinity,
                                        height: 150,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10.0),
                                          image: DecorationImage(
                                            image: NetworkImage(service['photoURL'] ?? 'https://via.placeholder.com/150'),
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
                                          Icon(Icons.location_on, color: Colors.red, size: 16),
                                          SizedBox(width: 4),
                                          Text(
                                            service['location'] ?? 'Unknown location',
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
                                          Icon(Icons.info, color: Colors.blue, size: 16),
                                          SizedBox(width: 4),
                                          Text(
                                            service['status'] ?? 'Unknown status',
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
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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

class RegisterCar extends StatefulWidget {
  @override
  _RegisterCarState createState() => _RegisterCarState();
}

class _RegisterCarState extends State<RegisterCar> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _plateController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _yearManufacturedController =
  TextEditingController();
  final TextEditingController _fuelTypeController = TextEditingController();
  final TextEditingController _transmissionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _passengerCapacityController =
  TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _mileageController = TextEditingController();
  final TextEditingController _conditionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _acController = TextEditingController();
  final TextEditingController _gpsController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();

  String _message = '';

  Future<void> _registerCar() async {
    if (_formKey.currentState!.validate()) {
      final response = await http.post(
        Uri.parse('https://auto-ya-moviles-backend.azurewebsites.net/api/v1/cars'),
        body: {
          'plate': _plateController.text,
          'brand': _brandController.text,
          'model': _modelController.text,
          'yearManufactured': _yearManufacturedController.text,
          'fuelType': _fuelTypeController.text,
          'transmission': _transmissionController.text,
          'category': _categoryController.text,
          'passengerCapacity': _passengerCapacityController.text,
          'color': _colorController.text,
          'mileage': _mileageController.text,
          'condition': _conditionController.text,
          'price': _priceController.text,
          'ac': _acController.text,
          'gps': _gpsController.text,
          'location': _locationController.text,
          'status': _statusController.text,
        },
      );

      if (response.statusCode == 200) {

        setState(() {
          _message = 'Car registered successfully';
        });
      } else {
        // Error al registrar el automóvil
        setState(() {
          _message = 'Failed to register car';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Car'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _plateController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the plate';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Plate',
                ),
              ),
              TextFormField(
                controller: _brandController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the brand';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Brand',
                ),
              ),
              TextFormField(
                controller: _modelController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the model';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Model',
                ),
              ),
              TextFormField(
                controller: _yearManufacturedController,
                decoration: InputDecoration(
                  labelText: 'Year Manufactured',
                ),
              ),
              TextFormField(
                controller: _fuelTypeController,
                decoration: InputDecoration(
                  labelText: 'Fuel Type',
                ),
              ),
              TextFormField(
                controller: _transmissionController,
                decoration: InputDecoration(
                  labelText: 'Transmission',
                ),
              ),
              TextFormField(
                controller: _categoryController,
                decoration: InputDecoration(
                  labelText: 'Category',
                ),
              ),
              TextFormField(
                controller: _passengerCapacityController,
                decoration: InputDecoration(
                  labelText: 'Passenger Capacity',
                ),
              ),
              TextFormField(
                controller: _colorController,
                decoration: InputDecoration(
                  labelText: 'Color',
                ),
              ),
              TextFormField(
                controller: _mileageController,
                decoration: InputDecoration(
                  labelText: 'Mileage',
                ),
              ),
              TextFormField(
                controller: _conditionController,
                decoration: InputDecoration(
                  labelText: 'Condition',
                ),
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(
                  labelText: 'Price',
                ),
              ),
              TextFormField(
                controller: _acController,
                decoration: InputDecoration(
                  labelText: 'AC',
                ),
              ),
              TextFormField(
                controller: _gpsController,
                decoration: InputDecoration(
                  labelText: 'GPS',
                ),
              ),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(
                  labelText: 'Location',
                ),
              ),
              TextFormField(
                controller: _statusController,
                decoration: InputDecoration(
                  labelText: 'Status',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _registerCar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Register Car',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                _message,
                style: TextStyle(
                  color: _message.startsWith('Failed') ? Colors.red : Colors.green,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchCarsScreen extends StatefulWidget {
  @override
  _FriendsScreenState createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<SearchCarsScreen> {
  List<dynamic> brands = [];

  @override
  void initState() {
    super.initState();
    fetchBrands();
  }

  Future<void> fetchBrands() async {
    final response =
    await http.get(Uri.parse('http://192.168.0.10:8080/api/favore/v1/all'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      setState(() {
        brands = jsonResponse['cars'];
      });
    } else {
      throw Exception('Failed to load brands');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SearchBar(brands),
        BrandsList(brands),
      ],
    );
  }
}


class SearchBar extends StatefulWidget {
  final List<dynamic> brands;

  SearchBar(this.brands);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _searchController = TextEditingController();
  List<dynamic> filteredBrands = [];
  List<dynamic> originalBrands = [];

  @override
  void initState() {
    super.initState();
    originalBrands = widget.brands;
    filteredBrands = widget.brands;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void filterBrands(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredBrands = originalBrands;
      } else {
        filteredBrands = originalBrands.where((brand) {
          String brandName = brand['name'].toLowerCase();
          String brandBrand = brand['brand'].toLowerCase();
          String searchQuery = query.toLowerCase();

          // Buscar coincidencias en el nombre y la marca
          return brandName.contains(searchQuery) ||
              brandBrand.contains(searchQuery);
        }).toList();

        // Ordenar los resultados por relevancia
        filteredBrands.sort((a, b) {
          int aScore = _calculateRelevanceScore(a, query);
          int bScore = _calculateRelevanceScore(b, query);
          return bScore.compareTo(aScore);
        });
      }
    });
  }

  int _calculateRelevanceScore(Map<String, dynamic> brand, String query) {
    String brandName = brand['name'].toLowerCase();
    String brandBrand = brand['brand'].toLowerCase();
    String searchQuery = query.toLowerCase();

    int nameScore =
    brandName.contains(searchQuery) ? brandName.indexOf(searchQuery) : -1;
    int brandScore =
    brandBrand.contains(searchQuery) ? brandBrand.indexOf(searchQuery) : -1;

    // Dar prioridad a las coincidencias en el nombre sobre las coincidencias en la marca
    return nameScore >= 0 ? nameScore : brandScore + 100;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _searchController,
            onChanged: (value) {
              filterBrands(value);
            },
            decoration: InputDecoration(
              hintText: 'Search',
              prefixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  filterBrands(_searchController.text);
                },
              ),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  _searchController.clear();
                  filterBrands('');
                },
              )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BrandsList extends StatelessWidget {
  final List<dynamic> filteredBrands;

  BrandsList(this.filteredBrands);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Brands',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF03253C),
            ),
          ),
        ),
        SizedBox(height: 8),
        if (filteredBrands.isEmpty)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'No matching brands found.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: filteredBrands.length,
            itemBuilder: (context, index) {
              final brand = filteredBrands[index];
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
                          image: NetworkImage(brand['photoURL']),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(
                      brand['name'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow),
                        Icon(Icons.star, color: Colors.yellow),
                        Icon(Icons.star, color: Colors.yellow),
                        Icon(Icons.star, color: Colors.yellow),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}


class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];

  void _handleSubmitted(String text) {
    _textController.clear();
    ChatMessage message = ChatMessage(
      text: text,
    );
    setState(() {
      _messages.insert(0, message);
    });
  }

  Widget _buildTextComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              decoration: InputDecoration(
                hintText: "Send a message",
                contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: Colors.blue),
            onPressed: () => _handleSubmitted(_textController.text),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bandeja de mensajes"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (_, int index) => _messages[index],
            ),
          ),
          Divider(height: 1.0),
          _buildTextComposer(),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: Colors.blue, // Color de fondo del avatar
              foregroundColor: Colors.white, // Color del texto del avatar
              child: ClipOval(
                child: Image.asset(
                  'lib/assets/img.png',
                  height: 35,
                  width: 35,
                  fit: BoxFit.cover,
                ),
              ),
            ),

          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'User Name',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  width: 195,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade300,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0),
                    ),
                  ),
                  child: Text(text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final String userName = "Julio Garcia";
  final String userEmail = "juliogarcias@example.com";
  final String userPhone = "+51908676434";
  final String userLocation = "Lima, Perú";

  bool _isEditing = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = userName;
    _emailController.text = userEmail;
    _phoneController.text = userPhone;
    _locationController.text = userLocation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Información Personal"),
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: Colors.white,),
            onPressed: () {
              setState(() {
                _isEditing = true;
              });
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        color: Colors.grey[200],
        child: _isEditing ? _buildEditForm() : _buildProfileInfo(),
      ),
    );
  }

  Widget _buildProfileInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: CircleAvatar(
            radius: 50.0,
            backgroundColor: Colors.blue,
            child: ClipOval(
              child: Image.asset(
                'lib/assets/img.png',
                height: 90,
                width: 90,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(height: 20.0),
        _buildInfoItem("Name:", userName),
        _buildInfoItem("Email:", userEmail),
        _buildInfoItem("Phone:", userPhone),
        _buildInfoItem("Location:", userLocation),
      ],
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Color del texto del label
          ),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 16.0),
        ),
        SizedBox(height: 10.0),
      ],
    );
  }

  Widget _buildEditForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFormField("Name", _nameController),
          _buildFormField("Email", _emailController),
          _buildFormField("Phone", _phoneController),
          _buildFormField("Location", _locationController),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Implementa aquí la lógica para guardar los cambios
                  setState(() {
                    _isEditing = false;
                  });
                },
                child: Text("Save"),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.blue, // Color del texto del botón
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isEditing = false;
                  });
                },
                child: Text("Cancel"),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.grey, // Color del texto del botón
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFormField(String labelText, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $labelText';
        }
        return null;
      },
    );
  }
}







