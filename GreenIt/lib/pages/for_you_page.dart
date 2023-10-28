import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:my_app/Decoding.dart';
import 'package:my_app/Models/Post.dart';
import 'package:my_app/Persistance/IRepoPost.dart';
import 'package:my_app/Persistance/RepoPost.dart';
import 'package:my_app/pages/post_page.dart';
import 'package:my_app/widgets/appbar_foryoupage.dart';

void main() {
  runApp(const ForYouPage());
}

class ForYouPage extends StatelessWidget {
  const ForYouPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  late Future<Post> postPetition;
  final IRepoPost repoPost = RepoPost();

  @override
  void initState() {
    super.initState();
    postPetition = repoPost.read('jrber23').then((data) {
      return Post(originalPoster: data.originalPoster, 
                  firstStep: data.firstStep, 
                  id: data.id, 
                  serverName: data.serverName);
    });
  }

  Future<void> initializePosts() async {
      postPetition = repoPost.read('jrber23');
  }

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    initializePosts();
    return Scaffold(
      appBar: buildForYouPageAppBar(context),
      body: Center(
        child: FutureBuilder<Post>(
          future: postPetition,
          builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
              } else {
                  return SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: List.generate(
                          26,
                          (index) => PostWidget(
                                title: '@${snapshot.data?.getOriginalPoster()?.getDisplayName()}',
                                description: 'Usuario ${snapshot.data?.getFirstStep()?.getDescription()}',
                                currentIndex: currentIndex,
                              ))),
                  );
              }
          }),
        )
    );
    /* return Scaffold(
      appBar: buildForYouPageAppBar(context),
      body: Center(child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: List.generate(
                        1,
                        (index) => PostWidget(
                              title: 'Usuario $postPetition',
                              currentIndex: currentIndex,
                            )))),
          );
        },
      )),
    ); */
  }
}

class PostWidget extends StatelessWidget {
  PostWidget({
    super.key,
    required this.title,
    required this.description,
    required this.currentIndex,
  });

  final String title;
  final String description;
  int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16.0),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => PostPage(
                        author: 'Me',
                        title: title,
                        currentIndex: currentIndex,
                      )),
            );
          },
          child: Card(
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
                            title,
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
                  Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/4/47/Cyanocitta_cristata_blue_jay.jpg'),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                  ),
                  // const SizedBox(height: 20.0),
                ],
              )),
        )
      ],
    );
  }
}
