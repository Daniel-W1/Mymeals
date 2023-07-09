import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../domain/preference.dart';

class PreferenceProvider extends ChangeNotifier {
  final CollectionReference _preferencesCollection =
      FirebaseFirestore.instance.collection('preferences');

  Future<void> createPreference(Preference preference) async {
    try {
      final docRef = await _preferencesCollection.add(preference.toJson());
      preference.id = docRef.id;
      notifyListeners();
    } catch (e) {
      // Handle error
      print('Error creating preference: $e');
    }
  }

  Future<void> updatePreference(Preference preference) async {
    try {
      await _preferencesCollection
          .doc(preference.id)
          .update(preference.toJson());
      notifyListeners();
    } catch (e) {
      // Handle error
      print('Error updating preference: $e');
    }
  }

  Future<void> deletePreference(String id) async {
    try {
      await _preferencesCollection.doc(id).delete();
      notifyListeners();
    } catch (e) {
      // Handle error
      print('Error deleting preference: $e');
    }
  }
}
