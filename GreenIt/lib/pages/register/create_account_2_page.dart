import 'package:flutter/material.dart';
import 'package:my_app/Models/User.dart';
import 'package:my_app/Persistance/IRepoUser.dart';
import 'package:my_app/Persistance/RepoUser.dart';
import 'package:my_app/pages/my_app_page.dart';
import 'package:my_app/utils/cache_manager.dart';

class CreateAccountPage2 extends StatefulWidget {
  final User user;

  const CreateAccountPage2({Key? key, required this.user}) : super(key: key);

  @override
  _CreateAccountPage2State createState() => _CreateAccountPage2State();
}

class _CreateAccountPage2State extends State<CreateAccountPage2> {
  TextEditingController descriptionController = TextEditingController();
  bool isOver16Checked = false;
  bool isTermsAccepted = false;

  Future<void> _register(User user) async {
    final IRepoUser repoUser = RepoUser();

    try {
      bool created = await repoUser.create(user);

      if (created) {
        await CacheManager.setUsername(user.displayName);
        await CacheManager.setEmail(user.email);
        await CacheManager.setDarkMode(false);
        User userServer = await repoUser.read(user.email);
        await CacheManager.setUserId(userServer.id);
        // User created successfully, navigate to the next screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                MyApp(username: user.displayName, type: 'name'),
          ),
        );
      } else {
        // Display error message for failed user creation
        showDialogError("User creation failed. Please try again.");
      }
    } catch (e) {
      // Handle any exceptions that might occur during user creation
      print("An error occurred during user creation: $e");
      showDialogError("An error occurred. Please try again.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // 2/2
              Align(
                alignment: Alignment.topLeft,
                child: RichText(
                  textAlign: TextAlign.left,
                  text: const TextSpan(
                    style: TextStyle(
                      fontFamily: 'Signika',
                      fontSize: 45.0,
                      fontWeight: FontWeight.w700,
                    ),
                    children: [
                      TextSpan(
                        text: '2',
                        style: TextStyle(color: Color(0xFF269A66)),
                      ),
                      TextSpan(
                        text: '/2',
                        style: TextStyle(color: Color(0xFF000000)),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Display Image
                  Image.asset(
                    'lib/assets/register/register_2.png',
                    // Add any necessary configurations for the image
                  ),

                  // Description
                  RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(
                        fontFamily: 'Signika',
                        fontSize: 30.0,
                        fontWeight: FontWeight.w700,
                      ),
                      children: [
                        TextSpan(
                          text: 'Add your ',
                          style: TextStyle(color: Color(0xFF000000)),
                        ),
                        TextSpan(
                          text: 'Bio',
                          style: TextStyle(color: Color(0xFF269A66)),
                        ),
                      ],
                    ),
                  ),

                  // Description
                  TextField(
                    controller: descriptionController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                        labelText: 'Description',
                        labelStyle: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 8.0),

                  // Checkboxes
                  Row(
                    children: [
                      Checkbox(
                        value: isOver16Checked,
                        onChanged: (value) {
                          setState(() {
                            isOver16Checked = value ?? false;
                          });
                        },
                      ),
                      const Text(
                        'I am over 16 years old',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: isTermsAccepted,
                        onChanged: (value) {
                          setState(() {
                            isTermsAccepted = value ?? false;
                          });
                        },
                      ),
                      const Text(
                        'I accept the Terms of Use and Conditions',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF24445A),
                          shape: const CircleBorder(),
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (!isOver16Checked || !isTermsAccepted) {
                            showDialogError('Approve all the checkboxes');
                          } else {
                            widget.user.description =
                                descriptionController.text;
                            _register(widget.user);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF24445A),
                          shape: const CircleBorder(),
                        ),
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to display an error dialog
  void showDialogError(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
