import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'TenantProfileScreen.dart';
import 'tenant_home_screen.dart';
import 'SearchCarResultsPage.dart';

class SearchCarPage extends StatefulWidget {
  @override
  _SearchCarPageState createState() => _SearchCarPageState();
}

class _SearchCarPageState extends State<SearchCarPage> {
  int _selectedIndex = 0;

  final _formKey = GlobalKey<FormState>();
  String? brand;
  String? model;
  String? yearManufactured;
  String? fuelType;
  String? transmission;
  String? category;
  String? passengerCapacity;
  String? color;
  String? mileage;
  String? condition;
  int? minPrice;
  int? maxPrice;
  bool? ac = false;
  bool? gps = false;
  String? location;
  bool _showAdvancedFilters = false;

  void _searchCars() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Set empty strings to null
      brand = brand?.isEmpty ?? true ? null : brand;
      model = model?.isEmpty ?? true ? null : model;
      yearManufactured = yearManufactured?.isEmpty ?? true ? null : yearManufactured;
      fuelType = fuelType?.isEmpty ?? true ? null : fuelType;
      transmission = transmission?.isEmpty ?? true ? null : transmission;
      category = category?.isEmpty ?? true ? null : category;
      passengerCapacity = passengerCapacity?.isEmpty ?? true ? null : passengerCapacity;
      color = color?.isEmpty ?? true ? null : color;
      mileage = mileage?.isEmpty ?? true ? null : mileage;
      condition = condition?.isEmpty ?? true ? null : condition;
      ac = ac == false ? null : ac;
      gps = gps == false ? null : gps;
      location = location?.isEmpty ?? true ? null : location;

      // Build the request body
      var requestBody = {
        "brand": brand,
        "model": model,
        "yearManufactured": yearManufactured,
        "fuelType": fuelType,
        "transmission": transmission,
        "category": category,
        "passengerCapacity": passengerCapacity,
        "color": color,
        "mileage": mileage,
        "condition": condition,
        "minPrice": minPrice,
        "maxPrice": maxPrice,
        "ac": ac,
        "gps": gps,
        "location": location
      };

      var response = await http.post(
        Uri.parse('https://auto-ya-moviles-backend.azurewebsites.net/api/v1/cars/search'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        // Parse the response
        var jsonData = jsonDecode(response.body);

        // Navigate to the search results page with the data
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SearchCarResultsPage(searchResults: jsonData),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: Failed to search for cars')),
        );
      }
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Aquí puedes implementar la lógica para redirigir a la pantalla correspondiente
    switch (index) {
      case 0: // Home
        Navigator.push(context,
          MaterialPageRoute(builder: (context) => TenantHomeScreen()),
        );
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
        title: Text('Search Car'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Brand'),
                  onSaved: (value) => brand = value?.trim(),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Model'),
                  onSaved: (value) => model = value?.trim(),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Transmission'),
                  onSaved: (value) => transmission = value?.trim(),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Category'),
                  onSaved: (value) => category = value?.trim(),
                ),
                SizedBox(height: 10),
                ExpansionPanelList(
                  expansionCallback: (int index, bool isExpanded) {
                    setState(() {
                      _showAdvancedFilters = !_showAdvancedFilters;
                    });
                  },
                  children: [
                    ExpansionPanel(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          title: Text('Advanced Filters'),
                        );
                      },
                      body: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Year Manufactured'),
                            onSaved: (value) => yearManufactured = value?.trim(),
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Fuel Type'),
                            onSaved: (value) => fuelType = value?.trim(),
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Passenger Capacity'),
                            onSaved: (value) => passengerCapacity = value?.trim(),
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Color'),
                            onSaved: (value) => color = value?.trim(),
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Mileage'),
                            onSaved: (value) => mileage = value?.trim(),
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Condition'),
                            onSaved: (value) => condition = value?.trim(),
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Min Price'),
                            keyboardType: TextInputType.number,
                            onSaved: (value) => minPrice = int.tryParse(value ?? '0'),
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Max Price'),
                            keyboardType: TextInputType.number,
                            onSaved: (value) => maxPrice = int.tryParse(value ?? '0'),
                          ),
                          SwitchListTile(
                            title: Text('AC'),
                            value: ac ?? false, // Usa false si ac es null
                            onChanged: (value) {
                              setState(() {
                                ac = value;
                              });
                            },
                          ),
                          SwitchListTile(
                            title: Text('GPS'),
                            value: gps ?? false,
                            onChanged: (value) {
                              setState(() {
                                gps = value;
                              });
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Location'),
                            onSaved: (value) => location = value?.trim(),
                          ),
                        ],
                      ),
                      isExpanded: _showAdvancedFilters,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _searchCars,
                  child: Text('Search'),
                ),
              ],
            ),
          ),
        ),
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
