import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

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

  void bind (){

    if(usernameController.text==''){
      Fluttertoast.showToast(
          msg: "用户名不可为空",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 16.0
      );
      return;
    }
    if(roomNumController.text==''){
      Fluttertoast.showToast(
          msg: "房间号不可为空",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 16.0
      );
      return;
    }
    setLocal(context,'username', usernameController.text);
    setLocal(context,'room', roomNumController.text);
    Fluttertoast.showToast(
        msg: '绑定成功，用户名为 为 $username,房间号为：$room',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0
    );

  }

  Future<void> setLocal(context, key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
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
    return  Scaffold(
      appBar: AppBar(
        title: Text(
          '登录',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0.4,
        centerTitle: true,
      ),
      backgroundColor: Color(0xfff3f3f3),
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
              onChanged: (Str){
                 setState(() {
                   username=Str;
                 });
              },
            ),
            TextField(
              controller: roomNumController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                labelText: '请输入房间号',
              ),
              autofocus: false,
              onChanged: (Str){
                setState(() {
                  room=Str;
                });
              },
            ),
            FlatButton(
              onPressed: () {
                bind();

              },
              child: Text('绑定用户名和房间号(如已绑定请勿重复绑定)'),
            ),
          ],
        ),
      )
    );
  }
}
