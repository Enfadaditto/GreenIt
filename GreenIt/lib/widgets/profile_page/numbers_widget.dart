import 'package:flutter/material.dart';
import 'package:my_app/Models/ReducedUser.dart';
import 'package:my_app/Models/User.dart';
import 'package:my_app/Persistance/IRepoUser.dart';
import 'package:my_app/pages/users_list.dart';

class NumbersWidget extends StatelessWidget {
  final Future<User?> user;
  final int followers;
  final int followed;
  final IRepoUser repoUser;
  final int numberPosts;
  final VoidCallback onFollowersChanged;

  const NumbersWidget(this.user, this.followers, this.followed, this.repoUser,
      this.numberPosts, this.onFollowersChanged);

  @override
  Widget build(BuildContext context) => IntrinsicHeight(
        child: FutureBuilder<User?>(
          future: user,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final user = snapshot.data!;
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  buildButton(context, followers, 'Followers', user, repoUser),
                  buildDivider(),
                  buildButton(context, followed, 'Followed', user, repoUser),
                  buildDivider(),
                  buildButton(context, numberPosts, 'Posts', user, repoUser),
                ],
              );
            }
          },
        ),
      );

  Widget buildDivider() => Container(
        height: 24,
        child: const VerticalDivider(),
      );

  Widget buildButton(BuildContext context, int value, String text, User user,
          IRepoUser repoUser) =>
      MaterialButton(
          padding: const EdgeInsets.symmetric(vertical: 4),
          onPressed: () {
            if (text == "Followers") {
              _getListAndNavigate(context, user.id, "Followers", repoUser);
            } else if (text == "Followed") {
              _getListAndNavigate(context, user.id, "Followed", repoUser);
            }
          },
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                value.toString(),
                style:
                    const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
              ),
              const SizedBox(height: 2),
              Text(
                text,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
              ),
            ],
          ));

  Future<void> _getListAndNavigate(
      BuildContext context, int userId, String type, IRepoUser repoUser) async {
    try {
      List<ReducedUser> users;
      if (type == "Followers") {
        users = await repoUser.getFollowers(userId);
      } else if (type == "Followed") {
        users = await repoUser.getFollowed(userId);
      } else {
        // Handle other types if needed
        return;
      }
      Navigator.of(context)
          .push(
            MaterialPageRoute(
              builder: (context) => UsersList(users: users),
            ),
          )
          .then((value) => onFollowersChanged());
    } catch (e) {
      print('Error fetching users list: $e');
      // Handle the error, show a message, or take any other appropriate action
    }
  }
}
