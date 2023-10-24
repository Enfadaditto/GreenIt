import 'package:flutter/material.dart';
import 'package:my_app/models/user.dart';
import 'package:my_app/pages/edit_profile_page.dart';
import 'package:my_app/widgets/profile_page/button_widget.dart';
import 'package:my_app/widgets/profile_page/numbers_widget.dart';
import 'package:my_app/widgets/profile_page/profile_gallery_widget.dart';
import '../utils/user_preferences.dart';
import 'package:my_app/widgets/appbar_widget.dart';
import '../widgets/profile_page/profile_widget.dart';

class ProfilePage extends StatefulWidget {
  final User user;

  ProfilePage({required this.user});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    UserPreferences.initializeUsers();
    debugPrint("HALO PROFILE PAGE followers ${widget.user.followers.length}");
    debugPrint("HALO PROFILE PAGE following ${widget.user.following.length}");
    debugPrint(
        "HALO PROFILE PAGE images list ${widget.user.imagesList.length}");

    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 24),
          ProfileWidget(
            imagePath: widget.user.imagePath,
            onClicked: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => EditProfilePage(user: widget.user)),
              );
            },
          ),
          const SizedBox(height: 24),
          buildName(widget.user),
          const SizedBox(height: 24),
          Center(child: buildUpgradeButton()),
          const SizedBox(height: 12),
          Center(child: NumbersWidget(widget.user)),
          const SizedBox(height: 12),
          Container(
            height: 900,
            padding: EdgeInsets.all(10),
            child: buildProfileGallery(context, widget.user),
          ),
        ],
      ),
    );
  }

  Widget buildName(User user) => Column(
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
