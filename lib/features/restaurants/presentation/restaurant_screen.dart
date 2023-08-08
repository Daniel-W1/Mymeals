import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_meals/features/authentication/application/auth_provider.dart';
import 'package:my_meals/features/restaurants/application/restaurant_provider.dart';
import 'package:my_meals/features/restaurants/presentation/tile_screen.dart';
import 'package:provider/provider.dart';
import '../../location/application/location_provider.dart';

class RestaurantsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final resProvider = context.read<RestaurantProvider>();
    final restaurants = resProvider.restaurants;
    final locProvider = context.read<LocationProvider>();
    final location = locProvider.currentLocation!;

    print(AuthProvider().user);

    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurants'),
        leading: IconButton(
          onPressed: () {
            context.go('/');
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await resProvider.getRestaurants(
              location.latitude,
              location
                  .longitude); // Implement the method to fetch restaurants again.
        },
        child: restaurants.isEmpty
            ? Center(
                child: Text('No restaurants available.'),
              )
            : ListView.builder(
                itemCount: restaurants.length,
                itemBuilder: (context, index) {
                  return RestaurantTile(restaurant: restaurants[index]);
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implement the navigation to the add restaurant screen here.
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
