import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/utils/cache_manager.dart';

AppBar buildChatOneAppBar(BuildContext context) {
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
                "https://upload.wikimedia.org/wikipedia/commons/4/47/Cyanocitta_cristata_blue_jay.jpg"),
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
                    "Dylan",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0, left: 10.0),
                  child: Text(
                    "@letssavetheworld",
                    style: TextStyle(fontSize: 12.0, color: Colors.grey),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.0, left: 10.0),
              child: Text(
                textAlign: TextAlign.start,
                "Active 4 hours ago",
                style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w400, color: Colors.grey),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
