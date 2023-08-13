import 'dart:io';

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

  //初始化
  Get.put<GlobalService>(GlobalService());

  if (!await Permission.storage.request().isGranted) {
    toastInfo(msg: "没有存储权限!");
    return;
  }

  //启动
  runApp(const MyApp());

  //设置Android状态栏沉浸，写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
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
