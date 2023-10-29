import 'package:my_app/Models/Post.dart';
import 'package:my_app/Models/Step.dart';
import 'package:my_app/Models/user.dart';
import 'package:my_app/Persistance/IGenericRepository.dart';
import 'package:my_app/Persistance/IRepoPost.dart';
import 'package:my_app/Persistance/ServerConnect.dart';

class RepoPost implements IRepoPost {
  ServerConnect server = ServerConnect();

  @override
  void create(Post t) {
    try {
      server.insertData("http://13.49.72.206/publish?username" +
          /*(t.originalPoster.displayName)*/ "placeholderUsername" +
          "&description=" +
          "placeholderDescription" +
          "&image=" +
          "placeholderImage");
    } catch (e) {
      print("An error occurred: $e");
    }
  }

  //uses username (id). not ideal but good enough for now.
  @override
  Future<Post> read(String id) async {
    Post p;
    try {
      var data =
          await server.fetchData("http://13.49.72.206/post?username=" + id);
      print(data[0]['firstStep']['description']);
      p = Post(
          originalPoster: jsonToUser(data[0]['creator']),
          firstStep: /* jsonToStep(data[0]['firstStep']) */ null,
          id: data[0]['id'].toString(),
          serverName: data[0]['serverName']);
    } catch (e) {
      print("An error occurred: $e");
      p = Post(
          originalPoster: null,
          firstStep: null,
          id: 'id',
          serverName: "serverName");
    }
    return p;
  }

  @override
  void update(Post t) {
    // TODO: implement update
  }

  void delete(Post t) {
    // TODO: implement delete
  }

  User jsonToUser(Map<String, dynamic> datad) {
    return User(
        displayName: datad['displayName'],
        email: datad['email'],
        password: datad['password'],
        serverName: datad['serverName']);
  }

  Step jsonToStep(Map<String, dynamic> datad) {
    return Step(
        id: datad['id'] as String,
        previousStep: datad['previousStep'],
        description: datad['description'],
        image: datad['image']);
  }
}