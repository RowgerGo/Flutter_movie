import 'package:flutter/material.dart';
import 'dart:io';


class LocalVideoStore with ChangeNotifier {

  List<FileSystemEntity> _files = [];
  List<FileSystemEntity> get list => _files;

  @override
  void dispose() {
    print("disposedisposedisposedisposedisposedisposedispose");
    super.dispose();
  }

  void clear() {
    _files.clear();
    notifyListeners();
  }

  void add(item) {
    //_count++;
    _files.add(item);
    notifyListeners();
  }
  void set(arr) {
    //_count++;
    _files=List.from(arr);
    print("setsetsetsetsetsetsetsetsetset");
    print(_files);
    print("arrarrarrarrarrarrarrarrarrarrarrarr");
    print(arr);
    notifyListeners();
  }
}