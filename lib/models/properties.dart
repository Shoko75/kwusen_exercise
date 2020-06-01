import 'package:flutter/foundation.dart';

class Properties {
  final String name;
  final String color;

  Properties({this.name, this.color});

  // Create properties which contain name and color
  factory Properties.fromJson(Map<dynamic,dynamic> parsedJson) {
   return Properties(
       name : parsedJson['Name'],
       color : parsedJson['color']
   );
  }
}