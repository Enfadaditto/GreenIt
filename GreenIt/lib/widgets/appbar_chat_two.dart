import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/utils/cache_manager.dart';

AppBar buildChatTwoAppBar(BuildContext context) {
  return AppBar(
    leading: BackButton(
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    backgroundColor: Colors.white,
    elevation: 0,
    title: const Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(4.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                "https://static.vecteezy.com/system/resources/previews/022/448/291/non_2x/save-earth-day-poster-environment-day-nature-green-ai-generative-glossy-background-images-tree-and-water-free-photo.jpg"),
            radius: 20.0,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 2.0, left: 10.0),
                  child: Text(
                    "CrazyNature",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0, left: 10.0),
                  child: Text(
                    "@crazynature",
                    style: TextStyle(fontSize: 12.0, color: Colors.grey),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.0, left: 10.0),
              child: Text(
                textAlign: TextAlign.start,
                "Active 1d ago",
                style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w400, color: Colors.grey),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
