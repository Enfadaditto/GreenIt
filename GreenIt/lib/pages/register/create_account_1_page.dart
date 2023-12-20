import 'package:flutter/material.dart';
import 'package:my_app/Models/User.dart';
import 'package:my_app/pages/register/create_account_2_page.dart';

class CreateAccountPage1 extends StatefulWidget {
  @override
  _CreateAcountPage1State createState() => _CreateAcountPage1State();
}

class _CreateAcountPage1State extends State<CreateAccountPage1> {
  TextEditingController nameController = TextEditingController();
  TextEditingController displayNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();

  Future<void> _registerUser(
      String displayName, String email, String password) async {
    User user = User(
        id: -1,
        displayName: displayName,
        email: email,
        password: password,
        serverName: '',
        description: '',
        image:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Default_pfp.svg/240px-Default_pfp.svg.png',
        imagefield: '');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateAccountPage2(user: user),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 8 letters, minimum one capital and small letter, one special character, one digit
    RegExp regexPassword =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

    // classic regex for email
    RegExp regexEmail = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    // word + [space + word] (at least once) -> 'X X', 'X X X', 'X X X...'
    RegExp regexName = RegExp(r'^[a-zA-Z]+( [a-zA-Z]+)+$');

    // Between 3 and 20 characters
    RegExp regexUsername = RegExp(r'^[a-zA-Z0-9_]{3,20}$');

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 16.0, right: 16.0, top: 5.0, bottom: 5.0),
          child: Column(
            children: [
              const SizedBox(
                height: 24.0,
              ),
              // 1/2
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
                        text: '1',
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
                  // Graphics

                  Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      'lib/assets/register/register_1.png',
                      height: 322.0,
                      width: 346.0,
                    ),
                  ),

                  // Title of the page
                  const Text(
                    'Create an account!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Helvetica',
                      fontWeight: FontWeight.w500,
                      fontSize: 35.0,
                      color: Color(0xFF269A66),
                    ),
                  ),

                  // Name and Display Name
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: nameController,
                          decoration: const InputDecoration(
                              labelText: 'Name',
                              labelStyle:
                                  TextStyle(fontWeight: FontWeight.bold)),
                        ), //
                      ),
                      const SizedBox(
                          width: 8.0), // Add spacing between the text fields
                      Expanded(
                        child: TextField(
                          controller: displayNameController,
                          decoration: const InputDecoration(
                              labelText: 'User name',
                              labelStyle:
                                  TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8.0),
                  // Email
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 8.0),

                  // Pasword
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 8.0),

                  // Repeat Password
                  TextField(
                    controller: repeatPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        labelText: 'Repeat password',
                        labelStyle: TextStyle(fontWeight: FontWeight.bold)),
                  ),

                  const SizedBox(height: 12.0),
                ],
              ),
              // Register Button
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () {
                    // Check if any controller is empty
                    if (nameController.text.isEmpty ||
                        displayNameController.text.isEmpty ||
                        emailController.text.isEmpty ||
                        passwordController.text.isEmpty ||
                        repeatPasswordController.text.isEmpty) {
                      showDialogError('All fields must be filled.');
                    }
                    // Check regex patterns
                    else if (!regexName.hasMatch(nameController.text)) {
                      showDialogError(
                          'Invalid name format. It should contain at least name and surname.');
                    } else if (!regexUsername
                        .hasMatch(displayNameController.text)) {
                      showDialogError(
                          'Invalid username format. It should have 3 to 20 characters (letters or numbers).');
                    } else if (!regexEmail.hasMatch(emailController.text)) {
                      showDialogError('Invalid email format.');
                    } else if (!regexPassword
                        .hasMatch(passwordController.text)) {
                      showDialogError(
                          'Invalid password format. It should have at least 8 characters, 1 capital letter, 1 small letter, 1 digit and 1 special sign.');
                    }
                    // Check if password and repeat password match
                    else if (passwordController.text !=
                        repeatPasswordController.text) {
                      showDialogError('Passwords do not match.');
                    } else {
                      // Everything is valid, register the user
                      _registerUser(displayNameController.text,
                          emailController.text, passwordController.text);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF24445A), // Set background color
                    shape: const CircleBorder(),
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to display AlertDialog with the given error message
  void showDialogError(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor:
              const Color(0xFFCFF4D2), // Light green background color
          title: Text('Error',
              style: TextStyle(
                  color: const Color(0xFF24445A))), // Dark green title color
          content: Text(errorMessage,
              style: TextStyle(
                  color: const Color(0xFF24445A))), // Dark green content color
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              style: TextButton.styleFrom(
                backgroundColor:
                    const Color(0xFF24445A), // Dark blue button color
              ),
              child: Text('OK',
                  style: TextStyle(
                      color: Colors.white)), // White button text color
            ),
          ],
        );
      },
    );
  }
}
