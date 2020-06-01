import 'package:latlong/latlong.dart';

class Coordinates {
  var points = <LatLng>[];

  Coordinates({this.points});

  // Create list of coordinate from the json data
  factory Coordinates.fromJson(List<dynamic> parsedJson) {
    var pointsList = <LatLng>[];

    for ( List<dynamic> coordinate in parsedJson[0]) {
      pointsList.add(LatLng(coordinate[1].toDouble(),coordinate[0].toDouble()));
    }
    return Coordinates(
      points: pointsList
    );
  }
}