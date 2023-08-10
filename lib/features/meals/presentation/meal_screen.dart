import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_meals/features/meals/presentation/meal_item_screen.dart';
import 'package:provider/provider.dart';
import '../application/meal_provider.dart';

class MealsScreen extends StatefulWidget {
  const MealsScreen({super.key});

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final mealProvider = context.read<MealProvider>();
    final meals = mealProvider.meals ?? [];

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
          print(meals[index].id!);
          print('-----------------');
          print(meals.length);
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
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Meals',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Pick For Me',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/');
              break;
            case 1:
              context.go('/meals');
              break;
            case 2:
              context.go('/pickforme');
              break;
          }

          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
