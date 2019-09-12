import 'dart:async';
import 'package:flutter/material.dart';
import 'local_video_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class person_view extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return person_viewState();
  }

}

class person_viewState extends State<person_view> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController roomNumController = TextEditingController();
  String username;
  String room;
  bool isBind = false;


  @override
  void initState(){
    getLocal('username');
    getLocal('room');
    super.initState();
  }
  getLocal(key) async {
    final prefs = await SharedPreferences.getInstance();
    final _val = prefs.getString(key) ?? null;
    if (key =='username'){
      setState(() {
        username=username;
      });
      print(_val);
    }
    if (key =='room'){
      setState(() {
        username=username;
      });
      print(_val);
    }
  }
  Future<void> setLocal(context, key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
    showDialog(
        context: context,
        builder: (context) => AlertDialog(title: Text('绑定成功，$key 为 $value')));

    if (key=='username'){
      setState(() {
        username=value;
      });
    }
    if (key=='room'){
      setState(() {
        room=value;
      });
    }

  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                labelText: '请输入你的用户名',
              ),
              autofocus: false,
            ),
            TextField(
              controller: roomNumController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                labelText: '请输入房间号',
              ),
              autofocus: false,
            ),
            FlatButton(
              onPressed: () {
                setLocal(context,'username', usernameController.text);
                setLocal(context,'room', roomNumController.text);
              },
              child: Text('绑定用户名和房间号(如已绑定请勿重复绑定)'),
            ),
            FlatButton(
              onPressed: () {
                //_chewieController.enterFullScreen();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => local_video_page()));
              },
              child: Text('查看本地缓存视频'),
            )
          ],
        ),
      ),
    );

  }

}

