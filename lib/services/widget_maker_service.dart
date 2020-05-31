import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kwusenexercise/models/place_info.dart';
import 'package:latlong/latlong.dart';

class WidgetMakerService {
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

  LatLngBounds createBonds(List<PlaceInfo> places) {
    var bounds = LatLngBounds();

    places.forEach((place) {
      place.geometry.coordinates.points.forEach((coordinate) {
        bounds.extend(coordinate);
      });
    });

    return bounds;
  }

  LatLng centroid(List<LatLng> points) {
    List<double> centroid = [0.0,0.0];

    for (int i = 0; i < points.length; i++) {
      centroid[0] += points[i].latitude;
      centroid[1] += points[i].longitude;
    }

    int totalPoints = points.length;
    centroid[0] = centroid[0] / totalPoints;
    centroid[1] = centroid[1] / totalPoints;

    var latLng = new LatLng(centroid[0],centroid[1]);
    return latLng;
  }
}