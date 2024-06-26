import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_app/Models/ReducedUser.dart';
import 'package:my_app/Models/User.dart';
import 'package:my_app/Persistance/IGenericRepository.dart';
import 'package:my_app/Persistance/IRepoUser.dart';
import 'package:my_app/Persistance/ServerConnect.dart';

class RepoUser implements IRepoUser {
  ServerConnect server = ServerConnect();

  @override
  Future<bool> create(User t) async {
    // http://16.170.159.93/register?email=x@gmail.com&password=Password&username=register2
    // &image=https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Default_pfp.svg/240px-Default_pfp.svg.png
    // &description=Hey
    try {
      server.insertData("http://16.170.159.93/register?email=" +
          t.email +
          "&password=" +
          t.password +
          "&username=" +
          t.displayName +
          "&image=" +
          t.getImage +
          "&description=" +
          t.description);
      print("http://16.170.159.93/register?email=" +
          t.email +
          "&password=" +
          t.password +
          "&username=" +
          t.displayName +
          "&image=" +
          t.getImage +
          "&description=" +
          t.description);
      return true;
    } catch (e) {
      print("An error occurred: $e");
      return false;
    }
  }

  @override
  Future<User> read(String email) async {
    User u;
    try {
      var data =
          await server.fetchData("http://16.170.159.93/user?email=" + email);
      u = User(
          id: data['id'],
          displayName: data['displayName'],
          email: data['email'],
          password: data['password'],
          serverName: data['serverName'],
          description: data['description'],
          image: data['image'],
          imagefield: '');
    } catch (e) {
      print("An error occurred: $e");
      u = User(
          displayName: "displayName",
          email: email,
          password: "password",
          serverName: "serverName",
          imagefield: '',
          description: '',
          id: 69696969,
          image: '');
    }

    return u;
  }

  @override
  Future<User> readName(String name) async {
    User u;
    try {
      var data = await server
          .fetchData("http://16.170.159.93/getUserByName?username=" + name);
      u = User(
          id: data['id'],
          displayName: data['displayName'],
          email: data['email'],
          password: data['password'],
          serverName: data['serverName'],
          description: data['description'],
          image: data['image'],
          imagefield: '');
    } catch (e) {
      print("An error occurred: $e");
      u = User(
          displayName: name,
          email: "email",
          password: "password",
          serverName: "serverName",
          imagefield: '',
          description: '',
          id: 6969696969,
          image: '');
    }

    return u;
  }

  @override
  void update(User t) {
    try {
      //http://16.170.159.93/updateUser?id=6&email=rizna@gmail.com&password=yourPassword&username=rizna&image=imageURL&description=adre
      server.insertData("http://16.170.159.93/updateUser?id=" +
          t.getId.toString() +
          "&email=" +
          t.email +
          "&password=" +
          t.password +
          "&username=" +
          t.displayName +
          "&image=" +
          t.getImage +
          "&description=" +
          t.getDescription);
    } catch (e) {
      print("$e - Error updating user");
    }
  }

  void delete(User t) {
    // TODO: implement delete
  }

  //returns followers of userId
  Future<List<ReducedUser>> getFollowers(int userId) async {
    List<ReducedUser> followers = [];
    try {
      var response = await server.fetchData(
          "http://16.170.159.93/followersUser?userId=" + userId.toString());

      List<dynamic> list = response as List;

      // Map each element in the list to a ReducedUser using the fromJson constructor.
      followers = list.map((map) {
        // Ensure that each element in the list is actually a Map.
        if (map is Map<String, dynamic>) {
          return ReducedUser.fromJson(map);
        } else {
          throw Exception(
              'Expected each element in list to be a Map<String, dynamic>');
        }
      }).toList();
    } catch (e) {
      print('Error fetching followers: $e');
    }

    return followers;
  }

  //returns users followed by userId
  Future<List<ReducedUser>> getFollowed(int userId) async {
    List<ReducedUser> followed = [];
    try {
      var response = await server.fetchData(
          "http://16.170.159.93/followedByUser?userId=" + userId.toString());

      List<dynamic> list = response as List;

      // Map each element in the list to a ReducedUser using the fromJson constructor.
      followed = list.map((map) {
        // Ensure that each element in the list is actually a Map.
        if (map is Map<String, dynamic>) {
          return ReducedUser.fromJson(map);
        } else {
          throw Exception(
              'Expected each element in list to be a Map<String, dynamic>');
        }
      }).toList();
    } catch (e) {
      print('Error fetching followers: $e');
    }

    return followed;
  }

  @override
  Future<void> follow(int follower, int following) async {
    try {
      server.insertData("http://16.170.159.93/addNewFollower?userId=" +
          follower.toString() +
          "&followedUserId=" +
          following.toString());
    } catch (e) {
      print("An error occured while following a user: $e");
    }
  }

  //userId= user that stops following
  @override
  Future<void> unfollow(int userId, int unfollowedUserId) async {
    try {
      var response = await server.fetchData(
          "http://16.170.159.93/unfollow?userId=" +
              userId.toString() +
              "&unfollowedUserId=" +
              unfollowedUserId.toString());

      print("OK - user unfollowed");
    } catch (e) {
      print(e.toString() + " - Operation failed");
    }
  }

  @override
  Future<int> getCountFollowers(int userId) async {
    var data = 0;

    try {
      data = await server.fetchData(
          "http://16.170.159.93/getFollowersCount?userId=" + userId.toString());
    } catch (e) {
      print(" Error - $e");
    }
    return data;
  }

  @override
  Future<int> getCountFollowed(int userId) async {
    var data = 0;

    try {
      data = await server.fetchData(
          "http://16.170.159.93/getFollowedCount?userId=" + userId.toString());
    } catch (e) {
      print(" Error - $e");
    }
    return data;
  }

  //getCountOfUserPosts
  @override
  Future<int> getCountPosts(String username) async {
    var data = 0;

    try {
      data = await server.fetchData(
          "http://16.170.159.93/getCountOfUserPosts?username=" + username);
    } catch (e) {
      print(" Error - $e");
    }
    return data;
  }

  //checks if userId follows followedId
  @override
  Future<bool> checkFollows(int userId, int followedId) async {
    bool follows = false;
    try {
      var response = await server.fetchData(
          "http://16.170.159.93/checkFollows?userId=${userId}&followedId=${followedId}");
      // Assuming the response is a String. If it's not, you need to parse it accordingly.
      if (response) {
        follows = true;
        print("Check follows: ${follows.toString()}");
      }
    } catch (e) {
      print("Error while checking followers - $e");
    }
    return follows;
  }
}
