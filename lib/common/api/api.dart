import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:video_parse/common/index.dart';

class API {
  Dio dio = Dio();

  //解析
  Future<VideoParseModel?> parseUrl(String url) async {
    var timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    var encypted =
        md5.convert(utf8.encode("$url${timestamp}e0u6fnlag06lc3pl")).toString();
    late Response response;
    try {
      response = await dio.get(
          "https://api.shanghaierma.cn:8000/api/app/watermark_num/get_url?url=$url",
          options: Options(
              headers: Map.from({
            "Authorization": "",
            "data": encypted,
            "timestamp": timestamp,
            "Host": "api.shanghaierma.cn:8000",
            "User-Agent": "okhttp/4.5.0",
          })));
      return VideoParseModel.fromJson(json.decode(response.toString()));
    } catch (e) {
      return null;
    }
  }
}
