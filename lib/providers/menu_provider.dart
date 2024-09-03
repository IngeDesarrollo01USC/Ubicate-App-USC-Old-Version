import 'dart:convert';

import 'package:flutter/services.dart';

class MenuProvider {
  List<dynamic> options = [];

  MenuProvider();

  Future<List<dynamic>> loadFaculties() async {
    final resp = await rootBundle.loadString('data/menu.json');

    Map dataMap = json.decode(resp);
    options = dataMap['facultades'];
    return options;
  }

  Future<List<dynamic>> loadBuildings() async {
    final resp = await rootBundle.loadString('data/menu.json');

    Map dataMap = json.decode(resp);
    options = dataMap['bloques'];
    return options;
  }

  Future<List<dynamic>> loadCommonAreas() async {
    final resp = await rootBundle.loadString('data/menu.json');

    Map dataMap = json.decode(resp);
    options = dataMap['comunes'];
    return options;
  }
}
