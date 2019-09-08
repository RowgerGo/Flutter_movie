import 'package:flutter/material.dart';
import 'video_player_page.dart';
import 'package:flutter_app/app/model/movie.dart';
import 'package:flutter_app/app/item/movielist_item.dart';

class home_view extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    print("====================");
    return home_viewState();
  }
}

class home_viewState extends State<home_view>{
  List<Movice> _movice = [];

  @override
  void initState(){
    print("========initSate============");
    super.initState();
    getMoviceList();
  }
  void getMoviceList(){
    setState(() {
      _movice=Movice.fromJson("""
         {
          "list":[
            {
              "title":"电锯惊魂",
              "size":"980MB",
              "url":"http://www.baidu.com",
              "img":"http://www.baidu.com"
            },
            {
              "title":"死神来了",
              "size":"760MB",
              "url":"http://www.baidu.com",
              "img":"http://www.baidu.com"
            },
            {
              "title":"鬼来电",
              "size":"1360MB",
              "url":"http://www.baidu.com",
              "img":"http://www.baidu.com"
            }
          ]
        }
      """);
    });
    print("====================");
    var len = _movice.length;
    print('===========_movice.length$len');
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: ListView.builder(
        itemCount: _movice.length,
        itemBuilder: buildMoveItem,
      ),
    );
  }
//  @override
//  Widget build(BuildContext context) {
//
//    return Scaffold(
//      body: Center(
//        child: Column(
//          children: <Widget>[
//            Text('首页'),
//            _item(context,"视频播放页", video_player_view(), 'video')
//          ],
//        ),
//      ),
//    );
//  }

  @override
  Widget buildMoveItem(BuildContext context,int index){
    Movice movice=_movice[index];
    var moviceItem=new InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>video_player_view()));
//        showDialog(context: context,child: AlertDialog(
//          content: Text("敬请期待!d"),
//        ));
      },
      child:MovieListItem(movice) ,
    );
    return moviceItem;
  }
  _item(context,String title,page,String routeName){
    return Container(
      child: RaisedButton(
        onPressed: (){

        },
        child: Text(title),
      ),
    );
  }
}