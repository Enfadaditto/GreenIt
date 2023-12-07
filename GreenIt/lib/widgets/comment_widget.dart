import 'package:flutter/material.dart';
import 'package:my_app/Models/Comment.dart';

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
            title: Text(
              '${comment.author}',
              style: TextStyle(color: Colors.black),
            ),
            subtitle: Text(comment.comment),
            trailing: IconButton(
              icon: Icon(Icons.reply),
              onPressed: () => onReply(comment),
            ),
          ),
        ];

        if (comment.replies.isNotEmpty) {
          // Add replies as children of the ExpansionTile if they exist
          commentWidgets.add(ExpansionTile(
            title: Text('View Replies'),
            children: comment.replies
                .map((reply) => ListTile(
                      title: Text(reply.comment),
                      subtitle: Text('By ${reply.author}'),
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
