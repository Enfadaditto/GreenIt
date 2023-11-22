import 'package:flutter/material.dart';
import 'package:my_app/Models/Post.dart';
import 'package:my_app/Models/ReducedUser.dart';
import 'package:my_app/Models/User.dart';
import 'package:my_app/Persistance/IRepoPost.dart';
import 'package:my_app/Persistance/IRepoUser.dart';
import 'package:my_app/Persistance/RepoPost.dart';
import 'package:my_app/pages/edit_profile_page.dart';
import 'package:my_app/widgets/profile_page/button_widget.dart';
import 'package:my_app/widgets/profile_page/numbers_widget.dart';
import 'package:my_app/widgets/profile_page/profile_gallery_widget.dart';
import 'package:my_app/widgets/appbar_widget.dart';
import '../utils/cache_manager.dart';
import '../widgets/profile_page/profile_widget.dart';
import 'package:my_app/Persistance/RepoUser.dart'; // Import your user repository

class ProfilePage extends StatefulWidget {
  final String data;
  final String type;
  ProfilePage({required this.data, required this.type});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool? isCurrentUser;
  late Future<User> userPetition;
  late Future<List<ReducedUser>> followers = Future.value([]);
  late Future<List<ReducedUser>> followed = Future.value([]);
  late Future<List<Post>> posts = Future.value([]);
  final IRepoUser repoUser = RepoUser();
  final IRepoPost repoPost = RepoPost();

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadNumberFollowers();
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

  Future<void> _loadNumberFollowers() async {
    User user;

    try {
      if (widget.type == "email") {
        user = await repoUser.read(widget.data);
      } else if (widget.type == "name") {
        user = await repoUser.readName(widget.data);
      } else {
        user = await repoUser.read(widget.data);
      }
      int userId = user.id;
      followers = repoUser.getFollowers(userId);
      followed = repoUser.getFollowed(userId);
    } catch (e) {
      print('Error fetching followers: $e');
    }
    if (mounted) {
      setState(() {});
    }
  }
  // getAllPostsUser

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
      appBar: buildAppBar(context),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 24),
          buildProfileData(
              userPetition), // Display user data if available// Show a loading indicator while fetching data
          const SizedBox(height: 12),
          FutureBuilder(
            // Wrap NumbersWidget in FutureBuilder
            future: Future.wait([userPetition, followers, followed, posts]),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                final followers = snapshot.data![1] as List<ReducedUser>;
                final followed = snapshot.data![2] as List<ReducedUser>;
                final posts = snapshot.data![3] as List<Post>;

                return Column(
                  children: [
                    NumbersWidget(userPetition, followers.length,
                        followed.length, repoUser, posts.length),
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
                  return CircularProgressIndicator();
                } else {
                  final followerId = userIdSnapshot.data;
                  String d2 = user!.description;
                  for (int i = 0; i < 20; i++) d2 += user.description;
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
                                ? buildUpgradeButton(context)
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
        padding: EdgeInsets.symmetric(
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
                    style: TextStyle(fontSize: 16, height: 1.4),
                  ),
                ],
              );
            },
          ),
        ),
      );

  Widget buildUpgradeButton(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[800], // Toned black color
          foregroundColor: Colors.white, // White text color
        ),
        onPressed: () => showUpgradeDialog(context),
        child: const Text(
          'Upgrade to PRO',
          style: TextStyle(color: Colors.white),
        ),
      );

  void showUpgradeDialog(BuildContext context) {
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
                  'We are working on that!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Thank you for your interest. This feature is under development.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800], // Toned black color
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
