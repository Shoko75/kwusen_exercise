import 'package:geolocator/geolocator.dart';

class GeoLocatorService {

  // Get the current Location
  Future<Position> getLocation() async {
    var geolocator = Geolocator();
    var permissionStatus = await geolocator.checkGeolocationPermissionStatus();

    // Check whether location service is on or not
    if (permissionStatus != GeolocationStatus.denied) {
      return await geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
          locationPermissionLevel: GeolocationPermission.location);
    }
  }
}