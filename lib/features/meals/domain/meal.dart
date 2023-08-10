import 'package:my_meals/features/meals/domain/meal_rating.dart';

class Meal {
  String? id;
  final String name;
  final String description;
  final String cuisineType;
  final String mealType;
  String? restaurantId;
  final String restaurantName;
  final String restaurantAddress;
  String? imageUrl;
  // create a rating for each meal with userid who rated it
  List<dynamic>? ratings;

  Meal({
    this.id,
    this.imageUrl,
    required this.name,
    required this.description,
    required this.cuisineType,
    required this.mealType,
    required this.restaurantName,
    required this.restaurantAddress,
    this.restaurantId,
    this.ratings,
    // Initialize other meal-related fields here
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['id'] ?? "",
      restaurantId: json['restaurantId'] ?? "",
      restaurantName: json['restaurantName'] ?? "",
      restaurantAddress: json['restaurantAddress'] ?? "",
      name: json['name'] ?? "",
      description: json['description'] ?? "",
      cuisineType: json['cuisineType'] ?? "",
      mealType: json['mealType'] ?? "",
      imageUrl: json['imageUrl'] ?? "",
      ratings: (json['ratings'] as List<dynamic>?)
          ?.map((rating) => MealRating(
                rating: rating['rating'] ?? 0,
                userId: rating['userId'] ?? 0,
              ))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'name': name,
      'description': description,
      'cuisineType': cuisineType,
      'mealType': mealType,
      'restaurantId': restaurantId,
      'restaurantName': restaurantName,
      'restaurantAddress': restaurantAddress,
      'ratings': ratings?.map((rating) => rating.toJson()).toList() ?? [],
    };
  }
}
