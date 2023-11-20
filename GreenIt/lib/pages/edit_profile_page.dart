import 'package:flutter/material.dart';
import 'package:my_app/Models/User.dart';
import 'package:my_app/widgets/appbar_widget.dart';
import 'package:my_app/widgets/profile_page/profile_widget.dart';
import 'package:my_app/widgets/profile_page/textfield_widget.dart';

class EditProfilePage extends StatelessWidget {
  final Future<User?> user;

  EditProfilePage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: FutureBuilder<User?>(
        future: user,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Show a loading indicator while data is being fetched.
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Text('User data not available');
          } else {
            final User userData = snapshot.data!;

            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 32),
              physics: BouncingScrollPhysics(),
              children: [
                const SizedBox(height: 24),
                ProfileWidget(
                  imagePath: userData.image,
                  isEdit: true,
                  onClicked: () async {},
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Full Name',
                  text: userData.displayName,
                  onChanged: (displayName) {
                    // Handle changes to display name.
                  },
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Email',
                  text: userData.email,
                  onChanged: (email) {
                    // Handle changes to email.
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class ProfileDataWidget extends StatelessWidget {
  final User userData;

  ProfileDataWidget({required this.userData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          userData.displayName,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        const SizedBox(height: 4),
        Text(
          userData.email,
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
