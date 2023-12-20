import 'dart:convert';
import 'dart:io';

import 'package:my_app/Models/Step.dart';
import 'package:my_app/Persistance/IGenericRepository.dart';
import 'package:my_app/Persistance/IRepoStep.dart';

import 'ServerConnect.dart';

class RepoStep implements IRepoStep {
  ServerConnect server = ServerConnect();

  @override
  void create(Step t) {
    bool isFirst = true;
    if (t.previousStep != null) {
      isFirst = false;
    }

    try {
      server.insertData("http://16.170.159.93/commit?prevStepId=" +
          "${t.previousStep?.id}" +
          "&isFirst=" +
          "$isFirst" +
          "&description=" +
          t.description +
          "&postId=" +
          "${t.id}" +
          "&image=" +
          encodeToBase64(t.image));
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

  String encodeToBase64(String imagenPreview) {
    final bytes = File(imagenPreview).readAsBytesSync();
    return base64Encode(bytes);
  }

  Future<int?> create2(Step t) async {
    bool isFirst = true;
    if (t.previousStep != null) {
      isFirst = false;
    }

    try {
      var id = await server.hectorYoQUeriaDormir("http://16.170.159.93/commit?prevStepId=" +
          "${t.previousStep?.id}" +
          "&isFirst=" +
          "$isFirst" +
          "&description=" +
          t.description +
          "&postId=" +
          "${t.id}" +
          "&image=" +
          encodeToBase64(t.image));
      return id;
    } catch (e) {
      print("An error occurred: $e");
    }
  }
}
