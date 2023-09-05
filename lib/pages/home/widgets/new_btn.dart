import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/values/colors.dart';
import '../../../common/values/radii.dart';
import '../index.dart';

/// hello
class NewBtnWidget extends GetView<HomeController> {
  const NewBtnWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _buildAnimation(),
    );
  }

  Widget _buildAnimation() {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 5),
      child: Stack(
        children: [_buildBtn1(), _buildMaskBar()],
      ),
    );
  }

  // 遮罩条
  Widget _buildMaskBar() {
    return Obx(() => Positioned(
          left: 0,
          top: 0,
          width: controller.state.downloading
              ? controller.state.progress
              : 0, //控制该值实现进度条控制
          height: 48,
          child: Opacity(
            opacity: 0.6,
            child: Container(
              decoration: const BoxDecoration(color: Colors.white),
            ),
          ),
        ));
  }

  Widget _buildBtn1() {
    return AnimatedBuilder(
      animation: controller.scaleAnimationController,
      builder: (context, child) => Transform.scale(
        scale: controller.scaleAnimation.value,
        child: TextButton(
            style: const ButtonStyle(
                padding: MaterialStatePropertyAll(EdgeInsets.zero)),
            onPressed: () => controller.btnDownloadClicked(),
            child: InkWell(
              child: Container(
                width: controller.screenWidth,
                height: 45,
                decoration: const BoxDecoration(
                    color: AppColors.primaryElement,
                    borderRadius: Radii.k3pxRadius),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Expanded(
                    child: Align(
                        child: Text(
                      "下载视频",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )),
                  ),
                  _downloadIcon(),
                ]),
              ),
            )),
      ),
    );
  }

  Widget _downloadIcon() {
    return AnimatedBuilder(
      animation: controller.fadeAnimationController,
      builder: (context, child) => AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 123, 70, 240),
          borderRadius: Radii.k3pxRadius,
        ),
        width: controller.fadeAnimationController.isCompleted ? 0 : 45,
        height: 45,
        child: AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: controller.fadeAnimation.value,
            child: const Icon(
              Icons.arrow_downward,
              color: Colors.white,
            )),
      ),
    );
  }
}
