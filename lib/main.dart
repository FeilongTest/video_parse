import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:fl_umeng/fl_umeng.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_parse/common/index.dart';

import 'global.dart';

void main() {
  appInit();
}

appInit() async {
  // 初始化 flutter 引擎
  WidgetsFlutterBinding.ensureInitialized();
  await permission();
  //初始化
  Get.put<GlobalService>(GlobalService());
  await [Permission.storage].request();

  // 注册友盟 统计 性能检测
  await FlUMeng().init(
      androidAppKey: '65d4a29495b14f599d283c1f',
      iosAppKey: '',
      channel: 'Umeng');

  //启动
  runApp(const MyApp());

  //设置Android状态栏沉浸，写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

permission() async {
  //android13 权限问题 https://developer.android.com/training/data-storage/shared/media?hl=zh-cn#storage-permission
  //参考2：https://github.com/Baseflow/flutter-permission-handler/issues/995
  //android 13版本无需申请对应权限即可操作自身文件夹
  DeviceInfoPlugin plugin = DeviceInfoPlugin();
  AndroidDeviceInfo android = await plugin.androidInfo;
  if (android.version.sdkInt < 33) {
    if (!await Permission.storage.request().isGranted) {
      toastInfo(msg: "请手动打开存储权限");
      await openAppSettings();
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme:
          GlobalService.to.isDarkModel == true ? AppTheme.dark : AppTheme.light,
      initialRoute: RouteNames.main,
      getPages: RoutePages.routes,
      //国际化需要导入国际化包 flutter_localizations
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('zh', 'CN'),
        Locale('en', 'US'),
      ],
    );
  }
}
