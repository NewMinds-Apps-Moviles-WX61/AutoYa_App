import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/car_card.dart';
import 'package:flutter_application_1/models/Car.dart';

class CarList extends StatelessWidget {
  final List<Car> cars = [
    Car(
        name: 'Toyota Highlander',
        price: '\$35 - \$150 day',
        rating: 5.0,
        reviewCount: 230,
        imageUrl:
            'https://th.bing.com/th/id/OIP.7DWaOe3UZ8Vzxjv_Wh2ELAAAAA?rs=1&pid=ImgDetMain'),
    Car(
        name: 'Honda CR-V',
        price: '\$50 - \$70 day',
        rating: 4.2,
        reviewCount: 118,
        imageUrl:
            'https://th.bing.com/th/id/OIP.hZOcuDG8kt6D-0bCDI2z0QAAAA?rs=1&pid=ImgDetMain'),
    Car(
        name: 'Nissan Rogue',
        price: '\$45 - \$65 day',
        rating: 4.3,
        reviewCount: 98,
        imageUrl:
            'https://th.bing.com/th/id/OIP.doPwd0oonnzfMME3TYMlZgAAAA?rs=1&pid=ImgDetMain'),
    Car(
        name: 'Suzuki Vitara',
        price: '\$40 - \$60 day',
        rating: 4.0,
        reviewCount: 100,
        imageUrl:
            'https://th.bing.com/th/id/OIP._CxI2VY4U3AyTPIWDsNtmwAAAA?rs=1&pid=ImgDetMain'),
  ];

  CarList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Car'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Aquí podrías implementar la funcionalidad de búsqueda
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search cars',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
              onSubmitted: (value) {
                // Realizar búsqueda con el valor ingresado
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cars.length,
              itemBuilder: (context, index) {
                // Crear un CarCard para cada auto en la lista
                return CarCard(
                  title: cars[index]
                      .name, // Asumiendo que el modelo Car tiene un atributo name
                  price: cars[index]
                      .price, // Asumiendo que el modelo Car tiene un atributo price
                  rating: cars[index]
                      .rating, // Asumiendo que el modelo Car tiene un atributo rating
                  reviewCount: cars[index]
                      .reviewCount, // Asumiendo que el modelo Car tiene un atributo reviewCount
                  imageUrl: cars[index].imageUrl,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
