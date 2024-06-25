import 'package:flutter/material.dart';
import 'NewRequestPage.dart';

class SearchCarResultsPage extends StatelessWidget {
  final List<dynamic> searchResults; // Modificado para recibir List<dynamic>

  SearchCarResultsPage({required this.searchResults});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
      ),
      body: ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          var car = searchResults[index] as Map<String, dynamic>; // Cast a Map<String, dynamic>
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(car['carPhotoURL'] ?? 'lib/assets/carNotFound.png'),
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
            ),
          );
        },
      ),
    );
  }
}
