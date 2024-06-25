import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


String generateRandomPlate() {
  Random random = Random();
  String letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  String numbers = '0123456789';
  String plate = '';

  // Genera tres letras aleatorias
  for (int i = 0; i < 3; i++) {
    plate += letters[random.nextInt(letters.length)];
  }

  // Genera tres números aleatorios
  for (int i = 0; i < 3; i++) {
    plate += numbers[random.nextInt(numbers.length)];
  }

  return plate;
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
  final TextEditingController _locationController = TextEditingController();

  //final TextEditingController _statusController = TextEditingController();
  bool _acValue = false;
  bool _gpsValue = false;

  Future<void> _registerCar() async {
    if (_formKey.currentState!.validate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? propietaryID = prefs.getString('userId');

      if (propietaryID != null) {
        try {
          final carData = {
            'plate': generateRandomPlate(),
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
            'ac': _acValue,
            'gps': _gpsValue,
            'location': _locationController.text,
            'status': "status",
            'propietaryId': propietaryID
          };

          final response = await http.post(
            Uri.parse(
                'https://auto-ya-moviles-backend.azurewebsites.net/api/v1/cars'),
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode(carData),
          );

          if (response.statusCode == 200) {
            _showSnackBar('Car registered successfully', Colors.green);
          } else if (response.statusCode == 400) {
            if (response.body.contains('Car with that plate already exists')) {
              _showSnackBar('Car with that plate already exists', Colors.red);
            } else {
              print('HTTP request failed with status: ${response.statusCode}');
              print('Response body: ${response.body}');
              _showSnackBar('Failed to register car', Colors.red);
            }
          } else {
            print('HTTP request failed with status: ${response.statusCode}');
            print('Response body: ${response.body}');
            _showSnackBar('Failed to register car', Colors.red);
          }
        } catch (error) {
          print('Error: $error');
          _showSnackBar('An error occurred', Colors.red);
        }
      } else {
        _showSnackBar('User ID not found', Colors.red);
      }
    }
  }

  void _showSnackBar(String message, Color color) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: color,
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/img_3.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.6), BlendMode.darken),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                SizedBox(height: 10),
                Center(
                  child: Text(
                    'Register Car',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                        child: _buildTextFormField(_brandController, 'Brand')),
                    SizedBox(width: 20),
                    Expanded(
                        child: _buildTextFormField(_modelController, 'Model')),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: _buildTextFormField(
                            _yearManufacturedController, 'Year Manufactured')),
                    SizedBox(width: 20),
                    Expanded(
                        child: _buildTextFormField(
                            _fuelTypeController, 'Fuel Type')),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: _buildTextFormField(
                            _transmissionController, 'Transmission')),
                    SizedBox(width: 20),
                    Expanded(
                        child: _buildTextFormField(
                            _categoryController, 'Category')),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: _buildTextFormField(_passengerCapacityController,
                            'Passenger Capacity')),
                    SizedBox(width: 20),
                    Expanded(
                        child: _buildTextFormField(_colorController, 'Color')),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child:
                        _buildTextFormField(_mileageController, 'Mileage')),
                    SizedBox(width: 20),
                    Expanded(
                        child: _buildTextFormField(
                            _conditionController, 'Condition')),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: _buildTextFormField(_priceController, 'Price')),
                    SizedBox(width: 20),
                    Expanded(
                        child: _buildTextFormField(
                            _locationController, 'Location')),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: _buildTextFormField(_plateController, 'Plate')),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: CheckboxListTile(
                        title: Text('AC',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        value: _acValue,
                        onChanged: (value) {
                          setState(() {
                            _acValue = value!;
                          });
                        },
                        activeColor: Colors.green,
                        checkColor: Colors.white,
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                    Expanded(
                      child: CheckboxListTile(
                        title: Text('GPS',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        value: _gpsValue,
                        onChanged: (value) {
                          setState(() {
                            _gpsValue = value!;
                          });
                        },
                        activeColor: Colors.green,
                        checkColor: Colors.white,
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                  ],
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
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(
      TextEditingController controller, String labelText) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter the $labelText';
          }
          return null;
        },
        style: TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          labelText: labelText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}