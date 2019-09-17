import 'dart:async';
import 'package:flutter/material.dart';
import 'local_video_page.dart';
import 'package:flutter_app/pages/login_page.dart';

// 导入自定义ui
import 'package:flutter_app/component/list_row.dart';


class person_view extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return person_viewState();
  }

}

class person_viewState extends State<person_view> {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            ListRow(
              title: '登录',
              handlerClick: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginPage()));
              },
            ),
            FlatButton(
              onPressed: () {
                //_chewieController.enterFullScreen();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => local_video_page()
                    )
                );
              },
              child: Text('查看本地缓存视频'),
            )
          ],
        ),
      ),
    );

  }

}

