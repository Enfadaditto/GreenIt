import 'package:flutter/material.dart';
import 'package:my_app/Models/Comment.dart';
import 'package:my_app/Persistance/RepoUser.dart';
import 'package:my_app/pages/profile_page.dart';

class CommentsWidget extends StatelessWidget {
  List<Comment>? comments;
  final Function(Comment comment) onReply;

  CommentsWidget({required this.comments, required this.onReply});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: comments?.length,
      itemBuilder: (context, index) {
        Comment comment = comments![index];

        List<Widget> commentWidgets = [
          ListTile(
            leading: ClipOval(
                child: RawMaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProfilePage(data: '${comment.author}', type: "name"),
                  ),
                );
              },
              shape: CircleBorder(),
              child: Material(
                  color: Colors.transparent,
                  child: FutureBuilder(
                    future: RepoUser().readName("${comment.author}"),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      return Ink.image(
                        image: NetworkImage(snapshot.data!.image),
                        fit: BoxFit.cover,
                        width: 40,
                        height: 40,
                      );
                    },
                  )),
            )),
            title: Row(
              children: [
                Text(
                  '${comment.author}',
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(width: 10),
                Text(
                  "• 22h ago.", //¿?¿¿?¿?¿?¿?
                  style: TextStyle(fontSize: 12, color: Colors.black38),
                ),
              ],
            ),
            subtitle: Text(comment.comment),
            trailing: IconButton(
              icon: Icon(Icons.reply),
              onPressed: () => onReply(comment),
            ),
          ),
        ];

        if (comment.replies.isNotEmpty) {
          commentWidgets.add(ExpansionTile(
            title: Text('View Replies'),
            children: comment.replies
                .map((reply) => ListTile(
                      title: Text('By ${reply.author}'),
                      subtitle: Text(reply.comment),
                    ))
                .toList(),
          ));
        }

        return Card(
            child: Container(
          color: Color(0xFFCFF4D2),
          child: Column(
            children: commentWidgets,
          ),
        ));
      },
    );
  }
}
