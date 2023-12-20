import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_app/widgets/appbar_chat_one.dart';
import 'package:my_app/widgets/appbar_chat_two.dart';
import 'package:my_app/widgets/appbar_foryoupage.dart';
import 'package:my_app/widgets/appbar_widget.dart';

class ChatMessagesTwo extends StatelessWidget {
  const ChatMessagesTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Chat 2",
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          useMaterial3: true),
      home: const ChatMessagesTwoWidget(),
    );
  }
}

class ChatMessagesTwoWidget extends StatelessWidget {
  const ChatMessagesTwoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildChatTwoAppBar(context),
      backgroundColor: const Color.fromARGB(255, 232, 232, 232),
      body: Column(children: [
        const Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Center(
              child: Text(
            "1d ago",
            style: TextStyle(
                fontSize: 15.0, color: Colors.grey, fontFamily: 'Helvetica'),
          )),
        ),
        Align(
            alignment: Alignment.topLeft,
            child: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 14.0),
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
                      "Hello!! I just want to ask you some questions about your last DIY project",
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
                padding: const EdgeInsets.only(right: 8.0, top: 14.0),
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
                      "Yeah!! Of course, ask whatever you want",
                      style: TextStyle(
                          color: Colors.white,
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
