import 'dart:convert';
import 'dart:ffi';
import 'package:my_app/Persistance/RepoUser.dart';
import 'package:my_app/pages/for_you_page.dart';
import 'package:my_app/pages/new_post.dart';
import 'package:my_app/pages/profile_page.dart';
import 'package:my_app/utils/user_pref.dart';
import 'package:my_app/widgets/bottom_navigation_bar_widget.dart';
import 'package:my_app/Models/user.dart';

import 'Persistance/RepoUser.dart';
import 'Persistance/ServerConnect.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIndex = 0;
  final serverUrl = "http://localhost:8080/user?email=ida@mail.com";
  final pages = [
    // const ForYouPage(),
    const ForYouPage(),
    const NewPost(),
    ProfilePage(user: UserPref.myUser),
    // const NewPost(),
    // ProfilePage(user: UserPreferences.myUser),
  ]; // Initialize the current index
  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue.shade300,
        dividerColor: Colors.black,
      ),
      home: Scaffold(
        body: pages[currentIndex],
        bottomNavigationBar: bottomNavigationBar(currentIndex, onTabTapped),
      ),
    );
  }
}
