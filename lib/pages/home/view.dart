import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_parse/common/index.dart';
import 'package:video_parse/global.dart';

import '../../common/values/index.dart';
import 'index.dart';

/*
抖音、快手、小红书、微博、微视、今日头条、西瓜视频、哔哩哔哩、秒拍、美拍、皮皮虾、皮皮搞笑、全民小视频、火山小视频、好看视频、
看点视频、全民K歌、看点视频、看点快报、微视、QQ看点、陌陌、唱吧、YY、小咖秀、糖豆、最左、配音秀、酷狗音乐、酷我音乐、
看看视频、梨视频、网易云音乐、大众点评、虎牙视频、懂车帝、剪映、趣头条、美图秀秀、刷宝、
迅雷、京东、淘宝、天猫、拼多多、微信公众号、火锅视频、轻视频、度小视、 百度视频、QQ浏览器、uc浏览器、oppo浏览器、
油果浏览器、新片场、万能钥匙WiFi、知乎、腾讯新闻、人民日报、开眼、微叭、微云、快看点、TikTok、youtube、twitter、
VUE、vigo、ACfun、now、等80多个短视频去水印和常用图集解析，主页批量支持抖音、快手主页批量解析。

https://www.eeapi.cn/
*/

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  // 主视图
  Widget _buildView() {
    return Container(
      padding: const EdgeInsets.only(top: 14),
      margin: const EdgeInsets.only(bottom: 60),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20, left: 30),
            alignment: Alignment.centerLeft,
            child: const Text(
              "万能解析",
              style: TextStyle(fontSize: 48),
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(30, 20, 30, 10),
            child: Card(
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                child: const Text(
                  "步骤\n1.在视频App或者网页点击分享图标 - 复制链接\n2.打开万能解析APP - 粘贴 - 解析 - 下载",
                  style: TextStyle(height: 2, fontSize: 14),
                ),
              ),
            ),
          ),
          _buildInput(),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(30, 10, 30, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _btn('粘 贴', () {
                  controller.paste();
                }),
                _btn('解 析', () {
                  controller.parse();
                }),
              ],
            ),
          ),
          _downloadBtn(),
          _player(),
        ],
      ),
    );
  }

  Widget _player() {
    return Container(
        width: double.infinity,
        height: 200,
        color: AppColors.primaryElement,
        margin: const EdgeInsets.fromLTRB(30, 20, 30, 30),
        child: FijkView(
          fit: FijkFit.cover,
          player: controller.playerController,
        ));
  }

  Widget _downloadBtn() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(30, 20, 30, 0),
      child: TextButton(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all(const TextStyle(
            fontSize: 16,
          )),
          foregroundColor: MaterialStateProperty.resolveWith(
            (states) {
              if (states.contains(MaterialState.focused) &&
                  !states.contains(MaterialState.pressed)) {
                return Colors.blue;
              } else if (states.contains(MaterialState.pressed)) {
                return Colors.deepPurple;
              }
              return AppColors.primaryElementText;
            },
          ),
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return AppColors.secendPrimaryElement;
            }
            return AppColors.primaryElement;
          }),
          shape: MaterialStateProperty.all(const RoundedRectangleBorder(
            borderRadius: Radii.k6pxRadius,
          )),
        ),
        onPressed: () => controller.download(),
        child: const Text("下 载 视 频"),
      ),
    );
  }

  Widget _btn(String text, VoidCallback tap) {
    return ElevatedButton(
      style: ButtonStyle(
        padding:
            const MaterialStatePropertyAll(EdgeInsets.fromLTRB(60, 0, 60, 0)),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.focused) &&
              !states.contains(MaterialState.pressed)) {
            return Colors.blue;
          } else if (states.contains(MaterialState.pressed)) {
            return Colors.deepPurple;
          }
          return AppColors.primaryElementText;
        }),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return AppColors.secendPrimaryElement;
          }
          return AppColors.primaryElement;
        }),
        shape: MaterialStateProperty.all(const RoundedRectangleBorder(
          borderRadius: Radii.k6pxRadius,
        )),
      ),
      onPressed: tap,
      child: Text(
        text,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Container _buildInput() {
    return Container(
      margin: const EdgeInsets.fromLTRB(30, 20, 30, 20),
      padding: const EdgeInsets.only(left: 30, right: 30),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 5.0), //阴影xy轴偏移量
                blurRadius: 10.0, //阴影模糊程度
                spreadRadius: 0.5 //阴影扩散程度
                )
          ]),
      height: 56,
      child: Center(
        child: TextField(
          controller: controller.urlController,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: '视频链接',
            hintStyle: TextStyle(color: AppColors.thirdElementText),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      id: "home",
      builder: (_) {
        return Scaffold(
          body: SingleChildScrollView(child: _buildView()),
          floatingActionButton: Container(
            padding: const EdgeInsets.only(top: 0),
            child: Obx(() {
              return FloatingActionButton(
                onPressed: () {
                  GlobalService.to.switchThemeModel();
                },
                child: Icon(GlobalService.to.isDarkModel == true
                    ? Icons.dark_mode
                    : Icons.light_mode),
              );
            }),
          ),
        );
      },
    );
  }
}
