import 'package:flutter/material.dart';
import 'package:my_meals/features/meals/presentation/meal_detail_screen.dart';

class MealCard extends StatelessWidget {
  final String id;
  final String imageUrl;
  final String mealName;
  final String? description;
  final String restaurantName;
  final String restaurantAddress;

  const MealCard({
    required this.imageUrl,
    required this.mealName,
    required this.id,
    this.description,
    required this.restaurantName,
    required this.restaurantAddress,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(
        onTap: () {
          // Navigate to the MealDetailPage when the card is tapped.
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MealDetailPage(
                id: id,
                imageUrl: imageUrl,
                mealName: mealName,
                description: description,
                restaurantName: restaurantName,
                restaurantAddress: restaurantAddress,
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(8.0),
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mealName,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 0),
                    title: Text(
                      'Restaurant:',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    subtitle: Text(
                      restaurantName,
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 0),
                    title: Text(
                      'Address:',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    subtitle: Text(
                      restaurantAddress,
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    description ??
                        'This is a meal provided by ${this.restaurantName} which is located ${this.restaurantAddress}. Try it out and do tell us your experience!',
                    style: TextStyle(fontSize: 14.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
