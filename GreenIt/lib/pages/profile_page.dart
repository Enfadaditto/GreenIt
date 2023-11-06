import 'package:flutter/material.dart';
import 'package:my_app/Models/user.dart';
import 'package:my_app/Persistance/IRepoUser.dart';
import 'package:my_app/pages/edit_profile_page.dart';
import 'package:my_app/utils/notuser_preferences.dart';
import 'package:my_app/widgets/profile_page/button_widget.dart';
import 'package:my_app/widgets/profile_page/numbers_widget.dart';
import 'package:my_app/widgets/profile_page/profile_gallery_widget.dart';
import 'package:my_app/widgets/appbar_widget.dart';
import '../widgets/profile_page/profile_widget.dart';
import 'package:my_app/Persistance/RepoUser.dart'; // Import your user repository

class ProfilePage extends StatefulWidget {
  final String email;

  ProfilePage({required this.email});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<User> userPetition;
  final IRepoUser repoUser = RepoUser();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _loadUserData() async {
    try {
      userPetition = repoUser.read(widget.email);
    } catch (e) {
      userPetition = Future.value(User(
        displayName: 'MISTAKE',
        email: 'MISTAKE',
        password: 'MISTAKE',
        serverName: 'MISTAKE',
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    _loadUserData();
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
                  builder: (context) => EditProfilePage(user: userPetition),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          buildProfileData(
              userPetition), // Display user data if available// Show a loading indicator while fetching data
          const SizedBox(height: 24),
          Center(child: buildUpgradeButton()),
          const SizedBox(height: 12),
          Container(
            height: 900,
            padding: EdgeInsets.all(10),
            child: buildProfileGallery(context, UserPreferences.myUser),
          ),
        ],
      ),
    );
  }

  Widget buildProfileData(Future<User> user) => FutureBuilder<User>(
        future: user,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Display a loading indicator while waiting for data
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final user = snapshot.data;
            return Column(
              children: [
                Text(
                  user!.displayName,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                const SizedBox(height: 4),
                Text(
                  user.email,
                  style: TextStyle(color: Colors.grey),
                ),
                // You can add more user information here, such as a bio or other details
              ],
            );
          }
        },
      );

  Widget buildUpgradeButton() =>
      ButtonWidget(text: 'Upgrade to PRO', onClicked: () {});
}
