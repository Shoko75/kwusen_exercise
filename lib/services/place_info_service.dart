import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

  // Create Polygons for showing on the map
  List<Polyline> createPolygons(List<PlaceInfo> places) {
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

  // Create text box to show information
  List<TextSpan> createText(List<PlaceInfo> places) {
    List<TextSpan> textContens = List<TextSpan>();

    places.forEach((place) {
      var icon = TextSpan(
        text: '■',
        style: TextStyle(color: Hexcolor(place.properties.color), fontSize: 20),
      );
      textContens.add(icon);
      var text = TextSpan(
        text: '${place.properties.name} \n',
        style: TextStyle(color: Colors.black, fontSize: 20),
      );
      textContens.add(text);
    });

    return textContens;
  }
}