import 'dart:async';
import 'package:flutter/material.dart';

import 'local_video_page.dart';

class person_view extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            FlatButton(
              onPressed: () {
                //_chewieController.enterFullScreen();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>local_video_page()));
              },
              child: Text('查看本地缓存视频'),
            ),
            Text('个人中心'),
            Text('个人中心')
          ],
        ),
      ),
    );
  }
}
