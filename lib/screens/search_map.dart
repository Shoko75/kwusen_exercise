import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:kwusenexercise/models/place_info.dart';
import 'package:kwusenexercise/services/widget_maker_service.dart';
import 'package:provider/provider.dart';
import 'package:latlong/latlong.dart';

class SearchMap extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final widgetMakerService = WidgetMakerService();
    final placeInfoModel = PlaceInfo();
    var mapController = MapController();
    var placeInfoBounds = List<PlaceInfo>();
    var isInitialized = false;

    // When the initial load, calculate bounds to contain all polygons.
    void _positionChange(MapPosition coordinate, bool flg) {
      if (!isInitialized) {
        var bounds = (placeInfoBounds != null) ? widgetMakerService.createBonds(placeInfoBounds) : LatLngBounds();
        mapController.fitBounds(
          bounds,
          options: FitBoundsOptions(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
          ),
        );
        isInitialized = true;
      }
    }

    // When tapped new place on the map, do those processes which get the place data from API and calculate bounds.
    void _handleTap(LatLng coordinate) async {

      // Set place info based on new location.
      await placeInfoModel.setPList(coordinate.latitude,coordinate.longitude);

      // Calculate the scale to zoom out based to contain all polygons
      var bounds = (placeInfoModel.pList.isNotEmpty) ? widgetMakerService.createBonds(placeInfoModel.pList) : null;
      if (bounds != null) {
        mapController.fitBounds(
          bounds,
          options: FitBoundsOptions(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
          ),
        );
      }
    }

    return ChangeNotifierProvider<PlaceInfo>.value(
      value: placeInfoModel,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Kwusen map'),),
        body: Consumer<PlaceInfo>(
          builder: (_, placeInfo, __){
            if (!isInitialized) {
              placeInfo.setPList(48.427920, -123.358090); // Initial location
            }
            // Create polygons
            var polygons = (placeInfo.pList != null && placeInfo.pList.isNotEmpty) ? widgetMakerService.createPolygons(placeInfo.pList) : new PolylineLayerOptions();

            // Create Information contents
            List<TextSpan> textContents = [];
            if (placeInfo.pList != null && placeInfo.pList.isNotEmpty ) {
              textContents = widgetMakerService.createText(placeInfo.pList);
            } else {
              textContents.add(TextSpan(text: 'No information. Select different place.'));
            }
            placeInfoBounds = placeInfo.pList;

            return (placeInfo.pList != null) ? SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 1.8,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: new FlutterMap(
                          mapController: mapController,
                          options: new MapOptions(
                              onPositionChanged: _positionChange,
                              onTap: _handleTap,
                          ),
                          layers: [
                            new TileLayerOptions(
                                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                subdomains: ['a', 'b', 'c']
                            ),
                          polygons,
                          ],
                        ),
                      ),
                    ),
                  ),
                  RichText(
                  text: TextSpan(
                    text:'Information \n',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                    children: textContents,
                  )),
                ],
              ),
            ): Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}