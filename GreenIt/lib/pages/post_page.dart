import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_stepindicator/flutter_stepindicator.dart';
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
  String id;
  final String author;
  String title;
  List<Comment> comments;
  final int postId;
  String description;
  //final List<String> steps; //Steps
  late List<MyStep.Step?> steps = [];

  PostPage({
    super.key,
    required this.author,
    required this.postId,
    required this.title,
    required this.id,
    required this.comments,
    required this.description,
    /*required this.steps*/
  });

  @override
  State<StatefulWidget> createState() => PostDetailed();
}

class PostDetailed extends State<PostPage> {
  int _currentPageIndex = 0;
  int _previousPageIndex = 0;

  int _currentIndexStepper = 0;

  Future<List<MyStep.Step?>>? steps;

  String placeholderIMG =
      'https://img.freepik.com/vector-gratis/ilustracion-icono-dibujos-animados-fruta-manzana-concepto-icono-fruta-alimentos-aislado-estilo-dibujos-animados-plana_138676-2922.jpg?w=2000';
  //final List<String> steps;
  final _commentController = TextEditingController();
  late Future<List<Comment>> commentList =
      RepoComment().getAllCommentsPost(widget.postId);

  //PostDetailed({required this.steps});

  void getCommentList() async {
    print(widget.postId);
    print(
        "//////////////////////////////////////////////////////////////////////////");
    widget.comments = await RepoComment().getAllCommentsPost(widget.postId);
  }

  Future<List<MyStep.Step?>> getSteps() async {
    return await RepoPost().getListSteps(widget.id);
  }

  void fetchSteps() async {
    widget.steps = await RepoPost().getListSteps(widget.id);
  }

  @override
  void initState() {
    super.initState();
    steps = getSteps();
  }

  @override
  Widget build(BuildContext context) {
    void onTabTapped(int index) {
      setState(() {
        _currentPageIndex = index;
      });
    }

    void _respondComment(Comment respondedComment) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Text your response'),
              content: TextField(
                controller: _commentController,
              ),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Comment answerToComment = Comment(
                        id: -1,
                        postId: widget.postId,
                        comment: _commentController.text,
                        author: UserPreferences.myUser.name,
                        responseTo: respondedComment,
                        replies: [],
                        date: DateTime.now());

                    setState(() {
                      respondedComment.replies.add(answerToComment);
                    });

                    _commentController.clear();
                    Navigator.of(context).pop();
                    RepoComment().create(answerToComment);
                  },
                ),
                TextButton(
                  child: const Text('Cancel'),
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
      body: FutureBuilder(
        future: steps,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Text("Something went wrong");
          } else {
            return Container(
                color: Colors.white,
                // width: double.infinity,
                height: double.infinity,
                child: Stack(children: [
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 15.0, right: 15.0),
                      child: Center(
                          child: Text(
                        textAlign: TextAlign.center,
                        widget.title,
                        style: const TextStyle(
                            color: Colors.black, fontSize: 32.0),
                      )),
                    ),
                    Padding(
                      padding: // EdgeInsets.only(top: 10.0, bottom: 40.0),
                          const EdgeInsets.only(
                              top: 10.0, left: 8.0, right: 8.0),
                      child: Center(
                          child: Text(
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        widget.description,
                        style: const TextStyle(
                            color: Colors.black, fontSize: 12.0),
                      )),
                    ),
                    Expanded(
                        child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, bottom: 10.0, left: 25.0, right: 25.0),
                        child: FlutterStepIndicator(
                          onChange: (index) {},
                          negativeColor: Colors.grey,
                          positiveColor: Colors.green[600],
                          progressColor: const Color.fromARGB(255, 10, 212, 20),
                          list: snapshot.requireData,
                          page: _currentIndexStepper,
                          disableAutoScroll: false,
                          height: 15,
                        ),
                      ),
                    )),
                    //const SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: SizedBox(
                        height: 500,
                        child: PageView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            //steps.forEach((step) {
                            //  StepCard(step.description, step.image);
                            //})

                            PageView.builder(
                              onPageChanged: (index) {
                                _previousPageIndex = _currentPageIndex;
                                setState(() {
                                  _currentPageIndex = index;
                                });

                                if (_currentPageIndex > _previousPageIndex) {
                                  _currentIndexStepper++;
                                } else if (_currentPageIndex <
                                    _previousPageIndex) {
                                  _currentIndexStepper--;
                                }
                              },
                              itemCount: snapshot.requireData.length,
                              itemBuilder: (context, index) {
                                return StepCard(snapshot.requireData[index]!.getDescription(),
                                    snapshot.requireData[index]!.getImage(), index);
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ]),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                        child: Container(
                            decoration: const ShapeDecoration(
                              color: Color(0xFFCFF4D2),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30))),
                            ),
                            child: FutureBuilder(
                                future: RepoComment()
                                    .getAllCommentsPost(widget.postId),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return ExpansionTile(
                                      title: Row(
                                        children: [
                                          const Text("Comments",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Helvetica')),
                                          const SizedBox(width: 10),
                                          Text("${snapshot.data!.length}",
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Color(0xFF686868))),
                                        ],
                                      ),
                                      children: [
                                        Container(
                                          width: 350,
                                          decoration: const ShapeDecoration(
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                width: 1,
                                                strokeAlign: BorderSide
                                                    .strokeAlignCenter,
                                                color: Color(0xFF6E6E6E),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                            constraints: const BoxConstraints(
                                                maxHeight: 300),
                                            child: Scaffold(
                                              backgroundColor:
                                                  const Color(0xFFCFF4D2),
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
                                                hintText:
                                                    "Write new comment...",
                                                suffixIcon: IconButton(
                                                  icon: const Icon(Icons.send),
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
                                                              replies: [],
                                                              date: DateTime
                                                                  .now()),
                                                          postId: widget.postId,
                                                          comment:
                                                              _commentController
                                                                  .text,
                                                          author:
                                                              UserPreferences
                                                                  .myUser.name,
                                                          replies: [],
                                                          date: DateTime.now());
                                                      widget.comments
                                                          .add(newComment);
                                                      RepoComment()
                                                          .create(newComment);
                                                      _commentController
                                                          .clear();
                                                    });
                                                  },
                                                )),
                                          ),
                                        )
                                      ],
                                    );
                                  } else if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else {
                                    return const Text("ERROR");
                                  }
                                })),
                      ),
                    ],
                  )
                ]));
          }
        },
      ),
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
  int index;

  StepCard(this.text, this.imagen, this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    //TODO: once we can extract images from the server, we need to investigate how to display them here
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          height: 500,
          child: Column(
            children: [
              Image(image: NetworkImage(imagen!)),
              Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Center(
                          child: Text(
                            "STEP ${index + 1}\n",
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Center(
                          child: Text(
                            text,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16),
                          ),
                        ),
                      )
                    ],
                  )),
              /* imagen ==
                      'https://img.freepik.com/vector-gratis/ilustracion-icono-dibujos-animados-fruta-manzana-concepto-icono-fruta-alimentos-aislado-estilo-dibujos-animados-plana_138676-2922.jpg?w=2000'
                  ? Image(image: NetworkImage(imagen!))
                  : Image.file(File(imagen!)) */
            ],
          ),
        ),
      ],
    );
  }
}
