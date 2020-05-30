import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kwusenexercise/models/place_info.dart';
import 'package:kwusenexercise/services/place_info_service.dart';
import 'package:latlong/latlong.dart';
import 'package:provider/provider.dart';

class SearchMap extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final currentPosition = Provider.of<Position>(context);
    final placeInfoProvider = Provider.of<Future<List<PlaceInfo>>>(context);
    final placeInfoService = PlaceInfoService();

    return FutureProvider(
      create: (context) => placeInfoProvider,
      child: Scaffold(
        body: (currentPosition != null) ? Consumer<List<PlaceInfo>>(
          builder: (_, placeInfo, __){
            var polygons = (placeInfo != null) ? placeInfoService.createPolygons(placeInfo) : new Polyline();
            return (placeInfo != null) ? Center(
              child: new FlutterMap(
                options: new MapOptions(
                    center: new LatLng(currentPosition.latitude,currentPosition.longitude),
                    zoom: 8.0
                ),
                layers: [
                  new TileLayerOptions(
                      urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c']
                  ),
                  new PolylineLayerOptions(
                      polylines: polygons,
                  ),
                ],
              ),
            ): CircularProgressIndicator();
          },
        ): CircularProgressIndicator(),
      ),
    );
  }
}
