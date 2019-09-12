import 'dart:io';
import 'dart:convert';
import 'package:chewie/chewie.dart';
import 'package:chewie/src/chewie_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_app/model/movie.dart';
import 'package:flutter_app/model/message.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:shared_preferences/shared_preferences.dart';

class video_player_view extends StatefulWidget {
  final Movice movice;
  bool isLocalMovice = false;

  video_player_view({Key key, this.movice, this.isLocalMovice})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return _video_player_viewState();
  }
}

class _video_player_viewState extends State<video_player_view> {
  TargetPlatform _platform;
  TextEditingController roomNumController = TextEditingController();
  VideoPlayerController _videoPlayerController;

  ChewieController _chewieController;
  double _voice = 0.2;
  double value = 200.0;
  File file;
  Map messageMap = {
    'email': 'php_echo@163.com',
    'username': '罗杰',
    'message': 'message'
  };
  var _channel = IOWebSocketChannel.connect("ws://118.24.126.15:8226/ws");
  String room;
  String username;

  @override
  void initState() {
    this.getLocal();
    super.initState();
    if (widget.isLocalMovice) {
      file = new File(widget.movice.url);
      // 读取本地视频
      _videoPlayerController = VideoPlayerController.file(file);
    } else {
      //读取网络视频
      //http://144.34.214.193/media/[电影天堂www.dy2018.com]猖獗HD高清韩语中字.mkv
      _videoPlayerController = VideoPlayerController.network(widget.movice.url);
    }

    _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        aspectRatio: 3 / 2,
        autoPlay: false,
        looping: true);
    _chewieController.setVolume(_voice);

    _channel.stream.listen((message) {
      //  channel.sink.add("received!");
      try {
        Map messageMap = json.decode(message);
        var _message = Message.fromJson(messageMap);
        HandlerMessage(_message);
      } catch (e) {
        print(e);
      }
      print(message);
    });
  }

  // 处理收到消息之后的操作
  void HandlerMessage(Message message) {
    print("接收到消息");
    if (message.type == "synchro_order") {
      if (message.username != username) {
        _videoPlayerController.position.then((_time) {
          String _s =
              '{"room":"$room","username":"$username","message":"$_time","type":"synchro_time"}';
          _channel.sink.add(_s);
        });
      }
    }
    if (message.type == "synchro_time") {
      if (message.username != username) {
        //  如果接受到了synchro_time类型的消息，并且发送人不是自己，就开始执行同步视频时间的操作
        var _m = message.message;
        Duration time = Duration(
            hours: int.parse(_m.substring(0, 1)),
            minutes: int.parse(_m.substring(2, 4)),
            seconds: int.parse(_m.substring(5, 7)),
            microseconds: int.parse(_m.substring(8, 14)));
        _videoPlayerController.seekTo(time);
      }
    }
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();

    _chewieController.dispose();
    _channel.sink.close(status.goingAway);
    super.dispose();
  }

  Future<void> getLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final _room = prefs.getString('room') ?? null;
    final _username = prefs.getString('username') ?? null;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('欢迎亲爱的$_username进入$_room号房间'),
            ));
    setState(() {
      room = _room.toString();
      username = _username;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Chewie(
                controller: _chewieController,
              ),
            ),
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              //已拖动的颜色
              activeTrackColor: Colors.greenAccent,
              //未拖动的颜色
              inactiveTrackColor: Colors.green,
              //提示进度的气泡的背景色
              valueIndicatorColor: Colors.green,
              //提示进度的气泡文本的颜色
              valueIndicatorTextStyle: TextStyle(
                color: Colors.white,
              ),
              //滑块中心的颜色
              thumbColor: Colors.blueAccent,
              //滑块边缘的颜色
              overlayColor: Colors.white,
              //divisions对进度线分割后，断续线中间间隔的颜色
              inactiveTickMarkColor: Colors.white,
            ),
            child: Slider(
                value: value,
                label: '$_voice',
                min: 0.0,
                max: 1000.0,
                divisions: 5,
                onChanged: (val) {
                  setState(() {
                    value = val.floorToDouble(); //转化成double
                    _voice = value / 1000;
                  });
                  _chewieController.setVolume(_voice);
                }),
          ),
          FlatButton(
            onPressed: () {
              // 获取当前视频播放时长
              String _s =
                  '{"room":"$room","username":"$username","message":"synchro","type":"synchro_order"}';
              _channel.sink.add(_s);
              _videoPlayerController.position.then((_time) {});
            },
            child: Text('同步视频进度'),
          ),
        ],
      ),
    );
  }
}
