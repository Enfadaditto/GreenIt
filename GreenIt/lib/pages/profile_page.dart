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
import 'package:my_app/widgets/followers/follow_button.dart';
import 'package:my_app/widgets/profile_page/about_widget.dart';
import 'package:my_app/widgets/profile_page/numbers_widget.dart';
import 'package:my_app/widgets/profile_page/profile_gallery_widget.dart';
import 'package:my_app/widgets/profile_page/share_profile_widget.dart';
import '../utils/cache_manager.dart';
import 'package:my_app/Persistance/RepoUser.dart';

// colors - light green: CFF4D2 | dark green: 269A66 | dark blue: 24445A

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
  late Future<bool> alreadyFollowed = Future.value(false);
  late Future<User> userPetition;
  late Future<List<Post>> posts = Future.value([]);
  final IRepoUser repoUser = RepoUser();
  final IRepoPost repoPost = RepoPost();

  @override
  void initState() {
    super.initState();
    _loadCacheMemory();
    _loadUserData();
    _loadUserPosts();
  }

  void _handleFollowersChanged() {
    _loadCacheMemory().then((_) {
      _loadUserData().then((_) {
        setState(() {
          print("Callback function executed after data retrieval");
          build(context);
          // Additional logic if needed
        });
      });
    });
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
      int currentUserId = await CacheManager.getUserId() as int;
      alreadyFollowed = repoUser.checkFollows(currentUserId, temp.id);
      followersSize = repoUser.getCountFollowers(temp.id);
      followedSize = repoUser.getCountFollowed(temp.id);
    } catch (e) {
      print('Error fetching user data: $e');
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
      // appBar: AppBar(
      //   backgroundColor: Colors.green[900],
      //   title: const Text(
      //     "GreenIt",
      //     style: TextStyle(color: Colors.white),
      //   ),
      // ),
      // appBar: buildAppBar(context),
      // appBar: AppBar(),
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
            future: Future.wait([userPetition, posts]),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              return buildUserPosts(context, snapshot);
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
            return FutureBuilder(
              future: Future.wait([CacheManager.getUserId(), alreadyFollowed]),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot2) {
                if (snapshot2.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else {
                  final followerId = snapshot2.data![0];
                  final alreadyFollowedBool = snapshot2.data![1];
                  final userImage = NetworkImage(user!.image);
                  final userText = followerId == user.id
                      ? "Hello, ${user.displayName}"
                      : "Hi, I'm ${user.displayName}!";
                  return Column(
                    children: [
                      Text(
                        userText,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ClipOval(
                        child: Image(
                          image: userImage,
                          width: 144,
                          height: 144,
                          fit: BoxFit.cover, // Scale and center the image
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        user.email,
                        style: const TextStyle(
                          color: Color(0xFF727272),
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 16),
                      FutureBuilder(
                        future: Future.wait(
                            [userPetition, followersSize, followedSize]),
                        builder:
                            (context, AsyncSnapshot<List<dynamic>> snapshot) {
                          return buildNumbersWidget(context, snapshot);
                        },
                      ),
                      if (user.description.isNotEmpty)
                        buildAbout(context, user.description),
                      const SizedBox(height: 16),
                      Center(
                        child: buildProfileButtons(
                            context, followerId, alreadyFollowedBool, user),
                      ),
                    ],
                  );
                }
              },
            );
          }
        },
      );

  Widget buildNumbersWidget(
      BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const CircularProgressIndicator();
    } else {
      final followersSizeToInt = snapshot.data![1];
      final followedSizeToInt = snapshot.data![2];
      if (followersSizeToInt == -1) {
        print("DELAY");
        return FutureBuilder(
          future: Future.delayed(const Duration(milliseconds: 200)),
          builder: (context, snapshot) {
            return const Text('Error: Followers size is -1');
          },
        );
      }
      return NumbersWidget(userPetition, followersSizeToInt, followedSizeToInt,
          repoUser, _handleFollowersChanged);
    }
  }

  Widget buildUserPosts(
      BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const CircularProgressIndicator();
    } else {
      final posts = snapshot.data![1] as List<Post>;
      print(posts.length);
      return Container(
        height: 900,
        padding: const EdgeInsets.all(10),
        child: buildProfileGallery(context, posts),
      );
    }
  }

  Widget buildProfileButtons(
    BuildContext context,
    int? followerId,
    bool alreadyFollowedBool,
    User user,
  ) {
    if (followerId != null) {
      if (followerId == user.id) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFCFF4D2),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          20), // Adjust the radius as needed
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .push(
                          MaterialPageRoute(
                            builder: (context) =>
                                EditProfilePage(user: userPetition),
                          ),
                        )
                        .then((value) => setState(() {}));
                  },
                  child: const Text('Edit Profile'),
                ),
                const SizedBox(width: 8),
                buildShareButton(context, user.displayName),
              ],
            ),
            const SizedBox(width: 8),
            buildSearchForNewUsers(context, user.id, _handleFollowersChanged),
          ],
        );
      } else {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FollowButton(
              repoUser: repoUser,
              follower: followerId,
              following: user.id,
              alreadyFollowed: alreadyFollowedBool,
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFCFF4D2),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(20), // Adjust the radius as needed
                ),
              ),
              onPressed: () {},
              child: const Text('Message'),
            ),
          ],
        );
      }
    } else {
      return const CircularProgressIndicator();
    }
  }

  Widget buildSearchForNewUsers(
      BuildContext context, int userId, VoidCallback onFollowersChanged) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFCFF4D2),
        foregroundColor: Colors.black, // White text color
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(20), // Adjust the radius as needed
        ),
      ), // White text color
      onPressed: () {
        _getList(context, userId, onFollowersChanged);
      },
      child: const Text('Follow new users'),
    );
  }

  // get list of users that are followed by users that are followed by current user
// aka mutual friends - we want max 20 users overally
// and max 10 users from one user (differentiation of propositions)
  Future<void> _getList(
      BuildContext context, int userId, VoidCallback onFollowersChanged) async {
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
            j < mutualAccounts.length && propositionsSize < 20 && j < 10;
            j++) {
          if (!added.containsKey(mutualAccounts[j].getId)) {
            propositions.add(mutualAccounts[j]);
            added[mutualAccounts[j].getId] = true;
            propositionsSize++;
          }
        }
      }
      Navigator.of(context)
          .push(MaterialPageRoute(
            builder: (context) => UsersList(users: propositions),
          ))
          .then((value) => _handleFollowersChanged());
    } catch (e) {
      print('Error fetching users list for : $e');
      // Handle the error, show a message, or take any other appropriate action
    }
  }
}
