// To parse this JSON data, do
//
//     final videoParseModel = videoParseModelFromJson(jsonString);

class VideoParseModel {
  int? status;
  int? code;
  String? msg;
  DateTime? empty;
  Data? data;
  String? type;

  VideoParseModel({
    this.status,
    this.code,
    this.msg,
    this.empty,
    this.data,
    this.type,
  });

  factory VideoParseModel.fromJson(Map<String, dynamic> json) =>
      VideoParseModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        empty: json["解析时间"] == null ? null : DateTime.parse(json["解析时间"]),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "解析时间": empty?.toIso8601String(),
        "data": data?.toJson(),
        "type": type,
      };
}

class Data {
  String? name;
  String? avatar;
  String? title;
  String? cover;
  String? downloadImage;
  String? url;
  String? video;
  String? down;
  Music? music;
  int? duration;
  bool? bigFile;

  Data({
    this.name,
    this.avatar,
    this.title,
    this.cover,
    this.downloadImage,
    this.url,
    this.video,
    this.down,
    this.music,
    this.duration,
    this.bigFile,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["Name"],
        avatar: json["avatar"],
        title: json["title"],
        cover: json["cover"],
        downloadImage: json["download_image"],
        url: json["url"],
        video: json["video"],
        down: json["down"],
        music: json["music"] == null ? null : Music.fromJson(json["music"]),
        duration: json["duration"],
        bigFile: json["bigFile"],
      );

  Map<String, dynamic> toJson() => {
        "Name": name,
        "avatar": avatar,
        "title": title,
        "cover": cover,
        "download_image": downloadImage,
        "url": url,
        "video": video,
        "down": down,
        "music": music?.toJson(),
        "duration": duration,
        "bigFile": bigFile,
      };
}

class Music {
  String? author;
  String? avatar;
  String? url;

  Music({
    this.author,
    this.avatar,
    this.url,
  });

  factory Music.fromJson(Map<String, dynamic> json) => Music(
        author: json["author"],
        avatar: json["avatar"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "author": author,
        "avatar": avatar,
        "url": url,
      };
}
