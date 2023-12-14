import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/pages/post_preview.dart';
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
  TextEditingController _stepDescriptionController = TextEditingController();
  late String stepImage;

  List<mod.Step> steps = [];
  List<Widget> stepWidgets = [];

  void _createNewPost() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PostPreview(
              steps: steps,
              postDescription: _titleController.text,
            )));
  }

  @override
  Widget build(BuildContext context) {
    void _createNewStep() {
      steps.add(mod.Step(
          id: -1,
          description: _stepDescriptionController.text,
          image: stepImage,
          previousStep: null));

      print(steps.length);
    }

    void handleImage(String img) {
      stepImage = img;
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
                onImageSelected: handleImage,
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
            //Preview Button
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _createNewPost,
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
            )
          ],
        ),
      ),
    );
  }
}
