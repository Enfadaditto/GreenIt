import 'package:my_app/Models/User.dart';

class Comment {
  int id;
  int? postId;
  String comment;
  Comment? responseTo;
  String? author; //User author - Set to String to do testing
  List<Comment> replies;

  Comment(
      {required this.id,
      this.postId,
      required this.comment,
      this.responseTo,
      required this.author,
      required this.replies});

  String getCommentText() {
    return this.comment;
  }

  void setAuthor(String author) {
    this.author = author;
  }

  String getAuthorUsername() {
    return this.author ?? "uknown";
  }

  void setReplies(Future<List<Comment>> replies) async {
    this.replies = await replies;
  }

  factory Comment.fromJson(Map<String, dynamic> datad) {
    return Comment(
        id: datad['id'], comment: datad['text'], author: null, replies: []);
  }

  static Comment cosa(Map<String, dynamic> data) {
    var p = Comment.fromJson(data);
    p.setAuthor(jsonToUser(data['creator']).displayName);
    return p;
  }

  static User jsonToUser(Map<String, dynamic> datad) {
    return User(
        id: datad['id'],
        displayName: datad['displayName'],
        email: datad['email'],
        password: datad['password'],
        serverName: datad['serverName'],
        description: datad['description'],
        image: datad['image'],
        imagefield: '');
  }
}
