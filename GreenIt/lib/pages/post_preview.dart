import 'package:flutter/material.dart';
import 'package:my_app/Models/Post.dart';
import 'package:my_app/Models/User.dart';
import 'package:my_app/Persistance/RepoPost.dart';
import 'package:my_app/Persistance/RepoStep.dart';
import 'package:my_app/Persistance/RepoUser.dart';
import 'package:my_app/pages/post_page.dart';
import 'package:my_app/Models/Step.dart' as mod;
import 'package:my_app/pages/users_list.dart';
import 'package:my_app/utils/notuser_preferences.dart';

class PostPreview extends StatefulWidget {
  PostPreview({required this.steps, required this.postDescription});

  late User registeredUser;

  void getUser() async {
    registeredUser = await RepoUser().read("rizna");
  }

  List<mod.Step> steps;
  String postDescription;

  @override
  State<StatefulWidget> createState() => _PostPreviewState();
}

class _PostPreviewState extends State<PostPreview> {
  void _uSure(BuildContext context) {
    widget.getUser();

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
    RepoStep repoStep = RepoStep();

    Post postDummy = Post(
        firstStep: null,
        id: -1,
        description: widget.postDescription,
        originalPoster: widget.registeredUser,
        serverName: "",
        imagenPreview: ""
    );

    postDummy.setFirstStep(widget.steps.first);

    repoPost.create(postDummy);
    repoStep.create(widget.steps[0]);

    for (int i = 1; i < widget.steps.length; i++) {
      mod.Step stepDummy = widget.steps[i];
      stepDummy.setPreviousStep(widget.steps[i - 1]);
      stepDummy.setPostId(postDummy.id);
      repoStep.create(stepDummy);
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
