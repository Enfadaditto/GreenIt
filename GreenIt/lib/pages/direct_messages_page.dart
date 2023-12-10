import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_app/pages/chat_messages_one.dart';
import 'package:my_app/pages/chat_messages_two.dart';
import 'package:my_app/widgets/appbar_foryoupage.dart';

class DirectMessagesPage extends StatelessWidget {
  const DirectMessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Chats",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const DirectMessagesWidget(),
    );
  }
}

class DirectMessagesWidget extends StatelessWidget {
  const DirectMessagesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildForYouPageAppBar(context),
        body: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://upload.wikimedia.org/wikipedia/commons/4/47/Cyanocitta_cristata_blue_jay.jpg"),
                    radius: 40.0,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ChatMessagesOne()));
                  },
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 10.0, left: 15.0),
                            child: Text(
                              "Dylan",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 13.0, left: 20.0),
                            child: Text(
                              "@letssavetheworld",
                              style:
                                  TextStyle(fontSize: 15.0, color: Colors.grey),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15.0, left: 15.0),
                        child: Text(
                          textAlign: TextAlign.start,
                          "Active 4 hours ago",
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://static.vecteezy.com/system/resources/previews/022/448/291/non_2x/save-earth-day-poster-environment-day-nature-green-ai-generative-glossy-background-images-tree-and-water-free-photo.jpg"),
                      radius: 40.0,
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ChatMessagesTwo()));
                      },
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 10.0, left: 15.0),
                                child: Text(
                                  "CrazyNature",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 13.0, left: 20.0),
                                child: Text(
                                  "@crazynature",
                                  style: TextStyle(
                                      fontSize: 15.0, color: Colors.grey),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 15.0, left: 15.0),
                            child: Text(
                              textAlign: TextAlign.start,
                              "Active 1d ago",
                              style: TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
