import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:my_meals/features/user/domain/user.dart';

import '../../preference/domain/preference.dart';

class UserProvider extends ChangeNotifier {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference _preferencesCollection =
      FirebaseFirestore.instance.collection('preferences');

  User? _user;

  User? get user => _user;

  Future<void> createUser(
      String name, String email, int age, String sex, String preference) async {
    final preferenceData = Preference(
      dietaryRestrictions: [],
      favoriteCuisines: [],
      mealTypes: [],
    ).toJson();

    // print(preferenceData);
    // print('we are here');

    try {
      // Create preference document
      final preferenceDocRef = await _preferencesCollection.add(preferenceData);

      // print('preference created');
      // print(preferenceDocRef.id);

      // Create user document
      final user = User(
          pid: preferenceDocRef.id,
          name: name,
          email: email,
          sex: sex,
          age: age,
          preference: preference);
      final userData = user.toJson();
      await _usersCollection.add(userData);

      _user = user;
      notifyListeners();

      // print('user created');
    } catch (e) {
      // Handle error
      print('Error creating user: $e');
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      await _usersCollection.doc(id).delete();
    } catch (e) {
      // Handle error
      print('Error deleting user: $e');
    }
  }

  Future<User?> getUser(String id) async {
    try {
      final snapshot = await _usersCollection.doc(id).get();
      if (snapshot.exists) {
        final userData = snapshot.data() as Map<String, dynamic>;
        return User.fromJson(userData);
      }
    } catch (e) {
      // Handle error
      print('Error getting user: $e');
    }
    return null;
  }
}
