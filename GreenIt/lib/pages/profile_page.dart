import 'package:flutter/material.dart';
import 'package:my_app/Models/user.dart';
import 'package:my_app/pages/edit_profile_page.dart';
import 'package:my_app/widgets/profile_page/button_widget.dart';
import 'package:my_app/widgets/profile_page/numbers_widget.dart';
import 'package:my_app/widgets/profile_page/profile_gallery_widget.dart';
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
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 24),
          ProfileWidget(
            imagePath:
                'https://assets.laliga.com/squad/2023/t178/p56764/2048x2225/p56764_t178_2023_1_001_000.png',
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
        ],
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.displayName,
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
