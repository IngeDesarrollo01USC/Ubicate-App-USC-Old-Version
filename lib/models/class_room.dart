import 'dart:convert';

class ClassRoom {
  ClassRoom({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory ClassRoom.fromJson(String str) => ClassRoom.fromMap(json.decode(str));

  factory ClassRoom.fromMap(Map<String, dynamic> json) => ClassRoom(
        id: json["id"].toString().toLowerCase(),
        name: json["name"],
      );
}
