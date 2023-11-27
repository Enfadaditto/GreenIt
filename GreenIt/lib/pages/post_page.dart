import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_app/Persistance/RepoPost.dart';
import 'package:my_app/pages/stepper.dart';
import 'package:my_app/widgets/appbar_widget.dart';
import 'package:my_app/Models/Step.dart' as MyStep;

class PostPage extends StatefulWidget {
  int currentIndex;
  String id;
  final String author;
  final String title;
  //final List<Comments> comments;
  //final List<String> steps; //Steps

  PostPage({
    super.key,
    required this.author,
    required this.title,
    required this.id,
    required this.currentIndex,
  });

  @override
  State<StatefulWidget> createState() => PostState();
}

class PostState extends State<PostPage> {
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
      body: PostDetailed(id: widget.id),
      backgroundColor: Colors.grey[900],
    ));
  }
}

class PostDetailed extends StatelessWidget {
  String placeholderIMG =
      'https://img.freepik.com/vector-gratis/ilustracion-icono-dibujos-animados-fruta-manzana-concepto-icono-fruta-alimentos-aislado-estilo-dibujos-animados-plana_138676-2922.jpg?w=2000';
  List<MyStep.Step?> steps = [];
  String id;

  PostDetailed({required this.id});

  Future<void> fetchSteps() async {
    steps = await RepoPost().getListSteps(id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchSteps(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: const CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text("Ha habido un error");
        } else {
          return Container(
      // width: double.infinity,
      height: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
              child: Center(
            child: Container(
              child: MyStepper(steps: steps),
            ),
          )),
          //const SizedBox(height: 25),
          SizedBox(
            height: 500,
            child: /* PageView(
              scrollDirection: Axis.horizontal,
              children: [
                /* steps.forEach((step) {
                  StepCard(step!.description, step.image);
                }) */

                StepCard(steps[0]!.getDescription(), steps[0]!.getImage()),
                StepCard('Description Blue', placeholderIMG),
                StepCard('Description Green', placeholderIMG),
              ],
            ), */
            PageView.builder(
              itemCount: steps.length,
              itemBuilder: (context, index) {
                return StepCard(steps[index]!.getDescription(), steps[index]!.getImage());
              },
            )
          )
        ],
      ),
    );
        }
      },
    );
    
  }
}

class StepCard extends StatelessWidget {
  String text;
  String? imagen;

  StepCard(this.text, this.imagen, {super.key});

  @override
  Widget build(BuildContext context) {
    //TODO: once we can extract images from the server, we need to investigate how to display them here
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          height: 500,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  text,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              /* imagen ==
                      'https://img.freepik.com/vector-gratis/ilustracion-icono-dibujos-animados-fruta-manzana-concepto-icono-fruta-alimentos-aislado-estilo-dibujos-animados-plana_138676-2922.jpg?w=2000'
                  ? Image(image: NetworkImage(imagen!))
                  : Image.file(File(imagen!)) */
              Image.network(imagen!)
            ],
          ),
        ),
      ],
    );
  }
}
