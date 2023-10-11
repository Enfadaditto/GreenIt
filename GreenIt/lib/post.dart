import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  const Post({super.key});

  @override
  Widget build(BuildContext context) {
    void _searchPressed() {
      //TODO
      print("SEARCH PRESSED");
    }

    void _menuPressed() {
      //TODO
      print("MENU PRESSED");
    }

    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              onPressed: _searchPressed,
              icon: const Icon(Icons.search, color: Colors.white)),
          IconButton(
              onPressed: _menuPressed,
              icon: const Icon(Icons.menu, color: Colors.white)),
        ],
        title: const Text(
          "Page Title",
          style: TextStyle(color: Colors.white),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(15),
          child: Text(
            "Subtitle",
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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 25),
          SizedBox(
            height: 500,
            child: PageView(
              scrollDirection: Axis.horizontal,
              children: const <Widget>[
                StepCard('Description Red', Colors.red),
                StepCard('Description Blue', Colors.blue),
                StepCard('Description Green', Colors.green),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class StepCard extends StatelessWidget {
  final String text;
  // final Image image;
  final Color color;

  const StepCard(this.text, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          height: 500,
          //child: Image(),
          color: color,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ],
    );
  }
}
