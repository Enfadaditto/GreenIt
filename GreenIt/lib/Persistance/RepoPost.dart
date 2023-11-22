import 'package:my_app/Models/Post.dart';
import 'package:my_app/Models/Step.dart';
import 'package:my_app/Models/User.dart';
import 'package:my_app/Persistance/IGenericRepository.dart';
import 'package:my_app/Persistance/IRepoPost.dart';
import 'package:my_app/Persistance/ServerConnect.dart';

class RepoPost implements IRepoPost {
  ServerConnect server = ServerConnect();

  @override
  void create(Post t) {
    try {
      server.insertData("http://16.170.159.93/publish?username" +
          /*(t.originalPoster.displayName)*/ "placeholderUsername" +
          "&description=" +
          "placeholderDescription" +
          "&image=" +
          "placeholderImage");
    } catch (e) {
      print("An error occurred: $e");
    }
  }

  //gets all post from userId
  @override
  Future<Post> read(String id) async {
    Post p;
    try {
      var data =
          await server.fetchData("http://16.170.159.93/post?username=" + id);
      p = Post(
          originalPoster: jsonToUser(data[0]['creator']),
          firstStep: /* jsonToStep(data[0]['firstStep']) */ null,
          id: data[0]['id'],
          serverName: data[0]['serverName'],
          description: data[0]['description']);
    } catch (e) {
      print("An error occurred: $e");
      p = Post(
          originalPoster: null,
          firstStep: null,
          id: 0,
          serverName: "serverName",
          description: "description");
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
        id: datad['id'],
        displayName: datad['displayName'],
        email: datad['email'],
        password: datad['password'],
        serverName: datad['serverName'],
        description: datad['description'],
        image: datad['image'],
        imagefield: '');
  }

  Step jsonToStep(Map<String, dynamic> datad) {
    return Step(
        id: datad['id'],
        previousStep: jsonToStep2(datad['previousStep']),
        description: datad['description'],
        image: datad['image']);
  }

  Step? jsonToStep2(Map<String, dynamic>? datad) {
    if(datad == null){return null;}
    return Step(
        id: datad?['id'],
        previousStep: jsonToStep2(datad?['previousStep']),
        description: datad?['description'],
        image: datad?['image']);
  }

  Future<List<Post>> getAllPostsUser(String displayName) async {
    List<Post> posts = [];
    try {
      var response = await server
          .fetchData("http://16.170.159.93/post?username=" + displayName);

      List<dynamic> list = response as List;
      posts = list.map((map) {
        // Ensure that each element in the list is actually a Map.
        if (map is Map<String, dynamic>) {
          var p = Post.fromJson(map);
          p.setOriginalPoster(jsonToUser(map['creator']));
          //if(map['firstStep'][0]==null){}
          p.setFirstStep(jsonToStep2(map['firstStep']));
          return p;
        } else {
          throw Exception(
              'Expected each element in list to be a Map<String, dynamic>');
        }
      }).toList();
    } catch (e) {
      print('Error fetching posts: $e');
    }
    return posts;
  }
}
