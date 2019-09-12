import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app/splash.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_app/HomePage.dart';
import 'package:flutter_app/data_type.dart';

//void main() => runApp(MyApp());
void main() {

  String sDCardDir;

  Future<void> setLocal(s) async{
    final prefs = await  SharedPreferences.getInstance();
    prefs.setString('sDCardDir', s);
  }

  Future<void> getSDCardDir() async {
    sDCardDir = (await getExternalStorageDirectory()).path;
    await setLocal(sDCardDir);
  }


  // Permission check
  Future<void> getPermission() async {
    bool permission1 = await SimplePermissions.checkPermission(Permission.ReadExternalStorage);
    bool permission2 = await SimplePermissions.checkPermission(Permission.WriteExternalStorage);
    if (!permission1) {
      await SimplePermissions.requestPermission(Permission.ReadExternalStorage);
    }
    if (!permission2) {
      await SimplePermissions.requestPermission(Permission.WriteExternalStorage);
    }
    await getSDCardDir();
  }

  Future.wait([getPermission()]).then((result) {
    runApp(MyApp(sDCardDir: sDCardDir));
  });

}
class MyApp extends StatelessWidget {
  MyApp({@required this.sDCardDir});

  final String sDCardDir;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter必备',
      theme: ThemeData(
        primaryIconTheme: const IconThemeData(color: Colors.white),
        brightness: Brightness.light,
        primaryColor: new Color.fromARGB(255, 0, 215, 195),
        accentColor: Colors.cyan[300]
      ),
      home: SplashPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            DataType()
          ],
        ),
      ),
    );
  }
}
