class MealRating {
  final int rating;
  final String userId;

  MealRating({
    required this.rating,
    required this.userId,
  });

  factory MealRating.fromJson(Map<String, dynamic> json) {
    return MealRating(
      rating: json['rating'] as int,
      userId: json['userId'] as String,
    );
  } 

  Map<String, dynamic> toJson() {
    return {
      'rating': rating,
      'userId': userId,
    };
  }
}
