import 'package:flutter/material.dart';
import 'package:my_app/Models/ReducedUser.dart';
import 'package:my_app/widgets/appbar_widget.dart';
import 'package:my_app/pages/profile_page.dart'; // Import the user profile page

class UsersList extends StatefulWidget {
  final List<ReducedUser> users;

  UsersList({required this.users});

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Column(
        children: [
          const SizedBox(
            height: 12,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.users.length,
              itemExtent: 72,
              // #TODO
              itemBuilder: (context, index) {
                ReducedUser user = widget.users[index];
                final image = NetworkImage(user.image);
                return GestureDetector(
                  onTap: () {
                    // Navigate to the user's profile page when tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProfilePage(data: user.displayName, type: "name"),
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
                          width: 60,
                          height: 60,
                        ),
                      ),
                    ),
                    title: Text(user.displayName), // Display the user's name
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
