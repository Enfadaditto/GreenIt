import 'dart:io';

import 'package:flutter/material.dart';
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

  final String author;
  final String title;
  List<Comment> comments;
  final int postId;
  //final List<String> steps; //Steps

  PostPage({
    super.key,
    required this.postId,
    required this.author,
    required this.title,
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

  //PostDetailed({required this.steps});

  void getCommentList() async {
    print(widget.postId);
    print(
        "//////////////////////////////////////////////////////////////////////////");
    widget.comments = await RepoComment().getAllCommentsPost(widget.postId);
  }

  @override
  void initState() {
    super.initState();
    getCommentList();
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
      body: PostDetailed(),
      backgroundColor: Colors.grey[900],
    ));
  }
}

class PostDetailed extends StatelessWidget {
  String placeholderIMG =
      'https://img.freepik.com/vector-gratis/ilustracion-icono-dibujos-animados-fruta-manzana-concepto-icono-fruta-alimentos-aislado-estilo-dibujos-animados-plana_138676-2922.jpg?w=2000';
  //final List<String> steps;

  //PostDetailed({required this.steps});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: double.infinity,
      height: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Stack(children[
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
              child: Center(
            child: Container(
              child: MyStepper(),
            ),
          )),
          //const SizedBox(height: 25),
          SizedBox(
            height: 500,
            child: PageView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                //steps.forEach((step) {
                //  StepCard(step.description, step.image);
                //})

                StepCard('Description Red', placeholderIMG),
                StepCard('Description Blue', placeholderIMG),
                StepCard('Description Green', placeholderIMG),
              ],
            ),
          )
        ]),
        Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                color: Colors.white,
                child: ExpansionTile(
                  title: Text("Comments"),
                  children: [
                    Container(
                      constraints: BoxConstraints(maxHeight: 300),
                      child: Scaffold(
                        body: CommentsWidget(
                          comments: widget.comments,
                          onReply: _respondComment,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 7.5),
                      child: TextFormField(
                        controller: _commentController,
                        decoration: InputDecoration(
                            hintText: "Write new comment...",
                            suffixIcon: IconButton(
                              icon: Icon(Icons.send),
                              onPressed: () {
                                setState(() {
                                  if (_commentController.text.isEmpty) return;

                                  Comment newComment = Comment(
                                      id: -1,
                                      responseTo: Comment(
                                          id: 0,
                                          comment: "",
                                          author: "",
                                          replies: []),
                                      postId: widget.postId,
                                      comment: _commentController.text,
                                      author: UserPreferences.myUser.name,
                                      replies: []);
                                  widget.comments.add(newComment);
                                  RepoComment().create(newComment);
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
                ),
              )
            ],
          )
      ])
      ),
      backgroundColor: Colors.grey[900],
    ));
  }
}

class StepCard extends StatelessWidget {
  String text;
  String imagen;

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
              imagen ==
                      'https://img.freepik.com/vector-gratis/ilustracion-icono-dibujos-animados-fruta-manzana-concepto-icono-fruta-alimentos-aislado-estilo-dibujos-animados-plana_138676-2922.jpg?w=2000'
                  ? Image(image: NetworkImage(imagen))
                  : Image.file(File(imagen))
            ],
          ),
        ),
      ],
    );
  }
}
