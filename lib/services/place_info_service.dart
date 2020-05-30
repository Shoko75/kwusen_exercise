import 'package:flutter/foundation.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kwusenexercise/models/place_info.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PlaceInfoService {

  Future<List<PlaceInfo>> getPlaceInfo(double lat, double lng) async {
    var responce = await http.get('https://native-land.ca/api/index.php?maps=languages,territories,treaties&position=$lat,$lng');
    var json = convert.jsonDecode(responce.body) as List;
    return json.map((placeInfo) => PlaceInfo.fromJson(placeInfo)).toList();
  }

  List<Polyline> createPolygons(List<PlaceInfo> places){
    var polygons = List<Polyline>();

    places.forEach((place) {
      Polyline polygon = new Polyline(
          points: place.geometry.coordinates.points,
          strokeWidth: 2.0,
          color: Hexcolor(place.properties.color),
      );

      polygons.add(polygon);
    });

    return polygons;
  }
}