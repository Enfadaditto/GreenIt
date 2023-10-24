import 'package:flutter/material.dart';

import '../../Models/notUser.dart';


GridView buildProfileGallery(BuildContext context, notUser user) =>
    GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10, // Use mainAxisSpacing instead of mainAxisExtent
      ),

      itemCount: user.imagesList.length, // Specify the item count
      itemBuilder: (context, index) {
        return Container(
          height: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            image: DecorationImage(
              image: NetworkImage(user.imagesList[index]),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
