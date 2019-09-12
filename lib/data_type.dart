import 'package:flutter/material.dart';

//常用数据类型
class DataType extends StatefulWidget {
  @override
  DataType_State createState() => DataType_State();
}

class DataType_State extends State<DataType> {
  @override
  Widget build(BuildContext context) {
    _numType();
    _stringType();
    _listType();
    return Container(
      child: Text('常用数据类型，查看控制台'),
    );
  }

  //数字类型
  void _numType() {
    num num1 = -1.0; //数字类型父类
    num num2 = 2; //数字类型父类
    int int1 = 3; //只能是整数
    double d1 = 1.62; //双精度
    print("num:$num1 num:$num2 int:$int1 double:$d1");
    print(num1.abs());
  }

  void _stringType() {
    String str1 = '字符串';
  }

  void _listType() {
    List list = [1, 2, 3, 4, 5, 6, '34'];
    List<int> list2 = [1, 2, 3, 4];
    List list3 = [];
    list3.add("2435");
    list3.addAll(list2);
    List list4 = List.generate(10, (index) => index * 3);
    print(list3);
    print(list4);
    for (int i = 0; i < list4.length; i++) {
      print(list4[i]);
    }
    for (var o in list2) {
      print(o);
    }
    list.forEach((val) {
      print(val);
    });
    list.map((i) {
      print(i);
    });
  }

  void _mapType() {
    Map nams = {'xiaoming': '小明', 'xiaohong': '小红'};
  }
}
