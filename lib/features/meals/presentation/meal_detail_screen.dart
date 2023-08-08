import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:my_meals/features/authentication/application/auth_provider.dart';
import 'package:my_meals/features/meals/application/meal_provider.dart';
import 'package:my_meals/features/meals/domain/meal.dart';
import 'package:my_meals/features/meals/domain/meal_rating.dart';
import 'package:provider/provider.dart';

class MealDetailPage extends StatefulWidget {
  final String id;
  final String imageUrl;
  final String mealName;
  final String? description;
  final String restaurantName;
  final String restaurantAddress;

  const MealDetailPage({
    required this.imageUrl,
    required this.mealName,
    this.description,
    required this.restaurantName,
    required this.restaurantAddress,
    required this.id,
  });

  @override
  State<MealDetailPage> createState() => _MealDetailPageState();
}

class _MealDetailPageState extends State<MealDetailPage> {
  double rating = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              child: Image.network(
                widget.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.mealName,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    widget.description ??
                        'This is a meal provided by ${this.widget.restaurantName} which is located ${this.widget.restaurantAddress}. Try it out and do tell us your experience!',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Restaurant:',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    widget.restaurantName,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Address:',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    widget.restaurantAddress,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Rate this meal:',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        this.rating = rating;
                      });
                    },
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Text(
                        'Your rating: ${this.rating}',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 16.0),
                      // rate button
                      ElevatedButton(
                        onPressed: () async {
                          // find the meal using the id and update the rating
                          // this is a dummy implementation
                          final user = context.read<AuthProvider>().user;
                          if (user == null) {
                            return;
                          }

                          await MealProvider().updateMeal(Meal(
                            id: widget.id,
                            imageUrl: widget.imageUrl,
                            name: widget.mealName,
                            description: widget.description ?? "",
                            restaurantName: widget.restaurantName,
                            restaurantAddress: widget.restaurantAddress,
                            ratings: [
                              MealRating(
                                  rating: rating.round(), userId: user.uid)
                            ],
                            cuisineType: "",
                            mealType: "",
                          ));
                          // show a snackbar to indicate that the rating has been updated
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Rating updated!'),
                            ),
                          );
                        },
                        child: Text('Rate'),
                      ),
                    ],
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
