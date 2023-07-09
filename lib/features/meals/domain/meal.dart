class Meal {
  String? id;
  final String name;
  final String description;
  final String cuisineType;
  final String mealType;
  final List<String> dietaryRestrictions;
  String? restaurantId;
  final String restaurantName;
  final String restaurantAddress;
  String? imageUrl;

  Meal({
    this.id,
    this.imageUrl,
    required this.name,
    required this.description,
    required this.cuisineType,
    required this.mealType,
    required this.dietaryRestrictions,
    required this.restaurantName,
    required this.restaurantAddress,
    this.restaurantId,
    // Initialize other meal-related fields here
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['id'] as String,
      restaurantId: json['restaurantId'] as String?,
      restaurantName: json['restaurantName'] as String,
      restaurantAddress: json['restaurantAddress'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      cuisineType: json['cuisineType'] as String,
      mealType: json['mealType'] as String,
      dietaryRestrictions: (json['dietaryRestrictions'] as List<dynamic>)
          .map((restriction) => restriction as String)
          .toList(),
      imageUrl: json['imageUrl'] as String?,
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
      'dietaryRestrictions': dietaryRestrictions,
      'restaurantId': restaurantId,
      'restaurantName': restaurantName,
      'restaurantAddress': restaurantAddress,
    };
  }
}