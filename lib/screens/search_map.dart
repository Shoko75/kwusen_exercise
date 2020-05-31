import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kwusenexercise/models/place_info.dart';
import 'package:kwusenexercise/services/widget_maker_service.dart';
import 'package:provider/provider.dart';

class SearchMap extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    final currentPosition = Provider.of<Position>(context);
    final placeInfoProvider = Provider.of<Future<List<PlaceInfo>>>(context);
    final widgetMakerService = WidgetMakerService();
    final mapController = MapController();
    var placeInfoBounds = List<PlaceInfo>();
    var isInitialized = false;

    void _positionChange(MapPosition posi, bool flg) {
      if (!isInitialized) {
        var bounds = (placeInfoBounds != null) ? widgetMakerService.createBonds(
            placeInfoBounds) : LatLngBounds();
        mapController.fitBounds(
          bounds,
          options: FitBoundsOptions(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
          ),
        );
        isInitialized = true;
      }
    }

    return FutureProvider(
      create: (context) => placeInfoProvider,
      child: Scaffold(
        body: (currentPosition != null) ? Consumer<List<PlaceInfo>>(
          builder: (_, placeInfo, __){
            var polygons = (placeInfo != null) ? widgetMakerService.createPolygons(placeInfo) : new Polyline();
            var textContens = (placeInfo != null) ? widgetMakerService.createText(placeInfo) : TextSpan(text:'No information. Select different place.');
            placeInfoBounds = placeInfo;

            return (placeInfo != null) ? Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height/1.3,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: new FlutterMap(
                      mapController: mapController,
                      options: new MapOptions(
                          onPositionChanged: _positionChange,
                      ),
                      layers: [
                        new TileLayerOptions(
                            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                            subdomains: ['a', 'b', 'c']
                        ),
                      new PolylineLayerOptions(polylines: polygons),
                      ],
                    ),
                  ),
                ),
                RichText(
                text: TextSpan(
                  text:'Information \n',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                  children: textContens,
                )),
              ],
            ): CircularProgressIndicator();
          },
        ): CircularProgressIndicator(),
      ),
    );
  }
}