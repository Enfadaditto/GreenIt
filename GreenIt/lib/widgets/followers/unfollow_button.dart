import 'package:flutter/material.dart';
import 'package:my_app/Persistance/IRepoUser.dart';

Widget buildUnfollowButton(IRepoUser repoUser, int follower, int following) =>
    ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red[100], // Green color
        foregroundColor: Colors.white, // White text color
      ),
      onPressed: () async {
        try {
          await repoUser.unfollow(follower, following);
          print('User unfollowed successfully');
          // You might want to update your UI or show a message here
        } catch (e) {
          print('Error unfollowing user: $e');
          // Handle the error, show a message, or take any other appropriate action
        }
      },
      child: const Text('Unfollow'),
    );
