import 'package:flutter/material.dart';
import 'package:my_app/utils/user_preferences.dart';
import 'package:my_app/widgets/appbar_foryoupage.dart';
import 'package:my_app/widgets/image_selector.dart';

class NewPost extends StatefulWidget {
  const NewPost({super.key});

  @override
  State<StatefulWidget> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _stepDescriptionController = TextEditingController();
  final user = UserPreferences.myUser;

  void _createNewPost() {}

  @override
  Widget build(BuildContext context) {
    void _createNewStep() {}

    var steps = [
      ElevatedButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('New Step'),
                  content: Container(
                    height: 216,
                    child: Column(children: [
                      PickImageDialog(),
                      SizedBox(height: 10),
                      Container(
                        alignment: Alignment.bottomCenter,
                        child: TextField(
                          controller: _stepDescriptionController,
                          decoration:
                              InputDecoration(labelText: 'Step description'),
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
