import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_app/Models/Comment.dart';
import 'package:my_app/Models/User.dart';
import 'package:my_app/Persistance/RepoComment.dart';
import 'package:my_app/Persistance/RepoUser.dart';
import 'package:my_app/pages/for_you_page.dart';
import 'package:my_app/widgets/appbar_widget.dart';

class PostPage extends StatefulWidget {
  int currentIndex;

  final String author;
  final String title;
  final List<Comment> comments;
  //final List<String> steps; //Steps

  PostPage({
    super.key,
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
  late Future<User> registeredUser;
  @override
  void initState() {
    // TODO: implement initState
    try {
      registeredUser = RepoUser().read("jrber23");
    } catch (e) {
      print("error");
    }
  }

  String placeholderIMG =
      'https://img.freepik.com/vector-gratis/ilustracion-icono-dibujos-animados-fruta-manzana-concepto-icono-fruta-alimentos-aislado-estilo-dibujos-animados-plana_138676-2922.jpg?w=2000';
  //final List<String> steps;
  final _commentController = TextEditingController();

  //PostDetailed({required this.steps});

  @override
  Widget build(BuildContext context) {
    void onTabTapped(int index) {
      setState(() {
        widget.currentIndex = index;
      });
    }

    void _respondComment(Comment respondedComment) {
      Comment answerToComment = Comment(
          comment: _commentController.text,
          author: "me",
          responseTo: respondedComment);

      //RepoComment().create(answerToComment);
    }

    return MaterialApp(
        home: Scaffold(
      appBar: buildAppBar(context),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Stack(children: [
          Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 25),
                  SizedBox(
                    height: 500,
                    child: PageView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        StepCard('Description Red', placeholderIMG),
                        StepCard('Description Blue', placeholderIMG),
                        StepCard('Description Green', placeholderIMG),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                color: Colors.white,
                child: ExpansionTile(
                  title: Text("Comments"),
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget.comments.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Column(
                              children: [
                                Text(widget.comments[index].author,
                                    style: const TextStyle(
                                        color: Colors.black12, fontSize: 12)),
                                const SizedBox(height: 3),
                                Text(widget.comments[index].comment,
                                    style: const TextStyle(fontSize: 18)),
                              ],
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                  onPressed: () {
                                    _respondComment(widget.comments[index]);
                                  },
                                  icon: Icon(
                                      Icons.subdirectory_arrow_left_rounded)),
                            )
                          ],
                        );
                      },
                    ),
                    TextFormField(
                      controller: _commentController,
                      decoration: InputDecoration(
                          hintText: "Write new comment...",
                          suffixIcon: IconButton(
                            icon: Icon(Icons.send),
                            onPressed: () {
                              setState(() {
                                widget.comments.add(Comment(
                                    comment: _commentController.text,
                                    author: "Comment's Author"));
                                _commentController.clear();
                              });
                            },
                          )),
                    ),
                  ],
                ),
              )
            ],
          )
        ]),
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
