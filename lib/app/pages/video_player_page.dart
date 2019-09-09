import 'package:chewie/chewie.dart';
import 'package:chewie/src/chewie_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
class video_player_view extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _video_player_viewState();
  }


}


class _video_player_viewState extends State<video_player_view>{
  TargetPlatform _platform;
  VideoPlayerController _videoPlayerController1;
  VideoPlayerController _videoPlayerController2;
  ChewieController _chewieController;
  double _voice=0.2;
  double value = 0.0;

  @override
  void initState(){
    super.initState();
    //http://144.34.214.193/media/[电影天堂www.dy2018.com]猖獗HD高清韩语中字.mkv
    _videoPlayerController1 = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
    _videoPlayerController2 = VideoPlayerController.network(
        'https://www.sample-videos.com/video123/mp4/480/asdasdas.mp4');
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: true
    );
    _chewieController.setVolume(_voice);
  }
  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _videoPlayerController2.dispose();
    _chewieController.dispose();
    super.dispose();
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
                color:Colors.white,
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
                onChanged: (val){
                  setState(() {
                    value = val.floorToDouble();//转化成double
                    _voice=value/1000;
                  });
                  _chewieController.setVolume(_voice);
                }
            ),
          )
        ],
      ),
    );
  }

}