import 'package:my_app/Models/User.dart';

class Comment {
  String comment;
  Comment? responseTo;
  String author;

  Comment({required this.comment, this.responseTo, required this.author});

  String getCommentText() {
    return this.comment;
  }

  String getAuthorUsername() {
    return this.author;
  }
}
