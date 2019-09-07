import 'package:flutter/material.dart';
import 'splash.dart';

import 'package:flutter_app/app/HomePage.dart';
import 'package:flutter_app/app/data_type.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter必备',
      theme: ThemeData(
        primaryIconTheme: const IconThemeData(color: Colors.white),
        brightness: Brightness.light,
        primaryColor: new Color.fromARGB(255, 0, 215, 195),
        accentColor: Colors.cyan[300]
      ),
      home: SplashPage(),
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
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            DataType()
          ],
        ),
      ),
    );
  }
}
