import 'package:flutter/material.dart';
import 'package:my_app/widgets/appbar_widget.dart';
import 'package:my_app/Models/User.dart';
import 'package:my_app/Persistance/IRepoUser.dart';
import 'package:my_app/Persistance/RepoUser.dart';
import 'package:my_app/widgets/profile_page/profile_widget.dart';

class EditProfilePage extends StatefulWidget {
  final Future<User?> user;

  EditProfilePage({required this.user});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController displayNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController imageURLController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Set initial values in the text controllers when the user data is available
    widget.user.then((user) {
      if (user != null) {
        displayNameController.text = user.displayName;
        emailController.text = user.email;
        aboutController.text = user.description;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: FutureBuilder<User?>(
        future: widget.user,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Text('User data not available');
          } else {
            final User userData = snapshot.data!;

            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              physics: const BouncingScrollPhysics(),
              children: [
                const SizedBox(height: 24),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Change photo'),
                          content: TextField(
                            controller: imageURLController,
                            decoration: InputDecoration(
                              hintText: 'Add a URL of a photo you want to add',
                            ),
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                // TODO: No difference between save and cancel
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: Text('Save'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: Text('Cancel'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: ProfileWidget(
                    imagePath: userData.image,
                    ownProfile: true,
                    isEdit: true,
                    onClicked: () async {},
                  ),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: displayNameController,
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                  ),
                  onChanged: (value) {
                    // Handle changes to display name.
                  },
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                  onChanged: (value) {
                    // Handle changes to email.
                  },
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: aboutController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: 'About',
                  ),
                  onChanged: (value) {
                    // Handle changes to about.
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {
                    final updatedUser = userData;

                    bool dataEdited = false;

                    if (updatedUser.description != aboutController.text) {
                      updatedUser.description = aboutController.text;
                      dataEdited = true;
                    }

                    if (updatedUser.image != imageURLController.text &&
                        imageURLController.text.isNotEmpty) {
                      updatedUser.image = imageURLController.text;
                      dataEdited = true;
                    }

                    // Update user data only if edited
                    if (dataEdited) {
                      final IRepoUser repoUser = RepoUser();
                      try {
                        updatedUser.printUser();
                        repoUser.update(updatedUser);
                        showUpdateSuccessDialog(context);

                        Navigator.pop(context);
                      } catch (e) {
                        print(
                            "Error while updating an update of user with Edit Profile Page $e");
                      }
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Save Changes'),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

void showUpdateSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Update Successful!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Your profile information has been updated successfully.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Green color
                  foregroundColor: Colors.white, // White text color
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('Okay!'),
              ),
            ],
          ),
        ),
      );
    },
  );
}
