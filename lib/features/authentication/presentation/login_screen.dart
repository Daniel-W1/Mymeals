import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_meals/features/authentication/application/auth_provider.dart';
import 'package:my_meals/features/location/application/location_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void showSnackbar(BuildContext context, String message) {
    bool check = message.toLowerCase().contains('success');
    final snackBar = SnackBar(
      backgroundColor: check ? Colors.green : Colors.red,
      content: Text(message,
          style: const TextStyle(
            color: Colors.white,
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
                'Welcome!',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              const Text(
                'let\'s get you some meal :)',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.mail), // Add mail button
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock), // Add lock button
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20.0),
              Consumer<AuthProvider>(
                builder: (context, authProvider, child) {
                  return SizedBox(
                    width: double.infinity, // Make button width larger
                    child: ElevatedButton(
                      onPressed: () async {
                        final authProvider = context.read<AuthProvider>();

                        await authProvider.login(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                            context,
                            showSnackbar);

                        print(authProvider.user);
                        print('we are here - --------------------');
                      },
                      child: const Text('Login'),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10.0),
              GestureDetector(
                onTap: () {
                  print('Sign up tapped');
                  context.go('/signup');
                },
                child: const Text(
                  'Don\'t have an account? Sign up',
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
