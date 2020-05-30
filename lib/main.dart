import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kwusenexercise/models/place_info.dart';
import 'package:kwusenexercise/screens/search_map.dart';
import 'package:kwusenexercise/services/geolocator_service.dart';
import 'package:kwusenexercise/services/place_info_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final locatorService = GeoLocatorService();
  final placeInfoService = PlaceInfoService();

  @override
  Widget build(BuildContext context) {
    print('print');
    return MultiProvider(
      providers:[
        FutureProvider(create: (context) => locatorService.getLocation()),
        ProxyProvider<Position,Future<List<PlaceInfo>>>(
          update: (context,position,placeInfo){
            return (position != null) ? placeInfoService.getPlaceInfo(position.latitude, position.longitude) :null;
          },
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SearchMap(),
      ),
    );
  }
}