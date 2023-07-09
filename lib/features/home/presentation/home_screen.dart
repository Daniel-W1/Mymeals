import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_meals/features/home/presentation/card_screen.dart';
import 'package:my_meals/features/user/application/user_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = context.read<UserProvider>();
    final userName = userProvider.user != null ? userProvider.user!.name : '';

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/images/food.png',
                    width: 200.0, // Adjust the width as needed
                  ),
                  const SizedBox(width: 20.0),
                  Flexible(
                    child: Text(
                      'Welcome ${userName.toUpperCase()}!',
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  GestureDetector(
                    onTap: () => context.go('/restaurants'),
                    child: const Mycard(
                      imagePath: 'assets/images/restaurant.png',
                      title: 'Restaurants',
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.go('/meals'),
                    child: const Mycard(
                      imagePath: 'assets/images/meals.png',
                      title: 'Meals',
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.go('/discounts'),
                    child: const Mycard(
                      imagePath: 'assets/images/discount.png',
                      title: 'Today\'s Discounts',
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.go('/pickforme'),
                    child: const Mycard(
                      imagePath: 'assets/images/fav.png',
                      title: 'Pick For Me',
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
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
      ),
    );
  }
}
