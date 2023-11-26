import 'package:my_app/Models/Comment.dart';
import 'package:my_app/Models/Post.dart';
import 'package:my_app/Models/User.dart';
import 'package:my_app/Persistance/IGenericRepository.dart';
import 'package:my_app/Persistance/IRepoComment.dart';
import 'package:my_app/Persistance/ServerConnect.dart';

class RepoComment implements IRepoComment {
  ServerConnect server = ServerConnect();

  @override
  void create(Comment t) {
    try {
      server.insertData(
          "http://16.170.159.93/comment?prevCommentId=${t.responseTo?.id}" +
              "&text=${t.comment}" +
              "&postid=${t.postId}" +
              "&creatorName=${t.author}");
    } catch (e) {
      print("An error occurred: $e");
    }
  }

  @override
  Future<Comment> read(String id) {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  void update(Comment t) {
    // TODO: implement update
  }

  void delete(Comment t) {
    // TODO: implement delete
  }

  Future<List<Comment>> getAllCommentsPost(int postId) async {
    List<Comment> comments = [];
    //
    try {
      var response = await server.fetchData(
          "http://16.170.159.93/getComments?postid=$postId"); //AQUI MUERE LA EJECUCION

      print(
          "//////////////////////////////////////////////////////////////////////////////////////////////////////////");
      print("EJECUTA HASTA AQUI");
      print(
          "//////////////////////////////////////////////////////////////////////////////////////////////////////////");

      List<dynamic> list = response as List;
      comments = list.map((map) {
        // Ensure that each element in the list is actually a Map.
        if (map is Map<String, dynamic>) {
          var p = Comment.fromJson(map);
          p.setAuthor(jsonToUser(map['creator']).displayName);
          p.setReplies(getReplies(p) as List<Comment>);
          return p;
        } else {
          throw Exception(
              'Expected each element in list to be a Map<String, dynamic>');
        }
      }).toList();
    } catch (e) {
      print('Error fetching comments: $e');
    }
    //
    return comments;
  }

  Future<List<Comment>> getReplies(Comment comment) async {
    List<Comment> replies = [];

    try {
      var response = await server
          .fetchData("http://16.170.159.93/getReplies?previd=${comment.id}");

      List<dynamic> list = response as List;
      replies = list.map((map) {
        // Ensure that each element in the list is actually a Map.
        if (map is Map<String, dynamic>) {
          var p = Comment.fromJson(map);
          p.setAuthor(jsonToUser(map['creator']).displayName);
          return p;
        } else {
          throw Exception(
              'Expected each element in list to be a Map<String, dynamic>');
        }
      }).toList();
    } catch (e) {
      print('Error fetching comments: $e');
    }

    return replies;
  }

  User jsonToUser(Map<String, dynamic> datad) {
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
