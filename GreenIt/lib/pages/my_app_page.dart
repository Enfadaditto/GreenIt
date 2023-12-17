import 'package:my_app/pages/for_you_page.dart';
import 'package:my_app/pages/new_post.dart';
import 'package:my_app/pages/profile_page.dart';
import 'package:my_app/widgets/bottom_navigation_bar_widget.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  final String username;
  final String type;

  const MyApp({Key? key, required this.username, required this.type})
      : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIndex = 0;
  final serverUrl = "http://localhost:8080/user?email=ida@mail.com";
  late List<Widget> pages; // Declare pages as a late variable

  @override
  void initState() {
    super.initState();
    // Initialize pages based on the provided username and type
    pages = [
      const ForYouPage(),
      const NewPost(),
      ProfilePage(data: widget.username, type: widget.type),
    ];
  }

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
