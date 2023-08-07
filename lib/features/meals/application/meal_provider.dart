import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:my_meals/core/services/meal_scrapper.dart';
import 'package:my_meals/features/meals/domain/meal.dart';

class MealProvider extends ChangeNotifier {
  final CollectionReference _mealsCollection =
      FirebaseFirestore.instance.collection('meals');

  // create a meals and getter for the meals
  List<Meal> _meals = [];
  List<Meal> get meals => _meals;

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
    _meals = totalMeals;
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
}
