import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_parse/common/api/api.dart';
import 'package:video_parse/pages/home/state.dart';
import 'package:video_parse/pages/stop/index.dart';

import '../../common/models/videoparse.dart';
import '../../common/utils/http.dart';
import '../../common/widgets/toast.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  // url的控制器
  final TextEditingController urlController = TextEditingController();

  final FijkPlayer playerController = FijkPlayer();

  var currentVideoTrueUrl = "";

  //获取屏幕宽度
  final screenWidth = Get.width - 60;

//=====
//scale 为缩放动画
  late final AnimationController scaleAnimationController;

  late Animation<double> scaleAnimation;

  //fade 为逐渐消失的动画
  late final AnimationController fadeAnimationController;

  late Animation<double> fadeAnimation;

//=====

  final state = HomeState();

  _initData() {
    update(["video_parse"]);
  }

  void onTap() {}

  @override
  void onInit() async {
    super.onInit();

    scaleAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(scaleAnimationController)
      ..addStatusListener((status) async {
        if (status == AnimationStatus.completed) {
          await scaleAnimationController.reverse();
          fadeAnimationController.forward();
          download();
        }
      });

    fadeAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));

    fadeAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(fadeAnimationController);

    debugPrint("onInit");
    checkInfo();
  }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  @override
  void dispose() {
    urlController.dispose();
    playerController.dispose();

    scaleAnimationController.dispose();
    fadeAnimationController.dispose();
    debugPrint("销毁");
    super.dispose();
  }

  // 检查更新
  void checkInfo() async {
    var response = await HttpUtil()
        .get("http://rap2api.taobao.org/app/mock/313572/appapi4");
    if (response != null) {
      var key = response['key'];
      if (key == "gzh") {
        //弹出不可取消的弹窗
        Get.offAll(const StopPage());
      }
    }
  }

  //粘贴
  void paste() async {
    Clipboard.getData(Clipboard.kTextPlain).then((value) {
      if (value == null) {
        //value 为空
      } else {
        urlController.text = value.text.toString();
      }
    });
  }

  //解析
  void parse() async {
    if (urlController.text == "") {
      toastInfo(msg: "请输入解析地址！");
      return;
    }
    if (!urlController.text.contains("http")) {
      toastInfo(msg: "请输入正确的网址！");
      return;
    }
    //解析地址
    String text = urlController.text;
    String regexUrl = r'[a-zA-z]+://[^\s]*';
    String? url = RegExp(regexUrl).stringMatch(text);
    url = url ?? urlController.text;

    //匹配网址

    //小松解析
    //http://www.eeapi.cn/api/video/32174599E83C0D0A1CD62D8A254E5149019A5BD24D4E939652/1032/?url=https://v.douyin.com/iJBbHnab/

    //豆包一键获取主页
    //https://www.345api.cn/api/jiexi/zy?key=wMpPjoyQSUKlZ6w4uBX6zOZykm&url= + url + &max_cursor=1688992223000

    //https://v.douyin.com/iJBVrnHr

    // 皮皮虾 https://tool.icy8.net/api.parser/index?share= 该接口只可以解析皮皮虾
    // var response = await HttpUtil().get(
    //   'https://tool.icy8.net/api.parser/index?share=${urlController.text}',
    // );

    API api = API();
    var result = await api.parseUrl(url);
    if (result != null) {
      if (result.data != null) {
        String videoUrl = result.data!.content!.down.toString();
        videoUrl = Uri.decodeComponent(videoUrl).toString();
        currentVideoTrueUrl = videoUrl;

        await playerController.reset();
        if (videoUrl.contains("bilivideo.com")) {
          //设置header https://fijkplayer.befovy.com/docs/zh/faq.html#gsc.tab=0
          await playerController.setOption(FijkOption.formatCategory, "headers",
              'Host: data.bilibili.com\r\nReferer: https://www.bilibili.com/\r\nUser-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36 Edg/115.0.1901.203');
        }
        await playerController
            .setDataSource(videoUrl, autoPlay: true)
            .catchError((e) {
          Get.snackbar("setDataSource error: ", e);
        });
      } else {
        toastInfo(msg: "解析出错！${result.msg.toString()}");
      }
    } else {
      toastInfo(msg: "请求接口出错!");
    }
  }

  void download() async {
    if (!currentVideoTrueUrl.contains("http")) {
      toastInfo(msg: "当前解析的地址有误,请尝试重新解析!");
      return;
    }
    final parentDir = await getExternalStorageDirectory();
    final dirPath = "${parentDir!.path}${Platform.pathSeparator}video_parse";
    final dir = Directory(dirPath);
    if (await dir.exists()) {
      debugPrint("文件已存在");
    } else {
      await dir.create(recursive: true);
    }
    //目录现在一定存在 开始下载文件
    String savePath =
        "$dirPath${Platform.pathSeparator}${DateTime.now().millisecondsSinceEpoch}.mp4";
    state.progress = 0.0;
    state.downloading = true;

    await HttpUtil().dio.download(currentVideoTrueUrl, savePath,
        onReceiveProgress: (count, total) {
      state.progress = screenWidth * (count / total);
      debugPrint("${(count / total * 100).toStringAsFixed(0)}%");
    });
    final result = await ImageGallerySaver.saveFile(savePath);
    if (result["isSuccess"]) {
      toastInfo(msg: "下载完成,你可以在相册中找到它!");
    } else {
      toastInfo(msg: "下载完成,但是保存到相册失败了!当前下载目录为:$savePath");
    }
    state.downloading = false;
    //fade动画倒转
    fadeAnimationController.reverse();
  }

  //按钮点击事件
  void btnDownloadClicked() async {
    //防止动画开始后点击
    if (state.downloading) {
      return;
    }
    //触发按钮动画 完成时会自动触发下载事件
    scaleAnimationController.forward();
  }
}
