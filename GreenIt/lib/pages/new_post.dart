import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:my_app/utils/user_preferences.dart';
import 'package:my_app/widgets/appbar_foryoupage.dart';

class NewPost extends StatefulWidget {
  const NewPost({super.key});

  @override
  State<StatefulWidget> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _stepDescriptionController = TextEditingController();

  void _addStep(BuildContext context) {
    File? _userSelectedImage;

    Future<void> _selectImage() async {
      final imagePicker = ImagePicker();
      final pickedImage =
          await imagePicker.pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        setState(() {
          _userSelectedImage = File(pickedImage.path);
        });
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('New Step'),
          content: SizedBox(
            height: 210,
            child: Column(
              children: [
                Text('Image:'),
                SizedBox(height: 5),
                Center(
                  child: _userSelectedImage == null
                      ? ElevatedButton(
                          onPressed: _selectImage,
                          child: Text('Select image'),
                        )
                      : Image.file(_userSelectedImage!,
                          width: 150, height: 150),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _stepDescriptionController,
                  decoration: InputDecoration(labelText: "Your description"),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
              },
            ),
            TextButton(
              child: Text('Create'),
              onPressed: () {
                //Guarda el paso en steps[]
                Navigator.of(context).pop(); // Cierra el diálogo
              },
            ),
          ],
        );
      },
    );
  }

  void _addImg() {}

  void _createNewPost() {}

  void _createNewStep() {}

  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;
    var steps = [
      Container(
        child: ElevatedButton(
          onPressed: () {
            _addStep(this.context);
          },
          child: Icon(Icons.add, color: Colors.white),
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              backgroundColor: Colors.black54),
        ),
      ),
    ];

    return Scaffold(
      appBar: buildForYouPageAppBar(context),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: <Widget>[
            Text('TITLE:', style: TextStyle(fontSize: 18)),
            TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: "Your diary title")),
            SizedBox(height: 30),
            Text("STEPS:", style: TextStyle(fontSize: 18)),
            SizedBox(
                height: 300,
                child: PageView.builder(
                  itemCount: steps.length,
                  itemBuilder: (context, index) {
                    return steps[index];
                  },
                )),
            SizedBox(height: 100),
            ElevatedButton(onPressed: _createNewPost, child: Text('CREATE'))
          ],
        ),
      ),
    );
  }
}
