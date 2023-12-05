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
            SizedBox(height: 24),
            Text('TITLE:', style: TextStyle(fontSize: 18)),
            TextField(
                controller: _titleController,
                decoration:
                    InputDecoration(labelText: "Your diary description")),
            SizedBox(height: 30),
            Text("STEPS:", style: TextStyle(fontSize: 18)),
            SizedBox(height: 30),
            SizedBox(
              height: 200,
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('New Step'),
                          content: Container(
                            height: 300,
                            width: 300,
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
                child: Icon(Icons.add, color: Colors.white),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    backgroundColor: Colors.black54),
              ),
            ),
            SizedBox(height: 100),
            ElevatedButton(onPressed: _createNewPost, child: Text('PREVIEW'))
          ],
        ),
      ),
    );
  }
}
