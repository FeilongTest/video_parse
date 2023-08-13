import 'package:get/get.dart';
import 'package:video_parse/common/index.dart';
import 'package:video_parse/pages/splash/index.dart';

import '/pages/home/index.dart';
import 'names.dart';

class RoutePages {
  // 列表
  // static List<GetPage> list = [];
  // 列表
  static final List<GetPage> routes = [
    GetPage(name: RouteNames.main, page: (() => const SplashPage())),
    GetPage(name: RouteNames.home, page: (() => const HomePage())),
  ];
}
