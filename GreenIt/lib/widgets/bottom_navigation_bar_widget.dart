import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

BottomNavigationBar bottomNavigationBar(
    int currentIndex, Function(int) onTabTapped) {
  const iconHome = CupertinoIcons.home;
  const iconAdd = CupertinoIcons.add;
  const iconProfile = CupertinoIcons.profile_circled;
  return BottomNavigationBar(
    currentIndex: currentIndex,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: const Color(0xFF269A66),
    showUnselectedLabels: false,
    onTap: (index) => onTabTapped(index),
    items: const [
      BottomNavigationBarItem(
        icon: Icon(iconHome),
        label: 'Home',
        backgroundColor: Color(0xFF269A66),
      ),
      BottomNavigationBarItem(
        icon: Icon(iconAdd),
        label: 'Add Post',
        backgroundColor: Color(0xFF269A66),
      ),
      BottomNavigationBarItem(
        icon: Icon(iconProfile),
        label: 'Profile',
        backgroundColor: Color(0xFF269A66),
      ),
    ],
  );
}
