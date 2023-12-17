import 'package:flutter/material.dart';
import 'package:my_app/Persistance/IRepoUser.dart';

class FollowButton extends StatefulWidget {
  final IRepoUser repoUser;
  final int follower;
  final int following;
  final bool alreadyFollowed;

  const FollowButton({
    Key? key,
    required this.repoUser,
    required this.follower,
    required this.following,
    required this.alreadyFollowed,
  }) : super(key: key);

  @override
  _FollowButtonState createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  late bool isFollowed;

  @override
  void initState() {
    super.initState();
    isFollowed = widget.alreadyFollowed;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isFollowed ? Colors.red[100] : Colors.green,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(20), // Adjust the radius as needed
        ),
      ),
      onPressed: () async {
        try {
          if (isFollowed) {
            await widget.repoUser.unfollow(widget.follower, widget.following);
            print('User unfollowed successfully');
          } else {
            await widget.repoUser.follow(widget.follower, widget.following);
            print('User followed successfully');
          }

          // Toggle the follow status
          setState(() {
            isFollowed = !isFollowed;
          });
        } catch (e) {
          if (isFollowed) {
            print('Error unfollowing user: $e');
          } else {
            print('Error following user: $e');
          }
          // Handle the error, show a message, or take any other appropriate action
        }
      },
      child: Text(isFollowed ? 'Unfollow' : 'Follow'),
    );
  }
}
