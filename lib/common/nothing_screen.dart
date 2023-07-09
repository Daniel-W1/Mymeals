import 'package:flutter/material.dart';

class NothingScreen extends StatelessWidget {
  final String message;

  const NothingScreen({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/sadface.png', // Replace with your own image asset path
            width: 200,
            height: 200,
          ),
          SizedBox(height: 20),
          Text(
            message,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
