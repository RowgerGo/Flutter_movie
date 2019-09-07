import 'dart:async';
import 'package:flutter/material.dart';
import 'video_player_page.dart';

class home_view extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Text('首页'),
            _item(context,"视频播放页", video_player_view(), 'video')
          ],
        ),
      ),
    );
  }

  _item(context,String title,page,String routeName){
    return Container(
      child: RaisedButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>page));
          },
          child: Text(title),
      ),
    );
  }
}