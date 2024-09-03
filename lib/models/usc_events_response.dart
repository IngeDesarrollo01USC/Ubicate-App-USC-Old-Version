import 'dart:convert';

import 'usc_event.dart';

class UscEventsResponse {
  UscEventsResponse({
    required this.items,
  });

  List<UscEvent> items;

  factory UscEventsResponse.fromJson(String str) =>
      UscEventsResponse.fromMap(json.decode(str));

  factory UscEventsResponse.fromMap(Map<String, dynamic> json) =>
      UscEventsResponse(
        items:
            List<UscEvent>.from(json["items"].map((x) => UscEvent.fromMap(x))),
      );
}
