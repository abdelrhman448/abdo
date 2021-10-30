import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

const apiKey = "AIzaSyBomj_bdMskpS1rPhnq2FC8F8hKjE4ayJA";

class GoogleMapsServices extends ChangeNotifier {
  String _distance;
  String _duration;
  String _points;

  String get distance => _distance;

  String get duration => _duration;

  String get points => _points;

  getRouteCoordinates(LatLng latLng1, LatLng latLng2) async {
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${latLng1.latitude},${latLng1.longitude}&destination=${latLng2.latitude},${latLng2.longitude}&key=$apiKey";
    http.Response response = await http.get(Uri.parse(url));
    Map values = jsonDecode(response.body);
    _distance = values["routes"][0]["legs"][0]["distance"]["text"];
    _duration = values["routes"][0]["legs"][0]["duration"]["text"];
    _points = values["routes"][0]["overview_polyline"]["points"];

    notifyListeners();
  }
}
