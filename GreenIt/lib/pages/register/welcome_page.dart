import 'package:flutter/material.dart';
import 'package:my_app/pages/register/create_account_1_page.dart';
import 'package:my_app/pages/register/log_in_page.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Builder(
        builder: (BuildContext context) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0), // Adjust vertical padding as needed
                  child: Column(
                    children: [
                      const Text(
                        'Welcome to',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Signika',
                          fontWeight: FontWeight.w500,
                          fontSize: 45.0,
                          color: Color(0xFF269A66),
                        ),
                      ),
                      // const SizedBox(
                      //     height: 8.0), // Adjust the spacing between titles

                      // GreenIt
                      RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          style: TextStyle(
                            fontFamily: 'Signika',
                            fontSize: 45.0,
                            fontWeight: FontWeight.w700,
                          ),
                          children: [
                            TextSpan(
                              text: 'Green',
                              style: TextStyle(color: Colors.black),
                            ),
                            TextSpan(
                              text: 'It',
                              style: TextStyle(color: Color(0xFF269A66)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                          height:
                              40.0), // Adjust the spacing between GreenIt and the button

                      // Create Account Button
                      InkWell(
                        onTap: () {
                          // Navigate to CreateAccountPage1
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateAccountPage1(),
                            ),
                          );
                        },
                        child: Container(
                          width: 310.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            color: Color(0xFFCFF4D2),
                            borderRadius: BorderRadius.circular(31.0),
                          ),
                          child: const Center(
                            child: Text(
                              'Create an account',
                              style: TextStyle(
                                fontFamily: 'Helvetica',
                                fontWeight: FontWeight.w700,
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                          height:
                              16.0), // Adjust the spacing between Create an account and Log in text

                      // Log in Text
                      GestureDetector(
                        onTap: () {
                          // Navigate to LogInPage
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LogInPage(),
                            ),
                          );
                        },
                        child: Container(
                          width: 390.0,
                          height: 20.0,
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: const TextSpan(
                              text: 'Have an account already? ',
                              style: TextStyle(
                                fontFamily: 'Helvetica',
                                fontWeight: FontWeight.w400,
                                fontSize: 14.0,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Log in',
                                  style: TextStyle(
                                    fontFamily: 'Helvetica',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.0,
                                    color: Color(0xFF269A66),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
