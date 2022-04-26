import 'package:get/get.dart';

import 'parents/model.dart';

class Notification extends Model {
  String id;
  String type;
  Map<String, dynamic> data;
  bool read;
  DateTime createdAt;

  Notification();

  Notification.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    var attribute = 'type';
    type = stringFromJson(json, attribute);
    data = mapFromJson(json, 'data');
    read = boolFromJson(json, 'read_at');
    createdAt = dateFromJson(json, 'created_at', defaultValue: DateTime.now().toLocal());
  }

  Map markReadMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["read_at"] = !read;
    return map;
  }

  @override
  Map<String, dynamic> toJson() {
    throw UnimplementedError();
  }

  String getMessage() {
    var other = 'App\\Notifications\\NewMessage';
    if (type == other) {
      var tr2 = type.tr;
      return data['from'] + ' ' + tr2;
    } else {
      var tr;
      return type.tr;
    }
  }
}
