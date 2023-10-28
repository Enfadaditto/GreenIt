import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar buildForYouPageAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.black,
    title: const Text(
      "GreenIt",
      style: TextStyle(color: Colors.white),
    ),
    actions: [
      IconButton(onPressed: () {}, icon: const Icon(Icons.search), color: Colors.white),
      IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz), color: Colors.white)
    ],
  );
}
