import 'package:flutter/material.dart';
import 'package:my_app/models/user.dart';
import 'package:my_app/pages/users_list.dart';

class NumbersWidget extends StatelessWidget {
  final User user;

  const NumbersWidget(this.user);

  @override
  Widget build(BuildContext context) => IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildButton(context, user.following.length, 'Following', user),
            buildDivider(),
            buildButton(context, user.followers.length, 'Followers', user),
            buildDivider(),
            buildButton(context, user.imagesList.length, 'Posts', user),
          ],
        ),
      );
}

Widget buildDivider() => Container(
      height: 24,
      child: VerticalDivider(),
    );

Widget buildButton(BuildContext context, int value, String text, User user) =>
    MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 4),
        onPressed: () {
          debugPrint(
              "Followers/Following: ${user.followers} ${user.following}");
          if (text == "Followers") {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => UsersList(users: user.followers)),
            );
          } else if (text == "Following") {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => UsersList(users: user.following)),
            );
          }
        },
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              value.toString(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 2),
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ));
