// To parse this JSON data, do
//
//     final slotData = slotDataFromJson(jsonString);

import 'dart:convert';

List<SlotData> slotDataFromJson(String str) => List<SlotData>.from(json.decode(str).map((x) => SlotData.fromJson(x)));

String slotDataToJson(List<SlotData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SlotData {
  SlotData({
    this.day,
    required this.slotArray,
  });

  String? day;
  List<SlotArray> slotArray;

  factory SlotData.fromJson(Map<String, dynamic> json) => SlotData(
        day: json["day"],
        slotArray: json["slot_array"] == null ? [] : List<SlotArray>.from(json["slot_array"]!.map((x) => SlotArray.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "slot_array": List<dynamic>.from(slotArray.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return "day: '$day' slotArray: $slotArray";
  }
}

class SlotArray {
  SlotArray({
    this.position,
    this.time,
  });

  int? position;
  DateTime? time;

  factory SlotArray.fromJson(Map<String, dynamic> json) => SlotArray(
        position: json["position"],
        time: json["time"] == null ? null : DateTime.parse(json["time"]),
      );

  Map<String, dynamic> toJson() => {
        "position": position,
        "time": time?.toIso8601String(),
      };

  @override
  bool operator ==(Object other) => identical(this, other) || other is SlotArray && runtimeType == other.runtimeType && position == other.position;

  @override
  int get hashCode => position.hashCode;

  @override
  String toString() {
    return "$position";
  }

  String toTime() {
    return "$time";
  }
}
