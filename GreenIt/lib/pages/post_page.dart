import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_app/Persistance/RepoPost.dart';
import 'package:my_app/pages/stepper.dart';
import 'package:my_app/widgets/appbar_widget.dart';
import 'package:my_app/Models/Step.dart' as MyStep;
import 'package:my_app/Models/Comment.dart';
import 'package:my_app/Models/User.dart';
import 'package:my_app/Persistance/RepoComment.dart';
import 'package:my_app/Persistance/RepoUser.dart';
import 'package:my_app/pages/for_you_page.dart';
import 'package:my_app/utils/notuser_preferences.dart';
import 'package:my_app/pages/stepper.dart';
import 'package:my_app/widgets/appbar_widget.dart';
import 'package:my_app/widgets/comment_widget.dart';

class PostPage extends StatefulWidget {
  int currentIndex;
  String id;
  final String author;
  final String title;
  List<Comment> comments;
  final int postId;
  //final List<String> steps; //Steps
  List<MyStep.Step?> steps = [];

  PostPage({
    super.key,
    required this.author,
    required this.postId,
    required this.title,
    required this.id,
    required this.comments,
    /*required this.steps*/
    required this.currentIndex,
  });

  @override
  State<StatefulWidget> createState() => PostDetailed();
}

class PostDetailed extends State<PostPage> {
  String placeholderIMG =
      'https://img.freepik.com/vector-gratis/ilustracion-icono-dibujos-animados-fruta-manzana-concepto-icono-fruta-alimentos-aislado-estilo-dibujos-animados-plana_138676-2922.jpg?w=2000';
  //final List<String> steps;
  final _commentController = TextEditingController();
  late Future<List<Comment>> commentList =
      RepoComment().getAllCommentsPost(widget.postId);

  //PostDetailed({required this.steps});

  void fetchSteps() async {
    widget.steps = await RepoPost().getListSteps(widget.id);
  }

  @override
  void initState() {
    super.initState();
    fetchSteps();
  }

  @override
  Widget build(BuildContext context) {
    void onTabTapped(int index) {
      setState(() {
        widget.currentIndex = index;
      });
    }

    void _respondComment(Comment respondedComment) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Text your response'),
              content: TextField(
                controller: _commentController,
              ),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Comment answerToComment = Comment(
                        id: -1,
                        postId: widget.postId,
                        comment: _commentController.text,
                        author: UserPreferences.myUser.name,
                        responseTo: respondedComment,
                        replies: []);

                    setState(() {
                      respondedComment.replies.add(answerToComment);
                    });

                    _commentController.clear();
                    Navigator.of(context).pop();
                    RepoComment().create(answerToComment);
                  },
                ),
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    }

    return MaterialApp(
        home: Scaffold(
      appBar: buildAppBar(context),
      body: Container(
          // width: double.infinity,
          height: double.infinity,
          child: Stack(children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                      child: Center(
                    child: Container(
                      child: MyStepper(steps: widget.steps),
                    ),
                  )),
                  //const SizedBox(height: 25),
                  SizedBox(
                    height: 500,
                    child: PageView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        //steps.forEach((step) {
                        //  StepCard(step.description, step.image);
                        //})

                        PageView.builder(
                          itemCount: widget.steps.length,
                          itemBuilder: (context, index) {
                            return StepCard(
                                widget.steps[index]!.getDescription(),
                                widget.steps[index]!.getImage());
                          },
                        )
                      ],
                    ),
                  )
                ]),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  child: Container(
                      decoration: ShapeDecoration(
                        color: Color(0xFFCFF4D2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30))),
                      ),
                      child: FutureBuilder(
                          future:
                              RepoComment().getAllCommentsPost(widget.postId),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ExpansionTile(
                                title: Row(
                                  children: [
                                    Text("Comments",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Helvetica')),
                                    SizedBox(width: 10),
                                    Text("${snapshot.data!.length}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xFF686868))),
                                  ],
                                ),
                                children: [
                                  Container(
                                    width: 350,
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 1,
                                          strokeAlign:
                                              BorderSide.strokeAlignCenter,
                                          color: Color(0xFF6E6E6E),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                      constraints:
                                          BoxConstraints(maxHeight: 300),
                                      child: Scaffold(
                                        backgroundColor: Color(0xFFCFF4D2),
                                        body: CommentsWidget(
                                          comments: snapshot.data,
                                          onReply: _respondComment,
                                        ),
                                      )),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 7.5),
                                    child: TextFormField(
                                      controller: _commentController,
                                      decoration: InputDecoration(
                                          hintText: "Write new comment...",
                                          suffixIcon: IconButton(
                                            icon: Icon(Icons.send),
                                            onPressed: () {
                                              setState(() {
                                                if (_commentController
                                                    .text.isEmpty) return;

                                                Comment newComment = Comment(
                                                    id: -1,
                                                    responseTo: Comment(
                                                        id: 0,
                                                        comment: "",
                                                        author: "",
                                                        replies: []),
                                                    postId: widget.postId,
                                                    comment:
                                                        _commentController.text,
                                                    author: UserPreferences
                                                        .myUser.name,
                                                    replies: []);
                                                widget.comments.add(newComment);
                                                RepoComment()
                                                    .create(newComment);
                                                _commentController.clear();
                                              });
                                            },
                                          )),
                                    ),
                                  )
                                ],
                                onExpansionChanged: (bool) {
                                  setState(() {});
                                },
                              );
                            } else if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else {
                              return Text("ERROR");
                            }
                          })),
                ),
              ],
            )
          ])),
      backgroundColor: Colors.grey[900],
    ));
  }
}

/* class PostDetailed extends StatelessWidget {
  String placeholderIMG =
      'https://img.freepik.com/vector-gratis/ilustracion-icono-dibujos-animados-fruta-manzana-concepto-icono-fruta-alimentos-aislado-estilo-dibujos-animados-plana_138676-2922.jpg?w=2000';
  List<MyStep.Step?> steps = [];
  String id;

  PostDetailed({required this.id});

  Future<void> fetchSteps() async {
    steps = await RepoPost().getListSteps(id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchSteps(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: const CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text("Ha habido un error");
        } else {
          return Container(
      // width: double.infinity,
      height: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
              child: Center(
            child: Container(
              child: MyStepper(steps: steps),
            ),
          )),
          //const SizedBox(height: 25),
          SizedBox(
            height: 500,
            child: /* PageView(
              scrollDirection: Axis.horizontal,
              children: [
                /* steps.forEach((step) {
                  StepCard(step!.description, step.image);
                }) */

                StepCard(steps[0]!.getDescription(), steps[0]!.getImage()),
                StepCard('Description Blue', placeholderIMG),
                StepCard('Description Green', placeholderIMG),
              ],
            ), */
            PageView.builder(
              itemCount: steps.length,
              itemBuilder: (context, index) {
                return StepCard(steps[index]!.getDescription(), steps[index]!.getImage());
              },
            )
          )
        ],
      ),
    );
        }
      },
    );
    
  }
} */

class StepCard extends StatelessWidget {
  String text;
  String? imagen;

  StepCard(this.text, this.imagen, {super.key});

  @override
  Widget build(BuildContext context) {
    //TODO: once we can extract images from the server, we need to investigate how to display them here
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          height: 500,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  text,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              /* imagen ==
                      'https://img.freepik.com/vector-gratis/ilustracion-icono-dibujos-animados-fruta-manzana-concepto-icono-fruta-alimentos-aislado-estilo-dibujos-animados-plana_138676-2922.jpg?w=2000'
                  ? Image(image: NetworkImage(imagen!))
                  : Image.file(File(imagen!)) */
              Image.network(imagen!)
            ],
          ),
        ),
      ],
    );
  }
}
