import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  User? get user => _user;
  bool get isSignedIn => _user != null;

  Future<void> initialize() async {
    await Firebase.initializeApp();
    _user = _auth.currentUser;
    notifyListeners();
  }

  Future<void> login(
      String email, String password, BuildContext context, callback) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _user = _auth.currentUser;
      context.go('/');
      callback(context, 'Login successful');
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      callback(context, 'Login failed try again');
      print(e);
    }
  }

  Future<void> register(
      dataObj, BuildContext context, Function callback) async {
    var email = dataObj['email'];
    var password = dataObj['password'];
    var name = dataObj['name'];
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (name == '') {
        throw FirebaseAuthException(
            code: 'invalid-name', message: 'Please enter a name');
      }

      _user = _auth.currentUser;
      context.go('/');
      callback(context, 'Registration successful');
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      callback(context, 'Registration failed try again');
      print(e);
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    _user = null;
    notifyListeners();
  }
}
