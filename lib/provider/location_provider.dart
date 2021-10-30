import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider extends ChangeNotifier {
  double latitude;
  double longitude;

  double get getLatitude => latitude;

  double get getLongitude => longitude;

  ///Get the Current location
  Future<void> getCurrentLocation() async {
      try{
        Position position= await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high,);
        latitude= position.latitude;
        longitude= position.longitude;
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  ///On the other side [View]
// void getLocation() async {
//   LocationProvider location = LocationProvider();
//   await location.getCurrentLocation();
//   print(location.latitude);
//   print(location.longitude);
//   notifyListeners();
// }
}
