class Restaurant {
  final String? id;
  final String name;
  final String address;
  final double rating;
  final String imageUrl;
  final String city;
  final String country;
  final String webUrl;

  Restaurant({
    this.id,
    required this.name,
    required this.address,
    required this.rating,
    required this.imageUrl,
    required this.city,
    required this.country,
    required this.webUrl,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'] as String?,
      name: json['name'] as String,
      address: json['address'] as String,
      rating: json['rating'] as double,
      imageUrl: json['imageUrl'] as String,
      city: json['city'] as String,
      country: json['country'] as String,
      webUrl: json['webUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'rating': rating,
      'imageUrl': imageUrl,
      'city': city,
      'country': country,
      'webUrl': webUrl,
    };
  }
}
