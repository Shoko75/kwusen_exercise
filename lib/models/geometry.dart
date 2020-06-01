import 'package:kwusenexercise/models/coordinates.dart';

class Geometry {
  final Coordinates coordinates;

  Geometry({this.coordinates});

  // Create geometry data which contain a list of coordinates
  factory Geometry.fromJson(Map<dynamic, dynamic> parsedJson) {
    return Geometry(coordinates : Coordinates.fromJson(parsedJson['coordinates']));
  }
}