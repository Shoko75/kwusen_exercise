import 'package:kwusenexercise/models/coordinates.dart';

class Geometry {
  final Coordinates coordinates;

  Geometry({this.coordinates});

  factory Geometry.fromJson(Map<dynamic, dynamic> parsedJson) {
      return Geometry(
        coordinates : Coordinates.fromJson(parsedJson['coordinates']));
      }
}