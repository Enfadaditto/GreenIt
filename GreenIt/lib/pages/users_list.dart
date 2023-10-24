import 'package:flutter/material.dart';
import 'package:my_app/models/user.dart';
import 'package:my_app/widgets/appbar_widget.dart';
import 'package:my_app/pages/profile_page.dart'; // Import the user profile page

class UsersList extends StatefulWidget {
  final List<User> users;

  UsersList({required this.users});

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView.builder(
        itemCount: widget.users.length,
        itemBuilder: (context, index) {
          User user = widget.users[index];
          final image = NetworkImage(user.imagePath);
          return GestureDetector(
            onTap: () {
              // Navigate to the user's profile page when tapped
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(user: user),
                ),
              );
            },
            child: ListTile(
              leading: ClipOval(
                child: Material(
                  color: Colors.transparent,
                  child: Ink.image(
                    image: image,
                    fit: BoxFit.cover,
                    width: 36,
                    height: 36,
                  ),
                ),
              ),
              title: Text(user.name), // Display the user's name
              // You can customize the ListTile further (e.g., add profile images, actions, etc.)
            ),
          );
        },
      ),
    );
  }
}
