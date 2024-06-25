
import 'package:flutter/material.dart';
import 'package:flutter_application_1/terms/TermsScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../IU-Tenant/register/RegisterTenant.dart';
import '../login/LoginOwner.dart';

class RegisterOwner extends StatefulWidget {
  @override
  _RegisterStateOwner createState() => _RegisterStateOwner();
}

class _RegisterStateOwner extends State<RegisterOwner> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dniController = TextEditingController();

  String _message = 'Aceptar terminos y condiciones para continuar';
  bool _acceptedTerms = false;

  Future<void> _registerOwner() async {
    if (_formKey.currentState!.validate() && _acceptedTerms) {
      final response = await http.post(
        Uri.parse(
            'https://auto-ya-moviles-backend.azurewebsites.net/api/v1/propietaries'),
        body: jsonEncode({
          'name': _nameController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
          'phoneNumber': _phoneController.text,
          'dni': _dniController.text,
          'photoURL': 'https://i.postimg.cc/QMYLzms6/6326055.png',
          'ContractURL': 'contract.com',
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final userId = data['id'];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userId', userId.toString());
        await prefs.setString('userName', _nameController.text);
        await prefs.setString('userEmail', _emailController.text);
        await prefs.setString('userPhone', _phoneController.text);
        await prefs.setString('userDni', _dniController.text);

        setState(() {
          _message = 'Owner registered successfully';
        });

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginOwner()),
        );
      } else {
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        setState(() {
          _message = 'Failed to register owner';
        });
      }
    } else if (!_acceptedTerms) {
      setState(() {
        _message = 'You must accept the terms and conditions to register';
      });
    }
  }

  Future<void> _launchTermsURL(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TermsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 19, 19, 19),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0, top: 40),
                child: Container(
                  height: 100,
                  alignment: Alignment.center,
                  child: Text(
                    'Register Owner',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 252, 30, 14),
                    ),
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
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 9, 207, 16)),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      textStyle:
                      MaterialStateProperty.all(TextStyle(fontSize: 20)),
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
                      backgroundColor: MaterialStateProperty.all(Colors.grey),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      textStyle:
                      MaterialStateProperty.all(TextStyle(fontSize: 20)),
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
                controller: _passwordController,
                labelText: 'Password',
                obscureText: true,
              ),
              SizedBox(height: 15),
              _buildTextField(
                controller: _dniController,
                labelText: 'DNI',
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Checkbox(
                    value: _acceptedTerms,
                    onChanged: (bool? value) {
                      setState(() {
                        _acceptedTerms = value!;
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
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: _acceptedTerms ? _registerOwner : null,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(_acceptedTerms
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
