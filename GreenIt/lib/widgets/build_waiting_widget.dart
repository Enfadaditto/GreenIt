import 'package:flutter/material.dart';

class WaitingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFCFF4D2), // Use the specified color
      body: Center(
        child: Text(
          'GreenIt',
          style: TextStyle(
            color: Colors.green, // Text color is set to green
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
