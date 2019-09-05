import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';

class TestPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: '第一个Flutter页面',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home:Scaffold(
        appBar: AppBar(title: Text('第一个Flutter页面')),
        body: Container(
          decoration: BoxDecoration(color: Colors.white),
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Text('我是一个Text文本')
            ],
          ),
        ),
      ),
    );
  }

}