import 'package:kwusenexercise/models/geometry.dart';
import 'package:kwusenexercise/models/properties.dart';

class PlaceInfo {
  Geometry geometry;
  Properties properties;

  PlaceInfo({this.geometry, this.properties});

  factory PlaceInfo.fromJson(Map<dynamic,dynamic> parsedJson) {

    var list = Geometry.fromJson(parsedJson['geometry']);
    return PlaceInfo(
      properties : Properties.fromJson(parsedJson['properties']),
      geometry : Geometry.fromJson(parsedJson['geometry']),
    );
  }
}