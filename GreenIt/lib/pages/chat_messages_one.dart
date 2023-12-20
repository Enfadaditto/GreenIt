import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_app/widgets/appbar_chat_one.dart';
import 'package:my_app/widgets/appbar_foryoupage.dart';
import 'package:my_app/widgets/appbar_widget.dart';

class ChatMessagesOne extends StatelessWidget {
  const ChatMessagesOne({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Chat 1",
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          useMaterial3: true),
      home: const ChatMessagesOneWidget(),
    );
  }
}

class ChatMessagesOneWidget extends StatelessWidget {
  const ChatMessagesOneWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildChatOneAppBar(context),
      backgroundColor: const Color.fromARGB(255, 232, 232, 232),
      body: Column(children: [
        const Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Center(
              child: Text(
            "4h ago",
            style: TextStyle(
                fontSize: 15.0, color: Colors.grey, fontFamily: 'Helvetica'),
          )),
        ),
        Align(
            alignment: Alignment.topLeft,
            child: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 10.0),
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 300),
                  decoration: const ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                              bottomRight: Radius.circular(16)))),
                  child: const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      "Hey!! A few days ago you posted a post about how to make a wine rack out of a skateboard?",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Helvetica'),
                      maxLines: 3,
                    ),
                  ),
                ))),
        Align(
            alignment: Alignment.topLeft,
            child: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 10.0),
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 300),
                  decoration: const ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                              bottomRight: Radius.circular(16)))),
                  child: const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      "so cool!",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Helvetica'),
                      maxLines: 3,
                    ),
                  ),
                ))),
        Align(
            alignment: Alignment.topRight,
            child: Padding(
                padding: const EdgeInsets.only(right: 8.0, top: 10.0),
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 300),
                  decoration: const ShapeDecoration(
                      color: Color(0xFF269A66),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                              bottomLeft: Radius.circular(16)))),
                  child: const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      "Yeah! It was me! I love that you like the idea, if you have any questions about how I did it don't be shy, ask! ;)",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Helvetica'),
                      maxLines: 3,
                    ),
                  ),
                )))
      ]),
    );
  }
}
