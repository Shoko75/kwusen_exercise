import 'package:flutter/cupertino.dart';
import 'package:kwusenexercise/models/place_info.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PlaceInfoService {

  Future<List<PlaceInfo>> getPlaceInfo(double lat, double lng) async {
    var responce = await http.get('https://native-land.ca/api/index.php?maps=languages,territories,treaties&position=$lat,$lng');
    var json = convert.jsonDecode(responce.body) as List;
    return json.map((placeInfo) => PlaceInfo.fromJson(placeInfo)).toList();
  }
}