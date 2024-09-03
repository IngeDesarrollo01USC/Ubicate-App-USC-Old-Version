import 'dart:convert';

import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class UscEvent {
  UscEvent({
    required this.id,
    required this.name,
    required this.startDate,
    required this.country,
    required this.city,
    required this.place,
    this.bannerUrl,
    required this.path,
    required this.eventMode,
  });

  String id;
  String name;
  DateTime startDate;
  String country;
  String city;
  String place;
  String? bannerUrl;
  String path;
  String eventMode;

  factory UscEvent.fromJson(String str) => UscEvent.fromMap(json.decode(str));

  factory UscEvent.fromMap(Map<String, dynamic> json) => UscEvent(
        id: json["id"],
        name: json["name"],
        startDate: DateTime.parse(json["startDate"]),
        country: json["country"],
        city: json["city"],
        place: json["place"],
        bannerUrl: json["bannerUrl"],
        path: json["path"],
        eventMode: json["eventMode"],
      );

  String get startDateString {
    initializeDateFormatting('es_CO', null);
    DateFormat formatter = DateFormat.yMMMMd('es_CO');
    return formatter.format(startDate.toLocal());
  }

  String get startHourString {
    DateFormat formatter = DateFormat.jm();
    return formatter.format(startDate.toLocal());
  }
}
