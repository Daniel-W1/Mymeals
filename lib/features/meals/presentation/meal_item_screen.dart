import 'package:flutter/material.dart';

class MealCard extends StatelessWidget {
  final String imageUrl;
  final String mealName;
  final String? description;
  final String restaurantName;
  final String restaurantAddress;

  const MealCard({
    required this.imageUrl,
    required this.mealName,
    this.description,
    required this.restaurantName,
    required this.restaurantAddress,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(
            imageUrl,
            fit: BoxFit.cover,
            height: 200.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mealName,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Restaurant: $restaurantName',
                  style: TextStyle(fontSize: 14.0),
                ),
                Text(
                  'Address: $restaurantAddress',
                  style: TextStyle(fontSize: 14.0),
                ),
                SizedBox(height: 8.0),
                if (description != null)
                  Text(
                    description!,
                    style: TextStyle(fontSize: 14.0),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
