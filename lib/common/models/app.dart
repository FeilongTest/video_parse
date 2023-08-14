import 'dart:convert';

AppModel appModelFromJson(String str) => AppModel.fromJson(json.decode(str));

String appModelToJson(AppModel data) => json.encode(data.toJson());

class AppModel {
  String? key;

  AppModel({
    this.key,
  });

  factory AppModel.fromJson(Map<String, dynamic> json) => AppModel(
        key: json["key"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
      };
}
