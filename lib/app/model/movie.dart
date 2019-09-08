import 'dart:convert';
import 'package:meta/meta.dart';

class Movice{
  final String title;
  final String size;
  final String url;
  final String img;
  Movice({
      @required this.title,
      @required this.size,
      @required this.url,
      @required this.img,
  });

  static List<Movice> fromJson(String json){
    List<Movice> _movice=[];

    JsonDecoder decoder=new JsonDecoder();
    var mapdata=decoder.convert(json)['list'];
     mapdata.forEach((obj){
       Movice mo = new Movice(
           title: obj['title'],
           size:  obj['size'],
           url:  obj['url'],
           img:  obj['img']);
       _movice.add(mo);
     });
     return _movice;
  }
}