import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context) {
  final iconSearch = CupertinoIcons.search;
  final iconOptions = CupertinoIcons.ellipsis;
  if (Navigator.of(context).canPop()) {
    print("OK\n");
  }
  return AppBar(
      leading: BackButton(),
      backgroundColor: Colors.black,
      elevation: 0,
      actions: [
        IconButton(
          icon: Icon(iconSearch),
          onPressed: () {},
        ),
        IconButton(onPressed: () {}, icon: Icon(iconOptions)),
      ]);
}
