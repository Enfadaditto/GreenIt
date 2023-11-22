import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:my_app/Models/Post.dart';
import 'package:my_app/Models/ReducedUser.dart';
import 'package:my_app/Models/User.dart';
import 'package:my_app/Persistance/IRepoPost.dart';
import 'package:my_app/Persistance/IRepoUser.dart';
import 'package:my_app/Persistance/RepoPost.dart';
import 'package:my_app/pages/edit_profile_page.dart';
import 'package:my_app/pages/users_list.dart';
import 'package:my_app/widgets/profile_page/button_widget.dart';
import 'package:my_app/widgets/profile_page/numbers_widget.dart';
import 'package:my_app/widgets/profile_page/profile_gallery_widget.dart';
import '../utils/cache_manager.dart';
import '../widgets/profile_page/profile_widget.dart';
import 'package:my_app/Persistance/RepoUser.dart'; // Import your user repository
import 'package:flutter/services.dart';

class ProfilePage extends StatefulWidget {
  final String
      data; // either "email" example: jrber23mail@gmail.com or "name" example jrber23
  final String type; // either "email" or "name" !
  const ProfilePage({required this.data, required this.type});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool? isCurrentUser;
  bool? darkMode;
  late Future<int> followersSize = Future.value(-1); // TODO
  // sometimes the value -1 appears before it is fetched from server
  late Future<int> followedSize = Future.value(-1);
  late Future<User> userPetition;
  late Future<List<Post>> posts = Future.value([]);
  final IRepoUser repoUser = RepoUser();
  final IRepoPost repoPost = RepoPost();

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadUserPosts();
    _loadCacheMemory();
  }

  Future<void> _loadCacheMemory() async {
    try {
      if (widget.data == await CacheManager.getEmail() ||
          widget.data == await CacheManager.getUsername()) {
        isCurrentUser = true;
      } else {
        isCurrentUser = false;
      }
      darkMode = await CacheManager.getDarkMode();
    } catch (e) {
      print('Error loading cache memory: $e');
    }
  }

  Future<void> _loadUserData() async {
    try {
      if (widget.type == "email") {
        userPetition = repoUser.read(widget.data);
      } else if (widget.type == "name") {
        userPetition = repoUser.readName(widget.data);
      } else {
        userPetition = repoUser.read(widget.data);
      }
      User temp = await userPetition;

      followersSize = repoUser.getCountFollowers(temp.id);
      followedSize = repoUser.getCountFollowed(temp.id);
    } catch (e) {
      print('Error fetching user data: $e');
      userPetition = User(
        displayName: 'MISTAKE',
        email: 'MISTAKE',
        password: 'MISTAKE',
        serverName: 'MISTAKE',
        description: '',
        id: 69696969,
        image: '',
        imagefield: '',
      ) as Future<User>;
    }
  }

  Future<void> _loadUserPosts() async {
    User user;
    try {
      if (widget.type == "email") {
        user = await repoUser.read(widget.data);
      } else if (widget.type == "name") {
        user = await repoUser.readName(widget.data);
      } else {
        user = await repoUser.read(widget.data);
      }
      posts = repoPost.getAllPostsUser(user.displayName);
    } catch (e) {
      print('Error fetching followers: $e');
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: const Text(
          "GreenIt",
          style: TextStyle(color: Colors.white),
        ),
      ),
      // appBar: buildAppBar(context),
      backgroundColor: darkMode ?? false ? Colors.grey : Colors.white,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 24),
          buildProfileData(
              userPetition), // Display user data if available// Show a loading indicator while fetching data
          const SizedBox(height: 12),
          FutureBuilder(
            // Wrap NumbersWidget in FutureBuilder
            future:
                Future.wait([userPetition, followersSize, followedSize, posts]),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                final followersSizeToInt = snapshot.data![1];
                // Check if followersSize is not equal to -1
                if (followersSizeToInt == -1) {
                  print("DELAY");
                  return FutureBuilder(
                    future: Future.delayed(Duration(milliseconds: 200)),
                    builder: (context, snapshot) {
                      // Now you can handle the case where followersSize is -1
                      return const Text('Error: Followers size is -1');
                    },
                  );
                }
                final followedSizeToInt = snapshot.data![2];
                final posts = snapshot.data![3] as List<Post>;

                return Column(
                  children: [
                    NumbersWidget(userPetition, followersSizeToInt,
                        followedSizeToInt, repoUser, posts.length),
                    const SizedBox(height: 12),
                    Container(
                      height: 900,
                      padding: const EdgeInsets.all(10),
                      child: buildProfileGallery(context, posts),
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget buildProfileData(Future<User> user) => FutureBuilder<User>(
        future: user,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final user = snapshot.data;

            // Retrieve the followerId from cache memory
            return FutureBuilder<int?>(
              future: CacheManager.getUserId(),
              builder: (context, userIdSnapshot) {
                if (userIdSnapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else {
                  final followerId = userIdSnapshot.data;
                  return Column(
                    children: [
                      ProfileWidget(
                        imagePath: user!.image,
                        ownProfile: isCurrentUser!,
                        onClicked: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  EditProfilePage(user: userPetition),
                            ),
                          );
                        },
                        isEdit: false,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        user.displayName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      // const SizedBox(height: 4),
                      // Text(
                      //   user.email,
                      //   style: const TextStyle(color: Colors.grey),
                      // ),
                      const SizedBox(height: 16),
                      if (user.description.isNotEmpty)
                        buildAbout(user.description),
                      const SizedBox(height: 16),
                      Center(
                        child: followerId != null
                            ? followerId == user.id
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                          foregroundColor: Colors.white,
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EditProfilePage(
                                                      user: userPetition),
                                            ),
                                          );
                                        },
                                        child: const Text('Edit Profile'),
                                      ),
                                      const SizedBox(
                                          width:
                                              8), // Adjust the spacing between buttons
                                      buildShareButton(
                                          context, user.displayName),
                                      const SizedBox(width: 8),
                                      buildSearchForNewUsers(context, user.id),
                                    ],
                                  )
                                : buildFollowButton(followerId, user.id)
                            : const CircularProgressIndicator(),
                      ),
                    ],
                  );
                }
              },
            );
          }
        },
      );

  Widget buildAbout(String description) => Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 5, vertical: 5), // Adjusted horizontal padding
        color: Colors.grey[200], // Light grey background color
        height: 5 * 16.0, // 5 lines of text, each with a height of 16.0
        width: MediaQuery.of(context).size.width * 0.8, // 80% of screen width
        child: SingleChildScrollView(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    description,
                    softWrap: true,
                    style: const TextStyle(fontSize: 16, height: 1.4),
                  ),
                ],
              );
            },
          ),
        ),
      );

  Widget buildShareButton(BuildContext context, String username) =>
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green, // Green color
          foregroundColor: Colors.white, // White text color
        ),
        onPressed: () => showShareDialog(context, username),
        child: const Text(
          'Share profile',
          style: TextStyle(color: Colors.white),
        ),
      );

  void showShareDialog(BuildContext context, String username) {
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
                  'Link Saved Successfully!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'The link to the profile has been saved to your device. You can use it by pasting.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Green color
                    foregroundColor: Colors.white, // White text color
                  ),
                  onPressed: () {
                    // TODO: Copy the link to the clipboard
                    Clipboard.setData(ClipboardData(
                        text: 'http://16.170.159.93/getUserByName?username=' +
                            username));

                    // Close the dialog
                    Navigator.of(context).pop();
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

  Widget buildFollowButton(int follower, int following) => ButtonWidget(
        text: 'Follow',
        onClicked: () async {
          try {
            await repoUser.follow(follower, following);
            print('User followed successfully');
            // You might want to update your UI or show a message here
          } catch (e) {
            print('Error following user: $e');
            // Handle the error, show a message, or take any other appropriate action
          }
        },
      );
}

Widget buildSearchForNewUsers(BuildContext context, int userId) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.green, // Green color
      foregroundColor: Colors.white, // White text color
    ), // White text color
    onPressed: () {
      _getList(context, userId);
    },
    child: const Text('Follow new users'),
  );
}

// get list of users that are followed by users that are followed by current user
// aka mutual friends - we want max 20 users overally
// and max 5 users from one user (differentiation of propositions)
Future<void> _getList(BuildContext context, int userId) async {
  try {
    final IRepoUser repoUser = RepoUser();
    List<ReducedUser> userFollowers = [];
    List<ReducedUser> propositions = [];
    final Map<int, bool> added = HashMap();
    userFollowers = await repoUser.getFollowed(userId);
    for (int i = 0; i < userFollowers.length; i++) {
      added[userFollowers[i].id] = true;
    }
    added[userId] = true;
    int propositionsSize = 0;

    for (int i = 0; i < userFollowers.length && propositionsSize < 20; i++) {
      List<ReducedUser> mutualAccounts =
          await repoUser.getFollowed(userFollowers[i].id);
      for (int j = 0;
          j < mutualAccounts.length && propositionsSize < 20 && j < 5;
          j++) {
        if (!added.containsKey(mutualAccounts[j].getId)) {
          propositions.add(mutualAccounts[j]);
          added[mutualAccounts[j].getId] = true;
          propositionsSize++;
        }
      }
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => UsersList(users: propositions),
      ),
    );
  } catch (e) {
    print('Error fetching users list for : $e');
    // Handle the error, show a message, or take any other appropriate action
  }
}
