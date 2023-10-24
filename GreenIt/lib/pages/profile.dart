import 'package:flutter/material.dart';
import 'package:my_app/Models/notUser.dart';
import 'package:my_app/pages/edit_profile_page.dart';
import 'package:my_app/widgets/profile_page/button_widget.dart';
import 'package:my_app/widgets/profile_page/numbers_widget.dart';
import 'package:my_app/widgets/profile_page/profile_gallery_widget.dart';
import '../utils/user_preferences.dart';
import 'package:my_app/widgets/appbar_widget.dart';
import '../widgets/profile_page/profile_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;

    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 24),
          ProfileWidget(
            imagePath: user.imagePath,
            onClicked: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => EditProfilePage()),
              );
            },
          ),
          const SizedBox(height: 24),
          buildName(user),
          const SizedBox(height: 24),
          Center(child: buildUpgradeButton()),
          const SizedBox(height: 12),
          Center(child: NumbersWidget()),
          const SizedBox(height: 12),
          Container(
            height: 900,
            padding: EdgeInsets.all(10),
            child: buildProfileGallery(context, user),
          ),
        ],
      ),
    );
  }

  Widget buildName(notUser user) => Column(
        children: [
          Text(
            user.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      );
}

Widget buildUpgradeButton() =>
    ButtonWidget(text: 'Upgrade to PRO', onClicked: () {});
