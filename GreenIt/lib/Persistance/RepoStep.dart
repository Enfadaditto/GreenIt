import 'dart:convert';
import 'dart:io';

import 'package:my_app/Models/Step.dart';
import 'package:my_app/Persistance/IGenericRepository.dart';
import 'package:my_app/Persistance/IRepoStep.dart';
import 'package:http/http.dart' as http;

import 'ServerConnect.dart';

class RepoStep implements IRepoStep {
  ServerConnect server = ServerConnect();
  String ImgBBAPIKey = "be456d9c6eba33f5b654f4ed7f1ad177";

  @override
  void create(Step t) async {
    bool isFirst = true;
    if (t.previousStep != null) {
      isFirst = false;
    }

    try {
      String imgURL = await getImgURL(t.image);

      server.insertData("http://16.170.159.93/commit?prevStepId=" +
          "${t.previousStep?.id}" +
          "&isFirst=" +
          "$isFirst" +
          "&description=" +
          t.description +
          "&postId=" +
          "${t.id}" +
          "&image=" +
          imgURL);
    } catch (e) {
      print("An error occurred: $e");
    }
  }

  @override
  Future<Step> read(String id) async {
    Step s;
    try {
      var data = await server.fetchData("http://16.170.159.93/step?id" + id);
      s = Step(
          id: data['id'],
          previousStep: data['previousStep'],
          description: data['description'],
          image: data['image']);
      return s;
    } catch (e) {
      print("An error occurred: $e");
      return Step(
          id: 6969696,
          previousStep: null,
          description: 'description',
          image: 'image');
    }
  }

  @override
  void update(Step t) {
    // TODO: implement update
  }

  void delete(Step t) {
    // TODO: implement delete
  }

  Future<String> getImgURL(String imagePreview) async {
    File imageFile = File(imagePreview);

    var request = http.MultipartRequest(
        'POST', Uri.parse('https://api.imgbb.com/1/upload?key=$ImgBBAPIKey'));

    request.files.add(await http.MultipartFile.fromPath(
      'image',
      imageFile.path,
    ));

    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        String responseData = await response.stream.bytesToString();
        var decodedResponse = json.decode(responseData);
        return decodedResponse['data']['url'];
      } else {
        print("error");
        return "";
      }
    } catch (e) {
      print("Error: $e");
      return "";
    }
  }

  Future<int?> create2(Step t) async {
    String imgURL = await getImgURL(t.image);

    bool isFirst = true;
    if (t.previousStep != null) {
      isFirst = false;
    }

    try {
      var id = await server.hectorYoQUeriaDormir(
          "http://16.170.159.93/commit?prevStepId=" +
              "${t.previousStep?.id}" +
              "&isFirst=" +
              "$isFirst" +
              "&description=" +
              t.description +
              "&postId=" +
              "${t.id}" +
              "&image=" +
              imgURL);
      return id;
    } catch (e) {
      print("An error occurred: $e");
    }
  }
}
