import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  const Post({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        actions: const <Widget>[
          Icon(Icons.search, color: Colors.white),
          SizedBox(width: 16),
          Icon(Icons.menu, color: Colors.white),
          SizedBox(width: 16)
        ],
        title: const Text(
          "Page Title",
          style: TextStyle(color: Colors.white),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(20),
          child: Text(
            "Subtitulo",
            style: TextStyle(color: Colors.white70),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 68, 68, 68),
      ),
      body: const PostDetailed(),
      backgroundColor: Colors.grey[900],
    ));
  }
}

class PostDetailed extends StatefulWidget {
  const PostDetailed({super.key});

  @override
  State<StatefulWidget> createState() => _PostDetailedState();
}

class _PostDetailedState extends State<PostDetailed> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [],
    );
  }
}
