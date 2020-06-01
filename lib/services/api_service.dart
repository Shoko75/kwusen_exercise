import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ApiService {

  // Get the data from API based on the latitude and the longitude which is passing as the parameters.
  // If the process was the success, return the List of data.
  Future<List<dynamic>> getPlaceInfo(double lat, double lng) async {
    var response = await http.get('https://native-land.ca/api/index.php?maps=languages,territories,treaties&position=$lat,$lng');
    var json = convert.jsonDecode(response.body) as List;

    if (response.statusCode == 200) { // 200 means OK response
      return json;
    } else {
      throw Exception('Failed to load album');
    }
  }
}