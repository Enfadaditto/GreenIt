import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:like_button/like_button.dart';
import 'package:my_app/Decoding.dart';
import 'package:my_app/Models/Comment.dart';
import 'package:my_app/Models/Post.dart';
import 'package:my_app/Persistance/IRepoPost.dart';
import 'package:my_app/Persistance/RepoComment.dart';
import 'package:my_app/Persistance/RepoPost.dart';
import 'package:my_app/Persistance/ServerConnect.dart';
import 'package:my_app/Persistance/RepoUser.dart';
import 'package:my_app/pages/post_page.dart';
import 'package:my_app/pages/stepper.dart';
import 'package:my_app/widgets/appbar_foryoupage.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const ForYouPage());
}

class ForYouPage extends StatelessWidget {
  const ForYouPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hello',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          useMaterial3: true),
      home: const PostDetail(title: 'My tests'),
    );
  }
}

class PostDetail extends StatefulWidget {
  const PostDetail({super.key, required this.title});
  final String title;

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  int currentIndex = 0;
  int _page = 1;
  final int _limit = 5;
  bool _isFirstLoadRunning = false;
  bool _hasNextPage = true;

  bool _isLoadMoreRunning = false;

  List _posts = [];
  List<Post> postsObjects = [];

  ServerConnect serverConnect = ServerConnect();

  // late Future<Post> postPetition;
  final IRepoPost repoPost = RepoPost();

  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true;
      });

      _page += 1;

      try {
        final res = await http
            .get(Uri.parse("http://16.170.159.93/postsPaged?page=$_page"));
        final List fetchedPosts = json.decode(res.body);

        for (int i = 0; i < fetchedPosts.length; i++) {
          Post p = Post(
              imagenPreview: '',
              originalPoster: RepoPost().jsonToUser(_posts[i]['creator']),
              firstStep: null,
              id: fetchedPosts[i]['id'],
              serverName: fetchedPosts[i]['serverName'],
              description: fetchedPosts[i]['description']);

          setState(() {
            postsObjects.add(p);
          });
        }
        print(postsObjects.length);

        if (fetchedPosts.isNotEmpty) {
          setState(() {
            _posts.addAll(fetchedPosts);
          });
        } else {
          setState(() {
            _hasNextPage = false;
          });
        }
      } catch (err) {
        if (kDebugMode) {
          print("Something went wrong");
        }
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });

    try {
      final res = await http
          .get(Uri.parse("http://16.170.159.93/postsPaged?page=$_page"));
      setState(() {
        _posts = json.decode(res.body);
        for (int i = 0; i < _posts.length; i++) {
          Post p = Post(
              imagenPreview: '',
              originalPoster: RepoPost().jsonToUser(_posts[i]['creator']),
              firstStep: null,
              id: _posts[i]['id'],
              serverName: _posts[i]['serverName'],
              description: _posts[i]['description']);

          setState(() {
            postsObjects.add(p);
          });

          print(postsObjects.length);
        }
      });
    } catch (err) {
      if (kDebugMode) {
        print("Something went wrong" + err.toString());
      }
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _firstLoad();
    _controller = ScrollController()..addListener(_loadMore);
  }

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  Future<bool?> onLikeButtonTapped(
      bool isLiked, String username, String postId) async {
    Future.delayed(const Duration(milliseconds: 2000));
    serverConnect.insertData(
        "http://16.170.159.93/like?username=$username&postid=$postId");
    return !isLiked;
  }

  Future<bool?> onUnlikeButtonTapped(
      bool isLiked, String username, String postId) async {
    Future.delayed(const Duration(milliseconds: 2000));
    serverConnect.insertData(
        "http://16.170.159.93/unlike?username=$username&postid=$postId");
    return !isLiked;
  }

  Future<int?> getNumLikes(String id) async {
    Future.delayed(const Duration(milliseconds: 2000));
    final response = await http
        .get(Uri.parse("http://16.170.159.93/howmanylikes?postid=$id"));
    return int.parse(response.body);
  }

  Future<String> postIsLiked(String id) async {
    Future.delayed(const Duration(milliseconds: 2000));
    final response = await http.get(Uri.parse(
        "http://16.170.159.93/ispostalreadyliked?postid=$id&username=jrber23"));
    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildForYouPageAppBar(context),
        body: _isFirstLoadRunning
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: postsObjects.length,
                        controller: _controller,
                        itemBuilder: (context, index) {
                          return Card(
                              color: const Color.fromARGB(255, 0, 0, 175),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              'https://img.freepik.com/vector-gratis/ilustracion-icono-dibujos-animados-fruta-manzana-concepto-icono-fruta-alimentos-aislado-estilo-dibujos-animados-plana_138676-2922.jpg?w=2000'),
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            '@${postsObjects[index].getOriginalPoster()?.getDisplayName()}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 30,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => PostPage(
                                                  comments: [], //TODO
                                                  postId: 10, //TODO
                                                  author: "author",
                                                  title: "title",
                                                  currentIndex: currentIndex)));
                                    },
                                    child: Image.network(
                                        'https://upload.wikimedia.org/wikipedia/commons/4/47/Cyanocitta_cristata_blue_jay.jpg'),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          FutureBuilder(
                                            future: Future.wait([
                                              getNumLikes(postsObjects[index]
                                                  .getId()
                                                  .toString()),
                                              postIsLiked(postsObjects[index]
                                                  .getId()
                                                  .toString())
                                            ]),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return const Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              } else if (snapshot.hasError) {
                                                return Center(
                                                    child: Text(
                                                        'Error: ${snapshot.error}'));
                                              } else {
                                                int numLikes =
                                                    snapshot.data![0] as int;
                                                String isLiked =
                                                    snapshot.data![1] as String;

                                                return LikeButton(
                                                    size: 32.0,
                                                    isLiked:
                                                        isLiked.contains("true")
                                                            ? true
                                                            : false,
                                                    likeCount: numLikes,
                                                    likeBuilder: (isLiked) {
                                                      return Icon(
                                                          Icons.favorite,
                                                          color: isLiked
                                                              ? Colors.red
                                                              : Colors.white,
                                                          size: 32.0);
                                                    },
                                                    countBuilder: (likeCount,
                                                        isLiked, text) {
                                                      return Text(
                                                        text,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      );
                                                    },
                                                    onTap: (isLiked) {
                                                      if (isLiked) {
                                                        return onUnlikeButtonTapped(
                                                            isLiked,
                                                            postsObjects[index]
                                                                .getOriginalPoster()!
                                                                .getDisplayName(),
                                                            postsObjects[index]
                                                                .getId()
                                                                .toString());
                                                      } else {
                                                        return onLikeButtonTapped(
                                                            isLiked,
                                                            postsObjects[index]
                                                                .getOriginalPoster()!
                                                                .getDisplayName(),
                                                            postsObjects[index]
                                                                .getId()
                                                                .toString());
                                                      }
                                                    });
                                              }
                                            },
                                          )
                                        ],
                                      )),
                                  Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Expanded(
                                        child: Text(
                                            postsObjects[index]
                                                .getDescription(),
                                            style: const TextStyle(
                                                color: Colors.white))),
                                  ),
                                ],
                              ));
                        }),
                  ),
                  if (_isLoadMoreRunning == true)
                    const Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  if (_hasNextPage == false)
                    Container(
                      padding: const EdgeInsets.only(top: 30, bottom: 40),
                      color: Colors.amber,
                      child: const Center(
                        child: Text("You have fetched all of the content"),
                      ),
                    )
                ],
              ));
  }
}
