import 'package:flutter/material.dart';
import 'package:flutter_todo/projects_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          body1: TextStyle(color: Colors.white, fontSize: 28.0),
          body2: TextStyle(color: Colors.white54, fontSize: 14.0),
          caption: TextStyle(color: Colors.white, fontSize: 12.0, fontWeight: FontWeight.bold),
          subhead: TextStyle(color: Colors.black54, fontSize: 12.0),
        )
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
        ProjectsScreen(),
      
    );
  }
}
