import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_app/Models/Post.dart';
import 'package:my_app/Models/User.dart';
import 'package:my_app/Persistance/RepoPost.dart';
import 'package:my_app/Persistance/RepoStep.dart';
import 'package:my_app/Persistance/RepoUser.dart';
import 'package:my_app/pages/for_you_page.dart';
import 'package:my_app/widgets/appbar_foryoupage.dart';
import 'package:my_app/widgets/post_page/custom_dialog.dart';
import 'package:my_app/widgets/post_page/image_selector.dart';
import 'package:my_app/Models/Step.dart' as mod;

class NewPost extends StatefulWidget {
  const NewPost({super.key});

  @override
  State<StatefulWidget> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _stepDescriptionController = TextEditingController();

  late String stepImage = "";
  late String stepDescription;
  late String postThumbnail;
  late Future<User> user;

  List<mod.Step> steps = [];
  List<Widget> stepWidgets = [];

  bool estaInicializada() {
    try {
      var valorTemporal = postThumbnail; // Intenta acceder a la variable
      return true; // No se lanzó excepción, está inicializada
    } catch (e) {
      return false; // Se lanzó excepción, no está inicializada
    }
  }

  void uploadingDialog(User? originalPoster) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Text("Uploading..."),
                  SizedBox(),
                  CircularProgressIndicator()
                ],
              ),
            ),
          );
        });

    await _createNewPost(originalPoster);
    Navigator.of(context).pop();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ForYouPage()));
  }

  Future<void> _createNewPost(User? originalPoster) async {
    Post thisPost = Post(
        originalPoster: originalPoster,
        firstStep: steps.first,
        description: _descriptionController.text,
        imagenPreview: postThumbnail,
        title: _titleController.text,
        id: -1,
        serverName: "");

    var postId = await RepoPost().create2(thisPost);
    thisPost.id = postId!;

    print("Title: ${thisPost.title}");
    print("Description: " + thisPost.description);
    print("Registered user: ${thisPost.originalPoster?.displayName}");
    print("First step: " + thisPost.firstStep.toString());

    int id = 0;

    for (mod.Step step in steps) {
      //Añadir id al step
      //Subir step

      step.id = thisPost.id;
      if (id != 0) {
        step.setPreviousStep(
            mod.Step(id: id, previousStep: null, description: "", image: ""));
      } else {
        step.setPreviousStep(
            mod.Step(description: "", id: 0, image: "", previousStep: null));
      }
      print("Image: " + step.image);
      print("Description: " + step.description);
      print("Prev. step: ${step.previousStep!.id}");
      print("Post id: ${step.id}");

      id = await RepoStep().create2(step);
      print(
          "////////////////////////////////////////////////////////////////////");
      print("Step anterior id: $id");
    }
  }

  void confirmDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return FutureBuilder(
              future: user,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return AlertDialog(
                    title: Text("Almost done!"),
                    content: Container(
                      height: 234,
                      child: Column(
                        children: [
                          Container(
                            height: 150,
                            width: 150,
                            child: Image.file(File(postThumbnail)),
                            decoration: BoxDecoration(
                                color: Color(0xFFCFF4D2),
                                border: Border.all(
                                    width: 3, color: Color(0xFF269A66)),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          SizedBox(height: 20),
                          TextField(
                            controller: _descriptionController,
                            decoration: InputDecoration(
                                labelText: 'Post description',
                                alignLabelWithHint: true),
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          _stepDescriptionController.clear();
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Go back',
                          style: TextStyle(
                            color: Color(0xFF269A66),
                            fontSize: 18,
                            fontFamily: 'Helvetica',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(120, 45),
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 2, color: Color(0xFF269A66)),
                                borderRadius: BorderRadius.circular(30.0)),
                            backgroundColor: Colors.white),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          uploadingDialog(snapshot.data);
                        },
                        child: Text(
                          'Upload',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Helvetica',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(100, 45),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            backgroundColor: Color(0xFF269A66)),
                      ),
                    ],
                  );
                  ;
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              });
        });
  }

  Future<void> loadUser() async {
    try {
      user = RepoUser().readName('jrber23');
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    _titleController.addListener(() {
      setState(() {});
    });

    void _createNewStep() {
      steps.add(mod.Step(
          id: -1,
          description: _stepDescriptionController.text,
          image: stepImage,
          previousStep: null));
    }

    void handleImage(String img) {
      stepImage = img;
    }

    void handleThumbnail(String img) {
      postThumbnail = img;
      setState(() {});
    }

    void _addWidget(Widget child) {
      if (stepWidgets.length > 6) return;
      if (stepWidgets.length == 6) {
        stepWidgets.removeLast();
        stepWidgets.add(Container(
            child: Image.file(File(steps.last.image)),
            decoration: BoxDecoration(
                color: Color(0xFFCFF4D2),
                border: Border.all(width: 3, color: Color(0xFF269A66)),
                borderRadius: BorderRadius.circular(10))));
      } else {
        stepWidgets.insert(
            stepWidgets.length - 1,
            Container(
                child: Image.file(File(steps.last.image)),
                decoration: BoxDecoration(
                    color: Color(0xFFCFF4D2),
                    border: Border.all(width: 3, color: Color(0xFF269A66)),
                    borderRadius: BorderRadius.circular(10))));
      }
    }

    void doOnce() {
      loadUser();
      stepWidgets.add(ElevatedButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return StepDialog(
                  child: PickImageDialog(
                    onImageSelected: handleImage,
                    child: Text(
                      'Select image',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'Helvetica',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                  cancelFunction: () {
                    _stepDescriptionController.clear();
                    Navigator.of(context).pop();
                  },
                  addStepFunction: () {
                    _createNewStep();
                    _stepDescriptionController.clear();
                    Navigator.of(context).pop();
                    setState(() {
                      _addWidget(Image.file(File(steps.last.image)));
                    });
                  },
                  stepNumber: steps.length + 1,
                  childFunction: handleImage,
                  stepDescriptionController: _stepDescriptionController,
                );
              });
        },
        child: Icon(Icons.add, color: Colors.black, size: 30),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                side: BorderSide(width: 3, color: Color(0xFF269A66)),
                borderRadius: BorderRadius.circular(20.0)),
            backgroundColor: Color(0xFFCFF4D2)),
      ));
    }

    return Scaffold(
      appBar: buildForYouPageAppBar(context),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: <Widget>[
            //TITLE
            SizedBox(height: 24),
            Text(
              'Title',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Helvetica',
                fontWeight: FontWeight.w700,
                height: 0,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: "Your diary title")),
            ),
            //Thumbnail
            SizedBox(height: 20),
            Text(
              "Thumbnail",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Helvetica',
                fontWeight: FontWeight.w700,
                height: 0,
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 150,
              width: 150,
              child: PickImageDialog(
                onImageSelected: handleThumbnail,
                child: Transform(
                  transform: Matrix4.identity()..scale(-1.0, 1.0),
                  alignment: Alignment.center,
                  child: Icon(Icons.add_a_photo_outlined,
                      color: Colors.black, size: 30),
                ),
              ),
            ),
            //New step
            SizedBox(height: 20),
            Text(
              "Steps",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Helvetica',
                fontWeight: FontWeight.w700,
                height: 0,
              ),
            ),
            SizedBox(height: 10),
            steps.length == 0
                ? SizedBox(
                    height: 150,
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        doOnce();
                        showDialog(
                            context: context,
                            builder: (context) {
                              return StepDialog(
                                child: PickImageDialog(
                                  onImageSelected: handleImage,
                                  child: Text(
                                    'Select image',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontFamily: 'Helvetica',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                ),
                                cancelFunction: () {
                                  _stepDescriptionController.clear();
                                  Navigator.of(context).pop();
                                },
                                addStepFunction: () {
                                  _createNewStep();
                                  _stepDescriptionController.clear();
                                  Navigator.of(context).pop();
                                  setState(() {
                                    _addWidget(
                                        Image.file(File(steps.last.image)));
                                  });
                                },
                                stepNumber: steps.length + 1,
                                childFunction: handleImage,
                                stepDescriptionController:
                                    _stepDescriptionController,
                              );
                            });
                      },
                      child: Icon(Icons.add, color: Colors.black, size: 30),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 3, color: Color(0xFF269A66)),
                              borderRadius: BorderRadius.circular(20.0)),
                          backgroundColor: Color(0xFFCFF4D2)),
                    ),
                  )
                : Container(
                    height: 200,
                    width: 300,
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 4),
                        itemCount: stepWidgets.length,
                        itemBuilder: (context, index) {
                          return stepWidgets[index];
                        }),
                  ),
            //Upload Button
            SizedBox(height: 30),
            Visibility(
              child: ElevatedButton(
                onPressed: confirmDialog,
                child: Text(
                  'Upload',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Helvetica',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(150, 45),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    backgroundColor: Colors.white30),
              ),
              visible: steps.length != 0 &&
                  _titleController.text.isNotEmpty &&
                  estaInicializada(),
            )
          ],
        ),
      ),
    );
  }
}
