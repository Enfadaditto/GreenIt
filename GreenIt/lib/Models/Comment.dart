import 'package:my_app/Models/User.dart';

class Comment {
  String comment;
  Comment? responseTo;
  String author;
  List<Comment> replies;

  Comment(
      {required this.comment,
      this.responseTo,
      required this.author,
      required this.replies});

  String getCommentText() {
    return this.comment;
  }

  String getAuthorUsername() {
    return this.author;
  }
}
