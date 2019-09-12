import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/HomePage.dart';

class SplashPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=> _SplashState();

}

class _SplashState extends State<SplashPage>{
  Timer _t;

  @override
  void initState(){
   super.initState();
   _t = new Timer(const Duration(milliseconds: 1500), (){
       try{
         Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(
             builder: (BuildContext contxt)=>HomePage()), (Route route)=>route==null);
       }catch(e){

       }
   });
  }

  @override
  void dispose(){
    _t.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Material(
      color: new Color.fromARGB(255, 0, 215, 198),
      child: new Padding(
          padding: const EdgeInsets.only(top: 150.0),
          child: new Column(
            children: <Widget>[
              Text("Movies",
                style: TextStyle(fontSize: 50.0,fontWeight: FontWeight.bold),
              )
            ],
          ),
      ),
    );
  }

}