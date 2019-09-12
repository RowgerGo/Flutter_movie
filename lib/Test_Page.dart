import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';

class TestPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    TextStyle textStyle = TextStyle(fontSize: 20,color: Colors.greenAccent);

    return MaterialApp(
      title: '梦回',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home:Scaffold(
        appBar: AppBar(title: Text('梦回')),
        body: Container(
          decoration: BoxDecoration(color: Colors.white),
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Text('我是一个Text文本',style: textStyle,)
            ],
          ),
        ),
      ),
    );
  }

}