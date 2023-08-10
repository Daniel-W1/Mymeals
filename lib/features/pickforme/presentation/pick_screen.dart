import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_meals/features/meals/application/meal_provider.dart';
import 'package:provider/provider.dart';

import '../../meals/domain/meal.dart';
import '../../meals/presentation/meal_item_screen.dart';

class PickScreen extends StatefulWidget {
  const PickScreen({super.key});

  @override
  State<PickScreen> createState() => _PickScreenState();
}

class _PickScreenState extends State<PickScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final meals = context.read<MealProvider>().topFiveMeals ?? [];

    return Scaffold(
        appBar: AppBar(
          title: const Text('Pick For Me'),
          leading: IconButton(
            onPressed: () {
              context.go('/');
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: ListView.builder(
          itemCount: meals.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: MealCard(
                id: meals[index].id!,
                imageUrl: meals[index].imageUrl!,
                mealName: meals[index].name,
                restaurantAddress: meals[index].restaurantAddress,
                restaurantName: meals[index].restaurantName,
                ratings: meals[index].ratings,
              ),
            );
          },
        ));
  }
}
