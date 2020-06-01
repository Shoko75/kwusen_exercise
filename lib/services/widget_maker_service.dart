import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kwusenexercise/models/place_info.dart';
import 'package:latlong/latlong.dart';

class WidgetMakerService {

  // Create Polygons for showing on the map from the list of placeInfo and return PolylineLayerOptions
  PolylineLayerOptions createPolygons(List<PlaceInfo> places) {
    var polygons = List<Polyline>();

    places.forEach((place) {
      Polyline polygon = new Polyline(
        points: place.geometry.coordinates.points,
        strokeWidth: 2.0,
        color: Hexcolor(place.properties.color),
      );

      polygons.add(polygon);
    });

    var polylineLayerOptions = new PolylineLayerOptions(polylines: polygons);

    return polylineLayerOptions;
  }

  // Create content to show on the information text field and return list of TextSpan.
  List<TextSpan> createText(List<PlaceInfo> places) {
    List<TextSpan> textContents = List<TextSpan>();

    places.forEach((place) {
      var icon = TextSpan(
        text: '■',
        style: TextStyle(color: Hexcolor(place.properties.color), fontSize: 20),
      );
      textContents.add(icon);
      var text = TextSpan(
        text: '${place.properties.name} \n',
        style: TextStyle(color: Colors.black, fontSize: 20),
      );
      textContents.add(text);
    });

    return textContents;
  }

  // Create bounds from list of coordinates and return bounds.
  LatLngBounds createBonds(List<PlaceInfo> places) {
    var bounds = LatLngBounds();

    places.forEach((place) {
      place.geometry.coordinates.points.forEach((coordinate) {
        bounds.extend(coordinate);
      });
    });

    return bounds;
  }
}