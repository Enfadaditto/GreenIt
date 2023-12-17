import 'dart:convert';

import 'package:my_app/Models/Post.dart';
import 'package:my_app/Models/Step.dart';
import 'package:my_app/Models/User.dart';
import 'package:my_app/Persistance/IGenericRepository.dart';
import 'package:my_app/Persistance/IRepoPost.dart';
import 'package:my_app/Persistance/ServerConnect.dart';
import 'package:http/http.dart' as http;

class RepoPost implements IRepoPost {
  ServerConnect server = ServerConnect();

  @override
  void create(Post t) {
    try {
      server.insertData("http://16.170.159.93/publish?username=" +
          "rizna" +
          "&description=" +
          t.description +
          "&image=" +
          t.imagenPreview);
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
          firstStep: jsonToStep(data[0]['firstStep']),
          id: data[0]['id'],
          serverName: data[0]['serverName'],
          title: data[0]['title'],
          description: data[0]['description'],
          imagenPreview: data[0]['image']);
    } catch (e) {
      print("An error occurred: $e");
      p = Post(
          originalPoster: null,
          firstStep: null,
          id: 0,
          serverName: "serverName",
          title: "title",
          description: "description",
          imagenPreview: "image");
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

  Future<List<Step?>> getListSteps(String id) async {
    List<Step?> steps = [];
    try {
      var fetchedPost =
          await server.fetchData("http://16.170.159.93/postById?id=$id");
      Post p = Post(
          originalPoster: jsonToUser(fetchedPost['creator']),
          firstStep: jsonToStep(fetchedPost['firstStep']),
          id: fetchedPost['id'],
          serverName: fetchedPost['serverName'],
          title: fetchedPost['title'],
          description: fetchedPost['description'],
          imagenPreview: fetchedPost['image']);
      steps.add(p.firstStep);

      var data = await server.fetchData(
          "http://16.170.159.93/prevstep?previd=${p.getFirstStep()!.id.toString()}");
      while (data.isNotEmpty) {
        Step? s = Step(
            id: data[0]['id'],
            previousStep: jsonToStep(data[0]['previousStep']),
            description: data[0]['description'],
            image: data[0]['image']);
        steps.add(s);
        data = await server.fetchData(
            "http://16.170.159.93/prevstep?previd=${s.id.toString()}");
      }

      print(steps.length);
      return steps;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  Step jsonToStep(Map<String, dynamic> datad) {
    return Step(
        id: datad['id'],
        previousStep: jsonToStep2(datad['previousStep']),
        description: datad['description'],
        image: datad['image']);
  }

  Step? jsonToStep2(Map<String, dynamic>? datad) {
    if (datad == null) {
      return null;
    }
    return Step(
        id: datad['id'],
        previousStep: jsonToStep2(datad?['previousStep']),
        description: datad?['description'],
        image: datad['image']);
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

  Future<int?> getNumLikes(String id) async {
    Future.delayed(const Duration(milliseconds: 2000));
    final response = await http
        .get(Uri.parse("http://16.170.159.93/howmanylikes?postid=$id"));
    return int.parse(response.body);
  }

  Future<String> postIsLiked(String id) async {
    Future.delayed(const Duration(milliseconds: 2000));
    final response = await http.get(Uri.parse(
        "http://16.170.159.93/ispostalreadyliked?postid=$id&username=jrber23"));
    return response.body;
  }

  Future<bool?> onLikeButtonTapped(
      bool isLiked, String username, String postId) async {
    Future.delayed(const Duration(milliseconds: 2000));
    server.insertData(
        "http://16.170.159.93/like?username=$username&postid=$postId");
    return !isLiked;
  }

  Future<bool?> onUnlikeButtonTapped(
      bool isLiked, String username, String postId) async {
    Future.delayed(const Duration(milliseconds: 2000));
    server.insertData(
        "http://16.170.159.93/unlike?username=$username&postid=$postId");
    return !isLiked;

  // http://16.170.159.93/postSavedByUser?username=jrber23
  Future<List<Post>> getAllLikedPosts(String displayName) async {
    List<Post> posts = [];
    try {
      var response = await server.fetchData(
          "http://16.170.159.93/postSavedByUser?username=" + displayName);

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
      print('Error fetching liked posts: $e');
    }
    return posts;
  }
}
