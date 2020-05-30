import 'package:latlong/latlong.dart';

class Coordinates {
  var points = <LatLng>[];

  Coordinates({this.points});

  factory Coordinates.fromJson(List<dynamic> parsedJson) {
    var pointsList = <LatLng>[];

    for ( List<dynamic> coordinate in parsedJson[0]) {
      pointsList.add(LatLng(coordinate[1] as double,coordinate[0] as double));
    }
    return Coordinates(
      points: pointsList
    );
  }
}