import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'pages/home_view.dart';
import 'pages/person_view.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  var _currentPage;
  TabController _controller;
  VoidCallback onChanged;

  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
          color: Colors.grey,
        ),
        activeIcon: Icon(
          Icons.home,
          color: Colors.blue,
        ),
        title: Text('首页')),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.person,
          color: Colors.grey,
        ),
        activeIcon: Icon(
          Icons.person,
          color: Colors.blue,
        ),
        title: Text('个人中心'))
  ];
  final List tabBodies = [home_view(), person_view()];

  @override
  void initState() {
    _currentPage=tabBodies[_currentIndex];
    super.initState();
    _controller = new TabController(initialIndex: _currentIndex, length: 2, vsync: this);
    onChanged = () {
      setState(() {
        _currentIndex = this._controller.index;
      });
    };

    _controller.addListener(onChanged);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    TextStyle textStyle = TextStyle(fontSize: 20, color: Colors.greenAccent);
    return MaterialApp(
      title: 'Flutter页面',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
          appBar: AppBar(title: Text('Movies')),
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                  _currentPage=tabBodies[_currentIndex];
                });
              },
              items: bottomTabs
          ),
          body: _currentPage
      ),
    );
  }
}
