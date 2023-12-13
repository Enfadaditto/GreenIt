import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/pages/post_preview.dart';
import 'package:my_app/widgets/appbar_foryoupage.dart';
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
            SizedBox(height: 40),
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
                )

                /*
              ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('New Step'),
                          content: Container(
                            height: 100,
                            width: 100,
                            child: Column(children: [
                              PickImageDialog(
                                onImageSelected: handleImage,
                              ),
                              SizedBox(height: 10),
                              Container(
                                alignment: Alignment.bottomCenter,
                                child: TextField(
                                  controller: _stepDescriptionController,
                                  decoration: InputDecoration(
                                      labelText: 'Step description'),
                                ),
                              )
                            ]),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Close'),
                              onPressed: () {
                                _stepDescriptionController.clear();
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text('New Step'),
                              onPressed: () {
                                _createNewStep();
                                _stepDescriptionController.clear();
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      });
                },
                child: Transform(
                  transform: Matrix4.identity()..scale(-1.0, 1.0),
                  alignment: Alignment.center,
                  child: Icon(Icons.add_a_photo_outlined,
                      color: Colors.black, size: 30),
                ),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    backgroundColor: Color(0xFFCFF4D2)),
              ),



              Text(
                  'Select image',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'Helvetica',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              */
                ),
            //New step
            SizedBox(height: 30),
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
            SizedBox(
              height: 150,
              width: 150,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Column(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF269A66),
                                ),
                                width: 25,
                                height: 25,
                                child: Text(
                                  '${steps.length + 1}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Helvetica',
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Step ${steps.length + 1}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontFamily: 'Helvetica',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                              ),
                            ],
                          ),
                          content: Container(
                            height: 324,
                            child: Column(children: [
                              PickImageDialog(
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
                              SizedBox(height: 10),
                              Container(
                                alignment: Alignment.bottomCenter,
                                child: TextField(
                                  controller: _stepDescriptionController,
                                  decoration: InputDecoration(
                                      labelText: 'Step description'),
                                ),
                              )
                            ]),
                          ),
                          actions: <Widget>[
                            ElevatedButton(
                              onPressed: () {
                                _stepDescriptionController.clear();
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Close',
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
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                  backgroundColor: Colors.white),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _createNewStep();
                                _stepDescriptionController.clear();
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Add Step',
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
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                  backgroundColor: Color(0xFF269A66)),
                            ),
                          ],
                        );
                      });
                },
                child: Icon(Icons.add, color: Colors.black, size: 30),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    backgroundColor: Color(0xFFCFF4D2)),
              ),
            ),
            //Preview Button
            SizedBox(height: 50),
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
