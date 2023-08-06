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
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                height: 200.0,
              ),
            ),
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
                ListTile(
                  title: Text(
                    'Restaurant:',
                    style: TextStyle(fontSize: 14.0),
                  ),
                  subtitle: Text(
                    restaurantName,
                    style: TextStyle(fontSize: 14.0),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Address:',
                    style: TextStyle(fontSize: 14.0),
                  ),
                  subtitle: Text(
                    restaurantAddress,
                    style: TextStyle(fontSize: 14.0),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  description ?? 'No description available.',
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
