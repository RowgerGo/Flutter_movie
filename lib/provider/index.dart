import 'package:flutter/material.dart' show BuildContext;
import 'package:provider/provider.dart' show ChangeNotifierProvider, MultiProvider, Consumer, Provider;
import 'counter.dart' show CounterModel;
import 'local_video_store.dart' show LocalVideoStore;

export 'counter.dart' show CounterModel;
export 'local_video_store.dart' show LocalVideoStore;

class Store{
  static BuildContext context;
  static BuildContext widgetCtx;

  static init({context,child}){
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_)=>CounterModel()),
        ChangeNotifierProvider(builder: (_)=>LocalVideoStore()),
      ],
      child: child,
    );
  }

  //  通过Provider.value<T>(context)获取状态数据 会引起页面的整体刷新，如果全局是页面级别的
  static T value<T>(context,{bool listen=true}) {
    return Provider.of(context,listen: listen);
  }

  //  通过Consumer获取状态数据  只刷新了 Consumer 的部分，极大地缩小你的控件刷新范围
  static Consumer connect<T>({builder, child}) {
    return Consumer<T>(builder: builder, child: child);
  }

}