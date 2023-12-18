import 'package:flutter/material.dart';
import 'package:my_app/pages/register/welcome_page.dart';

class GreenItPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () {
              // Use the new BuildContext to access Navigator
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => WelcomePage(),
                ),
              );
            },
            child: Container(
              color: const Color(0xFFCFF4D2),
              child: Center(
                child: Image.asset(
                  'lib/assets/register/green_it_logo.png',
                  width: 350, // Adjust the width as needed
                  height: 342, // Adjust the height as needed
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
