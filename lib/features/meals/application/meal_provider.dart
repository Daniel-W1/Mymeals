import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:my_meals/core/services/meal_scrapper.dart';
import 'package:my_meals/features/meals/domain/meal.dart';
import 'package:http/http.dart' as http;

class MealProvider extends ChangeNotifier {
  final CollectionReference _mealsCollection =
      FirebaseFirestore.instance.collection('meals');

  // create a meals and getter for the meals
  List<Meal>? _meals = [];
  List<Meal>? _topFiveMeals = [];

  List<Meal>? get meals => _meals;
  List<Meal>? get topFiveMeals => _topFiveMeals;

  Future<void> createMeal(Meal meal) async {
    final mealData = meal.toJson();

    try {
      await _mealsCollection.doc(meal.id).set(mealData);
    } catch (e) {
      // Handle error
      print('Error creating meal: $e');
    }
  }

  Future<void> updateMeal(Meal meal) async {
    final mealData = meal.toJson();
    try {
      await _mealsCollection.doc(meal.id).update(mealData);
    } catch (e) {
      // Handle error
      print('Error updating meal: $e');
    }
  }

  Future<void> deleteMeal(String id) async {
    try {
      await _mealsCollection.doc(id).delete();
    } catch (e) {
      // Handle error
      print('Error deleting meal: $e');
    }
  }

  Future<Meal?> getMeal(String id) async {
    final snapshot = await _mealsCollection.doc(id).get();
    if (snapshot.exists) {
      final mealData = snapshot.data() as Map<String, dynamic>;
      return Meal.fromJson(mealData);
    }
    return null;
  }

  Future<List<Meal>> getMeals() async {
    final snapshot = await _mealsCollection.get();
    return snapshot.docs.map((doc) {
      final mealData = doc.data() as Map<String, dynamic>;
      return Meal.fromJson(mealData);
    }).toList();
  }

  getMealFromUrls(resUrls) async {
    final totalMeals = <Meal>[];

    for (var urllist in resUrls) {
      final response = await getRestuarantMeals(urllist[0], urllist[1]);
      // response is a list of meals from the restaurant, so add them to totalMeals
      var val = (response.length > 6) ? 6 : response.length;
      totalMeals.addAll(response.sublist(0, val));
    }

    await storeMealsToFirestore(totalMeals);
    final res = await getAllMealsFromDatabase();

    _meals = res;
    notifyListeners();
  }

  prepareMealspage(restaurants) async {
    final resUrls = restaurants
        .sublist(0, 10)
        .map((res) => [
              res.toJson()['webUrl'],
              {
                'name': res.toJson()['name'],
                'imageUrl': res.toJson()['imageUrl'],
                'address': res.toJson()['address'],
              }
            ])
        .toList();

    await getMealFromUrls(resUrls);
  }

  Future<void> storeMealsToFirestore(List<Meal> meals) async {
    try {
      for (var meal in meals) {
        final mealData = meal.toJson();
        await _mealsCollection.doc(meal.id).set(mealData);
      }
    } catch (e) {
      print('Error storing meals in Firestore: $e');
    }
  }

  Future<List<Meal>> getAllMealsFromDatabase() async {
    try {
      final snapshot = await _mealsCollection.get();
      final res = snapshot.docs.map((doc) {
        var mealData = doc.data() as Map<String, dynamic>;
        return Meal.fromJson(mealData);
      }).toList();

      return res;
    } catch (e) {
      print('Error getting meals from Firestore: $e');
      return [];
    }
  }

  // write a function to get the top five meals form a flask api given a user id
  Future<List<Meal>> getTopFiveMeals(String userId) async {
    try {
      final baseUrl = 'http://10.0.2.2:5000';
      print('$baseUrl/getTop5mealForAuser?userId=$userId');
      final response = await http
          .get(Uri.parse('$baseUrl/getTop5mealForAuser?userId=$userId'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final top5MealsData = List<Map<String, dynamic>>.from(jsonData);

        _topFiveMeals = top5MealsData.map((mealData) {
          return Meal(
            name: mealData['name'] ?? '',
            imageUrl: mealData['imageUrl'] ?? '',
            description: mealData['description'] ?? '',
            cuisineType: mealData['cuisineType'] ?? '',
            mealType: mealData['mealType'] ?? '',
            restaurantAddress: mealData['restaurantAddress'] ?? '',
            restaurantName: mealData['restaurantName'] ?? '',
            id: mealData['id'] ?? '',
            ratings: mealData['ratings'] ?? [],
            restaurantId: mealData['restaurantId'] ?? '',
          );
        }).toList();

        return _topFiveMeals ?? [];
      } else {
        print('Error getting meals from Firestore: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error getting meals from Firestore: $e');
      return [];
    }
  }
}
