import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:video_parse/common/index.dart';

class StopController extends GetxController {
  StopController();

  _initData() {
    update(["stop"]);
  }

  void onTap() {}

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  void gotoWx() async {
    Clipboard.setData(const ClipboardData(text: "每日软件推荐"));
    String url = "weixin://";

    if (await canLaunchUrlString(url)) {
      launchUrlString(url);
    }
    toastInfo(msg: "已帮您复制公众号名称,直接去微信粘贴即可!");
  }
}
