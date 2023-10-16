import 'dart:convert';
import 'dart:ffi';
import 'ServerConnect.dart';
import 'package:flutter/material.dart';
import 'package:my_app/pages/profile.dart';
import 'package:my_app/widgets/bottom_navigation_bar_widget.dart';
import 'post.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Post(
    author: "YO MAMA",
    title: "Dummy Post",
  ));
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});
  
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final serverUrl = "http://localhost:8080/user?email=ida@mail.com";
  
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
      
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue.shade300,
        dividerColor: Colors.black,
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder<String>(
            future: ServerConnect().fetchData(serverUrl),
            // builder: (context, snapshot) {
            //   if (snapshot.connectionState == ConnectionState.waiting) {
            //     return CircularProgressIndicator();
            //   } else if (snapshot.hasError) {
            //     return Text('Error: ${snapshot.error}');
            //   } else {
            //     return Text('Fetched Data: ${snapshot.data}');
            //   }
            // }),
            builder:(context, snapshot) {
              if(snapshot.hasError){
                return Text('Error: ${snapshot.error}');
              }
              else if (snapshot.hasData){
                return Text('Fetched Data: ${snapshot.data}');
              }
              else {
                return Text('Unknown error');
              }
            }),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}