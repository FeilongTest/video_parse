// To parse this JSON data, do
//
//     final videoParseModel = videoParseModelFromJson(jsonString);
class VideoParseModel {
  int? code;
  Data? data;
  String? msg;

  VideoParseModel({
    this.code,
    this.data,
    this.msg,
  });

  factory VideoParseModel.fromJson(Map<String, dynamic> json) =>
      VideoParseModel(
        code: json["code"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data?.toJson(),
        "msg": msg,
      };
}

class Data {
  Content? content;
  String? type;

  Data({
    this.content,
    this.type,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        content:
            json["content"] == null ? null : Content.fromJson(json["content"]),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "content": content?.toJson(),
        "type": type,
      };
}

class Content {
  bool? bigFile;
  String? cover;
  String? down;
  String? downloadImage;
  int? duration;
  List<dynamic>? images;
  String? iv;
  String? title;
  String? url;
  String? video;

  Content({
    this.bigFile,
    this.cover,
    this.down,
    this.downloadImage,
    this.duration,
    this.images,
    this.iv,
    this.title,
    this.url,
    this.video,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        bigFile: json["bigFile"],
        cover: json["cover"],
        down: json["down"],
        downloadImage: json["downloadImage"],
        duration: json["duration"],
        images: json["images"] == null
            ? []
            : List<dynamic>.from(json["images"]!.map((x) => x)),
        iv: json["iv"],
        title: json["title"],
        url: json["url"],
        video: json["video"],
      );

  Map<String, dynamic> toJson() => {
        "bigFile": bigFile,
        "cover": cover,
        "down": down,
        "downloadImage": downloadImage,
        "duration": duration,
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "iv": iv,
        "title": title,
        "url": url,
        "video": video,
      };
}
