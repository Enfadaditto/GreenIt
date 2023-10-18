import 'package:flutter/material.dart';
import 'package:my_app/widgets/appbar_widget.dart';
import 'package:my_app/widgets/bottom_navigation_bar_widget.dart';

class Post extends StatefulWidget {
  int currentIndex;

  final String author;
  final String title;
  //final List<Comments> comments;
  //final List<String> steps; //Steps

  Post({
    super.key,
    required this.author,
    required this.title,
    /*required this.steps*/
    required this.currentIndex,
  });

  @override
  State<StatefulWidget> createState() => PostState();
}

class PostState extends State<Post> {
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

    void onTabTapped(int index) {
      setState(() {
        widget.currentIndex = index;
      });
    }

    return MaterialApp(
        home: Scaffold(
      appBar: buildAppBar(context),
      body: PostDetailed(),
      backgroundColor: Colors.grey[900],
    ));
  }
}

class PostDetailed extends StatelessWidget {
  //final List<String> steps;

  //PostDetailed({required this.steps});

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
                //steps.forEach((step) {
                //  StepCard(step.description, step.image);
                //})

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
  final Color color; //remove

  const StepCard(this.text, this.color /*image*/, {super.key});

  @override
  Widget build(BuildContext context) {
    //TODO: once we can extract images from the server, we need to investigate how to display them here
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
