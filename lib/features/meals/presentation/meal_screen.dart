import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_meals/features/meals/presentation/meal_item_screen.dart';
import 'package:provider/provider.dart';
import '../application/meal_provider.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mealProvider = context.read<MealProvider>();
    final meals = mealProvider.meals;

    return Scaffold(
      // add an AppBar with back button
      appBar: AppBar(
        title: const Text('Meal Screen'),

        // add a back button
        leading: IconButton(
          onPressed: () {
            context.go('/');
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: // create a list of meals using ListView.builder
          ListView.builder(
        itemCount: meals.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: MealCard(
              imageUrl: meals[index].imageUrl!,
              mealName: meals[index].name,
              restaurantAddress: meals[index].restaurantAddress,
              restaurantName: meals[index].restaurantName,
            ),
          );
        },
      ),
    );
  }
}
