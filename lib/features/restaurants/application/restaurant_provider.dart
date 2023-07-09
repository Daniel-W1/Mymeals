import 'package:flutter/material.dart';
import 'package:my_meals/features/restaurants/domain/restaurant.dart';
import 'package:yelp_fusion_client/yelp_fusion_client.dart';

final String apiKey =
    'LyfWxLSSY_yESv-BhAol0_t8g2aIjo8rJb8PjMJ_cTbho8i2e8Ly9nsw-rz-c6g3iEVMD5j15GmxVcbOS9-vpugQpIBWOyS_qIgiKhaKclt9b2vhmgHq3tjULWSpZHYx';

class RestaurantProvider extends ChangeNotifier {
  final yelpFusionClient = YelpFusion(apiKey: '$apiKey');

  var _restaurants;

  get restaurants => _restaurants;

  Future<void> getRestaurants(double latitude, double longitude) async {
    final searchResult = await yelpFusionClient.fetchBusinessSearch(
      term: 'restaurants',
      latitude: latitude,
      longitude: longitude,
      limit: 50,
      radius: 1000,
    );

    _restaurants = parseResult(searchResult.businesses.businesses);

    print(searchResult.businesses.businesses);
    notifyListeners();
  }

  parseResult(restaurants) {
    final parsedRestaurants = restaurants.map((business) {
      return Restaurant(
        name: business.name ?? "",
        imageUrl: business.imageUrl ?? "",
        address: business.location.address1 ?? "",
        city: business.location.city ?? "",
        country: business.location.country ?? "",
        rating: business.rating ?? 0.0,
        webUrl: business.url ?? "",
      );
    }).toList();

    return parsedRestaurants;
  }
}
