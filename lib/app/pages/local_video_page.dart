import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class local_video_page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return local_video_pageState();
  }
}

class local_video_pageState extends State<local_video_page> {
  String _sDCardDir;
  ScrollController controller = ScrollController();
  Directory parentDir;
  List<double> position = [];
  List<FileSystemEntity> files = [];
  List<FileSystemEntity> files_img = [];

  int count = 0; // 记录当前文件夹中以 . 开头的文件和文件夹

  @override
  void initState() {
    //String sDCardDir = (await getExternalStorageDirectory()).path;
    super.initState();

    getLocal();
    getAllImg('/storage/emulated/0/');
  }

  Future<void> getLocal() async {
    final prefs = await SharedPreferences.getInstance();

    final sDCardDir = prefs.getString('sDCardDir') ?? 0;

    setState(() {
      _sDCardDir = sDCardDir;
      parentDir = Directory(sDCardDir);
    });
    //initDirectory(sDCardDir);
    initDirectory('/storage/emulated/0/');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '本地视频',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0.4,
        centerTitle: true,
      ),
      backgroundColor: Color(0xfff3f3f3),
      body: Scrollbar(child: ListView.builder(
        physics: BouncingScrollPhysics(),
        controller: controller,
        itemCount: files.length != 0 ? files.length : 1,
        itemBuilder: (BuildContext context, int index) {
          if (files.length != 0){
            return buildListViewItem(files[index]);
          }else{
            return Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 2 - MediaQuery.of(context).padding.top - 56.0),
              child: Center(
                child: Text('The folder is empty'),
              ),
            );
          }
        },
      )),
    );
  }

  // 计算文件夹内 文件、文件夹的数量，以 . 开头的除外
  removePointBegin(Directory path) {
    var dir = Directory(path.path).listSync();
    int num = dir.length;

    for (int i = 0; i < dir.length; i++) {
      if (dir[i]
              .path
              .substring(dir[i].parent.path.length + 1)
              .substring(0, 1) ==
          '.') num--;
    }
    return num;
  }

  buildListViewItem(FileSystemEntity file) {
    var isFile = FileSystemEntity.isFileSync(file.path);

    // 去除以 . 开头的文件和文件夹
    if (file.path.substring(file.parent.path.length + 1).substring(0, 1) ==
        '.') {
      count++;
      if (count != files.length) {
        return Container();
      } else {
        return Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 2 -
                  MediaQuery.of(context).padding.top -
                  56.0),
          child: Center(
            child: Text('The folder is empty'),
          ),
        );
      }
    }

    int length = 0;
    if (!isFile) length = removePointBegin(file);

    return InkWell(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                          file.path.substring(file.parent.path.length + 1))),
                  isFile
                      ? Container()
                      : Text(
                          '$length项',
                          style: TextStyle(color: Colors.grey),
                        )
                ],
              ),
              subtitle: isFile
                  ? Text(
                      '${getFileLastModifiedTime(file)}  ${getFileSize(file)}',
                      style: TextStyle(fontSize: 12.0),
                    )
                  : null,
              trailing: isFile ? null : Icon(Icons.chevron_right),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.0),
              child: Divider(
                height: 1.0,
              ),
            )
          ],
        ),
        onTap: () {
          if (!isFile) {
            position.insert(position.length, controller.offset);
            initDirectory(file.path);
            jumpToPosition(true);
          } else {
            // openFile(file.path);
          }
        });
  }

  void jumpToPosition(bool isEnter) {
    if (isEnter)
      controller.jumpTo(0.0);
    else {
      controller.jumpTo(position[position.length - 1]);
      position.removeLast();
    }
  }

  Future<void> initDirectory(String path) async {
    try {
      setState(() {
        //var directory = Directory(path);
        var directory = Directory(path);
        count = 0;
        parentDir = directory;
        print("获取文件列表");
        //files.clear();
        //files = directory.listSync();
        //print(files);
        //print(directory);
      });
    } catch (e) {
      print(e);
      print("Directory does not exist！");
    }
  }

  Future<void> getAllImg(path) async{
    List<FileSystemEntity> _files = [];
    List<FileSystemEntity> _img_files = [];
    //var directory = Directory('/storage/emulated/0/');
    var directory = Directory(path);
    _files.clear();
    _files = directory.listSync();
    print(_files.length);
    for(int i=0;i<_files.length;i++){
      var isFile = FileSystemEntity.isFileSync(_files[i].path);
      if (isFile){
        print("是文件");
        print(_files[i]);
        files.add(_files[i]);
      }else{
        print("不是文件");
        //print(_files[i]);
        getAllImg(_files[i].path);
      }
    }
  }

  isMovice(FileSystemEntity file){
    //String file_type=File(file.resolveSymbolicLinksSync()).
  }

  getFileSize(FileSystemEntity file) {
    int fileSize = File(file.resolveSymbolicLinksSync()).lengthSync();
    if (fileSize < 1024) {
      // b
      return '${fileSize.toStringAsFixed(2)}B';
    } else if (1024 <= fileSize && fileSize < 1048576) {
      // kb
      return '${(fileSize / 1024).toStringAsFixed(2)}KB';
    } else if (1048576 <= fileSize && fileSize < 1073741824) {
      // mb
      return '${(fileSize / 1024 / 1024).toStringAsFixed(2)}MB';
    }
  }

  getFileLastModifiedTime(FileSystemEntity file) {
    DateTime dateTime =
        File(file.resolveSymbolicLinksSync()).lastModifiedSync();

    String time =
        '${dateTime.year}-${dateTime.month < 10 ? 0 : ''}${dateTime.month}-${dateTime.day < 10 ? 0 : ''}${dateTime.day} ${dateTime.hour < 10 ? 0 : ''}${dateTime.hour}:${dateTime.minute < 10 ? 0 : ''}${dateTime.minute}';
    return time;
  }
}
