import 'package:flutter/foundation.dart';
import 'package:kwusenexercise/models/geometry.dart';
import 'package:kwusenexercise/models/properties.dart';
import 'package:kwusenexercise/services/api_service.dart';

class PlaceInfo with ChangeNotifier {
  final apiService = ApiService();
  Geometry geometry;
  Properties properties;
  List<PlaceInfo> pList;

  PlaceInfo({this.geometry, this.properties});

  // Get place data from API and create pList which is a list of PlaceInfo
  // End of this method, change notification is going to send to consumers.
  void setPList(double lat, double lng) async {
    await apiService.getPlaceInfo(lat, lng).then((value) => {
      this.pList = value.map((placeInfo) => PlaceInfo.fromJson(placeInfo)).toList(),
      notifyListeners()
    });
  }

  // Create placeInfo which contains properties and geometry.
  factory PlaceInfo.fromJson(Map<dynamic,dynamic> parsedJson) {
    return PlaceInfo(
      properties : Properties.fromJson(parsedJson['properties']),
      geometry : Geometry.fromJson(parsedJson['geometry']),
    );
  }
}