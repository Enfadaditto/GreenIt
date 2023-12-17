import 'package:flutter/material.dart';
import 'package:my_app/Models/User.dart';
import 'package:my_app/Persistance/IRepoUser.dart';
import 'package:my_app/Persistance/RepoUser.dart';
import 'package:my_app/pages/my_app_page.dart';
import 'package:my_app/utils/cache_manager.dart';

class LogInPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LogInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> _loadUserData(String email, String password) async {
    final IRepoUser repoUser = RepoUser();
    late Future<User> userPetition;
    try {
      userPetition = repoUser.read(email);
      User user = await userPetition;
      String usernameCache = await CacheManager.getUsername();
      print("Cache manager Username: $usernameCache");
      int currentUserId = user.id;
      String userPassword = user.password;
      String userEmail = user.email;
      String username = user.displayName;

      print("EMAIL TYPED: ${email} ACTUAL: ${userEmail}");
      print("PASSWORD TYPED: ${password} ACTUAL: ${userPassword}");
      // Now you can compare the entered email and password with loaded user data
      if (email == userEmail && password == userPassword) {
        CacheManager.setUsername(username);
        CacheManager.setEmail(userEmail);
        CacheManager.setDarkMode(false);
        CacheManager.setUserId(currentUserId);

        // Login successful, navigate to the next screen

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MyApp(username: username, type: 'name'),
          ),
          (Route<dynamic> route) => false,
        );
      } else {
        // Display incorrect data message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Incorrect Data'),
              content: const Text('Please check your email and password.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16.0, right: 16, bottom: 5, top: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24.0),
              Image.asset(
                'lib/assets/register/log_in.png',
              ),
              const SizedBox(height: 16.0),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                height: 1.0,
                width: MediaQuery.of(context).size.width * 0.9,
                color: Colors.black,
              ),
              const Text(
                'Log In!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Helvetica',
                  fontWeight: FontWeight.w500,
                  fontSize: 45.0,
                  color: Color(0xFF269A66),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  _loadUserData(emailController.text, passwordController.text);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF269A66),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                child: Container(
                  width: 80.0,
                  height: 30.0,
                  child: const Center(
                    child: Text(
                      'Send!',
                      style: TextStyle(
                        fontFamily: 'Helvetica',
                        fontWeight: FontWeight.w700,
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
