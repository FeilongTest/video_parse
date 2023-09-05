import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'index.dart';

class StopPage extends GetView<StopController> {
  const StopPage({Key? key}) : super(key: key);

  Widget buildQunDialog() {
    return AlertDialog(
      title: const Text(
        "温馨提示",
        style: TextStyle(fontSize: 16),
      ),
      content: const Text("加入软件反馈群,第一时间获取最新软件!"),
      actions: [
        InkWell(
          onTap: () async {
            String url =
                "mqqopensdkapi://bizAgent/qm/qr?url=http%3A%2F%2Fqm.qq.com%2Fcgi-bin%2Fqm%2Fqr%3Ffrom%3Dapp%26p%3Dandroid%26jump_from%3Dwebapi%26k%3DqdddsIvoYE62_VOx10qGLThHQTYcYmH3";
            if (await canLaunchUrlString(url)) {
              launchUrlString(url);
            }
          },
          child: const Text("确定"),
        ),
        const SizedBox(
          width: 20,
        ),
        InkWell(
          onTap: () {
            if (Get.isDialogOpen == true) {
              Get.back();
            }
          },
          child: const Text("取消"),
        )
      ],
    );
  }

  // 主视图
  Widget _buildView(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Image.asset('assets/no-connection.gif'),
        Container(
          height: MediaQuery.of(context).size.height / 2.5,
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(60),
              topRight: Radius.circular(60),
            ),
          ),
          child: Column(
            children: [
              const Text(
                "Ooops! 😓",
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "当前版本由于接口升级,已经无法使用，请关注公众号【每日软件推荐】，回复关键词【万能解析】下载最新版本！",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              MaterialButton(
                onPressed: () {
                  controller.gotoWx();
                },
                height: 45,
                padding: const EdgeInsets.symmetric(horizontal: 70),
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Colors.orange.shade400,
                child: const Text(
                  "马上去关注",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StopController>(
      init: StopController(),
      id: "stop",
      builder: (_) {
        return Scaffold(
          body: SafeArea(
            child: _buildView(context),
          ),
        );
      },
    );
  }
}
