import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

BottomNavigationBar bottomNavigationBar(
    int currentIndex, Function(int) onTabTapped) {
  final iconHome = CupertinoIcons.home;
  final iconAdd = CupertinoIcons.add;
  final iconProfile = CupertinoIcons.profile_circled;
  return BottomNavigationBar(
    currentIndex: currentIndex,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.black,
    showUnselectedLabels: false,
    onTap: (index) => onTabTapped(index),
    items: [
      BottomNavigationBarItem(
        icon: Icon(iconHome),
        label: 'Home',
        backgroundColor: Color.fromARGB(255, 187, 146, 253).withOpacity(0.8),
      ),
      // BottomNavigationBarItem(
      //   icon: Icon(iconFavorites),
      //   label: 'Favorites',
      //   backgroundColor: Color.fromARGB(255, 187, 146, 253).withOpacity(0.8),
      // ),
      BottomNavigationBarItem(
        icon: Icon(iconAdd),
        label: 'Add Post',
        backgroundColor: Color.fromARGB(255, 187, 146, 253).withOpacity(0.8),
      ),
      BottomNavigationBarItem(
        icon: Icon(iconProfile),
        label: 'Profile',
        backgroundColor: Color.fromARGB(255, 187, 146, 253).withOpacity(0.8),
      ),
    ],
  );
}
