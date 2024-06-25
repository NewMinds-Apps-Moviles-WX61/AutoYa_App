import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

late String userPhotoURL = '';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String userName;
  late String userEmail;
  late String userPhone;
  late String userDni;
  late String userPhotoURL;

  bool _isEditing = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _dniController = TextEditingController();

  List<String> galleryImages = [
    'https://loscoches.com/wp-content/uploads/2021/04/carros-deportivos-potencia.jpg',
    'https://larepublica.cronosmedia.glr.pe/original/2023/07/13/64b09814fd5dc73606035630.jpg',
    'https://cdn.buttercms.com/NGzDkznNSIuTY6yrKMxA',
    'https://multimarca.com.ve/wp-content/uploads/2020/05/Toyota-Corolla-261119-02.jpg',
    'https://www.elcarrocolombiano.com/wp-content/uploads/2021/02/20210208-TOP-75-CARROS-MAS-VENDIDOS-DE-COLOMBIA-EN-ENERO-2021-01.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? '';
      userEmail = prefs.getString('userEmail') ?? '';
      userPhone = prefs.getString('userPhone') ?? '';
      userDni = prefs.getString('userDni') ?? 'Unknown';
      userPhotoURL = prefs.getString('userPhotoURL') ??
          'https://i.postimg.cc/QMYLzms6/6326055.png';

      _nameController.text = userName;
      _emailController.text = userEmail;
      _phoneController.text = userPhone;
      _dniController.text = userDni;
    });
  }

  Future<void> _saveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', _nameController.text);
    await prefs.setString('userEmail', _emailController.text);
    await prefs.setString('userPhone', _phoneController.text);
    await prefs.setString('userDni', _dniController.text);
    await prefs.setString('userPhotoURL', userPhotoURL);
  }

  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      final response = await http.put(
        Uri.parse(
            'https://auto-ya-moviles-backend.azurewebsites.net/api/v1/users'),
        body: jsonEncode({
          'name': _nameController.text,
          'email': _emailController.text,
          'phoneNumber': _phoneController.text,
          'dni': _dniController.text,
          'photoURL': userPhotoURL,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        _saveUserData();
        setState(() {
          _isEditing = false;
        });
      } else {
        print('Failed to update profile: ${response.statusCode}');
      }
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        userPhotoURL = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF03253C),
        title: Text("Información Personal", style: TextStyle(fontFamily: 'InstagramSans', color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: Colors.white),
            onPressed: () {
              setState(() {
                _isEditing = true;
              });
            },
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50.0,
                        backgroundColor: Colors.grey,
                        backgroundImage: userPhotoURL.startsWith('http')
                            ? NetworkImage(userPhotoURL)
                            : FileImage(File(userPhotoURL)) as ImageProvider,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            color: Color(0xFFF10303),
                            borderRadius: BorderRadius.circular(26.0),
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              _isEditing ? _buildEditForm() : _buildProfileInfo(),
              SizedBox(height: 20.0),
              Text(
                'Galería de Fotos',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'InstagramSans',
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                height: 100.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: galleryImages.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          galleryImages[index],
                          width: 100.0,
                          height: 100.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoItem("Nombre:", userName),
        _buildInfoItem("Correo:", userEmail),
        _buildInfoItem("Teléfono:", userPhone),
        _buildInfoItem("Documento de Identidad:", userDni),
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
            color: Colors.black,
            fontFamily: 'InstagramSans',
          ),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 16.0, fontFamily: 'InstagramSans'),
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
          _buildFormField("Nombre", _nameController),
          _buildFormField("Correo", _emailController),
          _buildFormField("Teléfono", _phoneController),
          _buildFormField("Documento de Identidad", _dniController),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _updateProfile,
                child: Text("Guardar"),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFFF10303),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isEditing = false;
                  });
                },
                child: Text("Cancelar"),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.orange, // Color del texto del botón
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
        labelStyle: TextStyle(
          color: Color(0xFFF10303),
          fontFamily: 'InstagramSans',
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.pinkAccent),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor ingrese $labelText';
        }
        return null;
      },
    );
  }
}
