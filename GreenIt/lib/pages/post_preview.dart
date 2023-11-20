import 'package:flutter/material.dart';
import 'package:my_app/Models/Post.dart';
import 'package:my_app/Models/User.dart';
import 'package:my_app/Persistance/RepoPost.dart';
import 'package:my_app/Persistance/RepoStep.dart';
import 'package:my_app/pages/post_page.dart';
import 'package:my_app/Models/Step.dart' as mod;
import 'package:my_app/pages/users_list.dart';
import 'package:my_app/utils/notuser_preferences.dart';

class PostPreview extends StatefulWidget {
  PostPreview({required this.steps});

  List<mod.Step> steps;

  @override
  State<StatefulWidget> createState() => _PostPreviewState();
}

class _PostPreviewState extends State<PostPreview> {
  void _uSure(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Create new Post"),
            actions: <Widget>[
              ElevatedButton(onPressed: _publishPost, child: Text("OK")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel"))
            ],
          );
        });
  }

  void _publishPost() {
    RepoPost repoPost = RepoPost();
    repoPost.create(Post(
        firstStep: widget.steps.first,
        id: 123456789,
        originalPoster: null,
        serverName: "serverName"));

    RepoStep repoStep = RepoStep();
    for (int i = 0; i < widget.steps.length; i++) {
      repoStep.create(widget.steps[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.steps[0].image);

    return Container(
        child: Column(children: [
      SizedBox(height: 150),
      Container(
          height: 400,
          child: PageView(
            scrollDirection: Axis.horizontal,
            children: List.generate(
              widget.steps.length,
              (index) => StepCard(
                  widget.steps[index].description, widget.steps[index].image!),
            ),
          )),
      SizedBox(height: 100),
      ElevatedButton(
          onPressed: () => {_uSure(context)}, child: const Text("PUBLISH"))
    ]));
  }
}
