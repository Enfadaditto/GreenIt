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
      backgroundColor: const Color.fromARGB(255, 234, 221, 219),
      body: Column(children: [
        const Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Center(
              child: Text(
            "1d ago",
            style: TextStyle(fontSize: 15.0, color: Colors.grey),
          )),
        ),
        Align(
            alignment: Alignment.topLeft,
            child: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 14.0),
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 300),
                  child: const Card(
                    elevation: 0,
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        "Hello!! I just want to ask you some questions about your last DIY project",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
                        maxLines: 3,
                      ),
                    ),
                  ),
                ))),
        Align(
            alignment: Alignment.topRight,
            child: Padding(
                padding: const EdgeInsets.only(right: 8.0, top: 14.0),
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 300),
                  child: const Card(
                    elevation: 0,
                    color: Color.fromARGB(255, 16, 158, 100),
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        "Yeah!! Of course, ask whatever you want",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                        maxLines: 3,
                      ),
                    ),
                  ),
                )))
      ]),
    );
  }
}
