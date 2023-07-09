class Preference {
  String? id;
  final List<String> dietaryRestrictions;
  final List<String> favoriteCuisines;
  final List<String> mealTypes;

  Preference({
    required this.dietaryRestrictions,
    required this.favoriteCuisines,
    required this.mealTypes,
  });

  factory Preference.fromJson(Map<String, dynamic> json) {
    return Preference(
      dietaryRestrictions: List<String>.from(json['dietaryRestrictions']),
      favoriteCuisines: List<String>.from(json['favoriteCuisines']),
      mealTypes: List<String>.from(json['mealTypes']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dietaryRestrictions': dietaryRestrictions,
      'favoriteCuisines': favoriteCuisines,
      'mealTypes': mealTypes,
    };
  }
}
