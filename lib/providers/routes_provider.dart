import 'dart:convert';

import 'package:flutter/services.dart';

class RoutesProvider {
  List<dynamic> route = [];

  RoutesProvider();

  Future<List<dynamic>> getRouteByName(String entry, String destination) async {
    final resp = await rootBundle.loadString('data/coordinates.json');

    Map dataMap = json.decode(resp);
    String routeName = entry + "-" + destination;
    route = dataMap[routeName];
    return route;
  }
}
