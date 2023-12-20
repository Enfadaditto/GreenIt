import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/utils/cache_manager.dart';

AppBar buildMessagesPageAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: const Color.fromARGB(255, 38, 154, 102),
    elevation: 0,
    title: const Row(
      children: [
        Expanded(
            child: Center(
          child: Text(
            "Chats",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ))
      ],
    ),
  );
}
