
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../IU-OWNER/register/RegisterOwner.dart';
import '../../terms/TermsScreenTenant.dart';
import '../login/Login.dart';

class _RegisterState extends State<RegisterTenant> {
  TextEditingController _nameController = TextEditingController();
  DateTime _birthday = DateTime.now();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _dniController = TextEditingController();
  TextEditingController _licencenumberController = TextEditingController();

  bool _termsAccepted = false;
  String _message = 'Aceptar terminos y condiciones para continuar';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _birthday,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _birthday) {
      setState(() {
        _birthday = picked;
      });
    }
  }

  Future<void> _register() async {
    if (!_termsAccepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please accept terms and conditions.')),
      );
      return;
    }

    if (!_areFieldsValidated()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields.')),
      );
      return;
    }

    final String apiUrl =
        "https://auto-ya-moviles-backend.azurewebsites.net/api/v1/tenants";
    final Map<String, dynamic> data = {
      "name": _nameController.text,
      "email": _emailController.text,
      "password": _passwordController.text,
      "phoneNumber": _phoneController.text,
      "dni": _dniController.text,
      "LicenceNumber": _licencenumberController.text,
      "photoURL": "https://i.postimg.cc/QMYLzms6/6326055.png",
      "CriminalRecordURL": "criminalrecord.com"
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    } else {
      // Handle errors here
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration failed. Please try again.')),
      );
    }
  }

  bool _areFieldsValidated() {
    return _nameController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _dniController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _licencenumberController.text.isNotEmpty;
  }

  //-----------------------------------------------------------------
  Future<void> _launchTermsURL(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TermsScreenTenant()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 19, 19, 19),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0, top: 40),
                  child: Text(
                    'Register Tenant',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 252, 30, 14),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterOwner()),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all(Colors.grey[600]),
                        foregroundColor:
                        MaterialStateProperty.all(Colors.white),
                        textStyle: MaterialStateProperty.all(
                          TextStyle(fontSize: 20),
                        ),
                      ),
                      child: Text('OWNER'),
                    ),
                    SizedBox(width: 30),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterTenant()),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 9, 207, 16)),
                        foregroundColor:
                        MaterialStateProperty.all(Colors.white),
                        textStyle: MaterialStateProperty.all(
                          TextStyle(fontSize: 20),
                        ),
                      ),
                      child: Text('TENANT'),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                _buildTextField(
                  controller: _nameController,
                  labelText: 'Name',
                ),
                SizedBox(height: 15),
                _buildTextField(
                  controller: _phoneController,
                  labelText: 'Phone',
                ),
                SizedBox(height: 15),
                _buildTextField(
                  controller: _emailController,
                  labelText: 'Email',
                ),
                SizedBox(height: 15),
                _buildTextField(
                  controller: _dniController,
                  labelText: 'DNI',
                ),
                SizedBox(height: 15),
                _buildTextField(
                  controller: _passwordController,
                  labelText: 'Password',
                  obscureText: true,
                ),
                SizedBox(height: 15),
                _buildTextField(
                  controller: _licencenumberController,
                  labelText: 'Licence Number',
                  obscureText: true,
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Checkbox(
                      value: _termsAccepted,
                      onChanged: (bool? value) {
                        setState(() {
                          _termsAccepted = value!;
                        });
                      },
                      activeColor: Colors.green,
                    ),
                    Flexible(
                      child: GestureDetector(
                        onTap: () {
                          _launchTermsURL(context);
                        },
                        child: RichText(
                          text: TextSpan(
                            text: 'Aceptar ',
                            style: TextStyle(color: Colors.white),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Términos y Condiciones',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _termsAccepted ? _register : null,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(_termsAccepted
                        ? Color.fromARGB(255, 9, 207, 16)
                        : Colors.grey),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    textStyle: MaterialStateProperty.all(
                      TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(width: 8),
                        Text('REGISTER'),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(_message, style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.white),
        floatingLabelStyle: TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 2.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red[400]!, width: 2.0),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      ),
    );
  }
}

class RegisterTenant extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}
