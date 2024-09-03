import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ubicate_usc/models/models.dart';

class ClassroomProvider extends ChangeNotifier {
  ClassroomProvider();

  Future<List<ClassRoom>> searchRoom(String query) async {
    final resp = await rootBundle.loadString('data/classrooms.json');
    Iterable jsonArray = jsonDecode(resp);
    List<ClassRoom> list =
        List<ClassRoom>.from(jsonArray.map((e) => ClassRoom.fromMap(e)));

    List<ClassRoom> listRooms =
        list.where((e) => e.id.contains(query.toLowerCase())).toList();

    return listRooms;
  }
}
