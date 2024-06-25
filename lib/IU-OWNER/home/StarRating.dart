
import 'package:flutter/material.dart';

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