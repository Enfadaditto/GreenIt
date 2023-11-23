import 'package:flutter/material.dart';

Widget buildAbout(BuildContext context, description) => Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 5, vertical: 5), // Adjusted horizontal padding
      color: Colors.grey[200], // Light grey background color
      height: 5 * 16.0, // 5 lines of text, each with a height of 16.0
      width: MediaQuery.of(context).size.width * 0.8, // 80% of screen width
      child: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  softWrap: true,
                  style: const TextStyle(fontSize: 16, height: 1.4),
                ),
              ],
            );
          },
        ),
      ),
    );
