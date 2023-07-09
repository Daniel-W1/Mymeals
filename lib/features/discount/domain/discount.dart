import 'package:my_meals/features/restaurants/domain/restaurant.dart';

class Discount {
  String? id;
  final String name;
  final Restaurant restaurant;

  Discount({this.id, required this.name, required this.restaurant});

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'restaurant': restaurant.toJson(),
      };

  factory Discount.fromJson(Map<String, dynamic> json) => Discount(
        id: json['id'],
        name: json['name'],
        restaurant: Restaurant.fromJson(json['restaurant']),
      );
}
