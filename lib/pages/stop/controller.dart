import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:video_parse/common/index.dart';

class StopController extends GetxController {
  StopController();

  _initData() {
    update(["stop"]);
  }

  Future<void> onTap() async {
    String url =
        "mqqopensdkapi://bizAgent/qm/qr?url=http%3A%2F%2Fqm.qq.com%2Fcgi-bin%2Fqm%2Fqr%3Ffrom%3Dapp%26p%3Dandroid%26jump_from%3Dwebapi%26k%3DqdddsIvoYE62_VOx10qGLThHQTYcYmH3";
    if (await canLaunchUrlString(url)) {
      launchUrlString(url);
    }
  }

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
