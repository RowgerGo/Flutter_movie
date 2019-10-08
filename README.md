# 用flutter开发的app，用于和异地恋女友一起看电影
本来是使用微光的，但是体验特别不好。
- 微光上资源比较少，如果想上传资源还得去申请资质，很麻烦
- 微光不能播放本地视频
- 微光上两个人视频播放经常不能同步，就是一个人会快几秒，一个人慢几秒
我预估是如果是播放网络视频，自己用flutter播放的时候也会存在这个问题，毕竟两个人网络环境不同，硬件解码能力不同，而且还要去研究怎样边下边播，
所以把重点放在了播放本地视频上，这样就解决了网络下载问题，直接两个人下载好，然后使用App来搜索本地视频，进入房间之后，一人点击播放，零一人也
开始播放，点击同步按钮，同步两人播放进度。使用websocket协议来进行同步

### 参考资料
- flutter 文件管理 https://www.jianshu.com/p/a332a20c4ddf
- flutter 文件管理github： https://github.com/huang-weilong/flutter_file_manager
### websocket 端口地址 118.24.126.15:8226/ws
```json
{
"room": "123",
"type": "1",
"username": "username",
"message": "message"
}
```
### 状态管理```provider```
- https://pub.dev/packages/provider#-changelog-tab-
- 示例教程：  https://juejin.im/post/5d2c19c6e51d4558936aa11c#heading-8