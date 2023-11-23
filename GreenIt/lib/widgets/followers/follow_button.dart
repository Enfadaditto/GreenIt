import 'package:flutter/material.dart';
import 'package:my_app/Persistance/IRepoUser.dart';

Widget buildFollowButton(IRepoUser repoUser, int follower, int following) =>
    ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green, // Green color
        foregroundColor: Colors.white, // White text color
      ),
      onPressed: () async {
        try {
          await repoUser.follow(follower, following);
          print('User followed successfully');
          // You might want to update your UI or show a message here
        } catch (e) {
          print('Error following user: $e');
          // Handle the error, show a message, or take any other appropriate action
        }
      },
      child: const Text('Follow'),
    );
