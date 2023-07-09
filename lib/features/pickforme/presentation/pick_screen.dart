import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PickScreen extends StatelessWidget {
  const PickScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick Screen'),
        leading: IconButton(
          onPressed: () {
            context.go('/');
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        child: const Center(
          child: Text('Pick Screen'),
        ),
      ),
    );
  }
}
