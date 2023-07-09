import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_meals/features/location/application/location_provider.dart';
import 'package:provider/provider.dart';
import '../../user/application/user_provider.dart';
import '../application/auth_provider.dart';

class SignupScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  void showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      backgroundColor: message.contains('success') ? Colors.green : Colors.red,
      content: Text(message,
          style: const TextStyle(
            color: Colors.black,
          )),
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/food.png',
                width: 250.0, // Adjust the width as needed
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              const Text(
                'Create a new account',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Full name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person), // Add mail button
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.mail), // Add mail button
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock), // Add lock button
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                width: double.infinity, // Make button width larger
                child: ElevatedButton(
                  onPressed: () async {
                    final authProvider = context.read<AuthProvider>();
                    final userProvider = context.read<UserProvider>();
                    final locationProvider = context.read<LocationProvider>();

                    final data = {
                      'name': nameController.text.trim(),
                      'email': emailController.text.trim(),
                      'password': passwordController.text.trim()
                    };

                    await userProvider.createUser(
                        data['name'] ?? "", data['email'] ?? "");
                    await authProvider.register(data, context, showSnackbar);
                    await locationProvider.syncLocation(context);

                    print('----------------------------------------');
                    print(locationProvider.currentLocation);
                  }, // Call _signup function to create a new account
                  child: const Text('Sign Up'),
                ),
              ),
              const SizedBox(height: 10.0),
              GestureDetector(
                onTap: () {
                  // Add navigation logic to navigate back to the login screen
                  context.go('/signin');
                },
                child: const Text(
                  'Already have an account? Login',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
