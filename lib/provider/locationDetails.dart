import 'package:geocoder/geocoder.dart';



class GetLocationDetailsAddress{


  GetLocationDetailsAddress._();

  static String addressLine;
  static String cityName;
  static String subAdminArea;
  static bool locationInRange=false;
  static int areaId;
// static var currentLocation;
  static getUserLocation(double lat,double long) async {


    // ignore: unused_local_variable

//    currentLocation = myLocation;
    final coordinates = new Coordinates(lat, long);
//        myLocation.latitude, myLocation.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;

     addressLine=first.addressLine.toString();
     cityName=first.adminArea.toString();
     subAdminArea=first.subAdminArea.toString();

   // print('locality is ${first.locality} ');
   print('addressLine  ${addressLine}');
   // print('city is  ${first.adminArea}');
   // print('subAdminArea is  ${first.subAdminArea}');
   // print('subLocality is ${first.subLocality} ');
   // print('subAdminArea is ${first.subAdminArea} ');
   // print('addressLine is ${first.addressLine} ');
   // print('featureName is  ${first.featureName}');
   // print('thoroughfare is  ${first.thoroughfare}');
   // print('subThoroughfare is ${first.subThoroughfare} ');
   // print('countryName is ${first.countryName} ');
   // print('countryCode is ${first.countryCode} ');
   // print('featureName is ${first.featureName} ');
   // print('coordinates is ${first.coordinates} ');
   // print('postalCode is ${first.postalCode} ');

    return first;
  }

  static checkCityLocationRange(){

      // if(GetLocationDetailsAddress.cityName.contains('giza')){
      //   locationInRange=true;
      //   areaId=7;
      //   print('location in range city is ${GetLocationDetailsAddress.cityName}');
      // }
      // else if(GetLocationDetailsAddress.cityName.contains('giza Governorate')){
      //   locationInRange=true;
      //   areaId=7;
      //
      //   print('location in range city is ${GetLocationDetailsAddress.cityName}');
      // }
      // else if(GetLocationDetailsAddress.cityName.contains('Giza')){
      //   locationInRange=true;
      //   areaId=7;
      //
      //   print('location in range city is ${GetLocationDetailsAddress.cityName}');
      // }
      // else if(GetLocationDetailsAddress.cityName.contains('Giza Governorate')){
      //   locationInRange=true;
      //   areaId=7;
      //
      //   print('location in range city is ${GetLocationDetailsAddress.cityName}');
      // }
      // else if(GetLocationDetailsAddress.cityName.contains('الجيزة')){
      //   locationInRange=true;
      //   areaId=7;
      //
      //   print('location in range city is ${GetLocationDetailsAddress.cityName}');
      // }
      //  if(GetLocationDetailsAddress.cityName.contains('محافظة الجيزة')){
      //   locationInRange=true;
      //   areaId=7;
      //   print('location in range city is ${GetLocationDetailsAddress.cityName}');
      // }
      if(GetLocationDetailsAddress.cityName.contains('cairo')){
        locationInRange=true;
        print('location in range city is ${GetLocationDetailsAddress.cityName}');
        areaId=1;

      }
      else if(GetLocationDetailsAddress.cityName.contains('cairo Governorate')){
        locationInRange=true;
        areaId=1;

        print('location in range city is ${GetLocationDetailsAddress.cityName}');
      }
      else if(GetLocationDetailsAddress.cityName.contains('Cairo')){
        locationInRange=true;
        areaId=1;

        print('location in range city is ${GetLocationDetailsAddress.cityName}');
      }
      else if(GetLocationDetailsAddress.cityName.contains('Cairo Governorate')){
        locationInRange=true;
        areaId=1;

        print('location in range city is ${GetLocationDetailsAddress.cityName}');
      }
      else if(GetLocationDetailsAddress.cityName.contains('القاهرة‬')){
        locationInRange=true;
        areaId=1;

        print('location in range city is ${GetLocationDetailsAddress.cityName}');
      }
      else if(GetLocationDetailsAddress.cityName.contains('محافظة القاهرة‬')){
        locationInRange=true;
        areaId=1;

        print('location in range city is ${GetLocationDetailsAddress.cityName}');
      }


      else if(GetLocationDetailsAddress.cityName.contains('Helwan')){
        locationInRange=true;
        areaId=1;

        print('location in range city is ${GetLocationDetailsAddress.cityName}');
      }
      else if(GetLocationDetailsAddress.cityName.contains('helwan')){
        locationInRange=true;
        areaId=1;

        print('location in range city is ${GetLocationDetailsAddress.cityName}');
      }
      else if(GetLocationDetailsAddress.cityName.contains('Helwan Governorate')){
        locationInRange=true;
        areaId=1;

        print('location in range city is ${GetLocationDetailsAddress.cityName}');
      }
      else if(GetLocationDetailsAddress.cityName.contains('helwan Governorate')){
        locationInRange=true;
        areaId=1;

        print('location in range city is ${GetLocationDetailsAddress.cityName}');
      }
      else if(GetLocationDetailsAddress.cityName.contains('محافظة حلوان')){
        locationInRange=true;
        areaId=1;

        print('location in range city is ${GetLocationDetailsAddress.cityName}');
      }
      else if(GetLocationDetailsAddress.cityName.contains('حلوان')){
        locationInRange=true;
        areaId=1;

        print('location in range city is ${GetLocationDetailsAddress.cityName}');
      }



      else{
        locationInRange=false;
        print(' location not in range');
      }

      //
      //
      // switch(subAdminArea) {
      //
      //   case "First New Cairo": {
      //     print("First New Cairo");
      //   }
      //   break;
      //
      //   case "اول القاهرة الجديدة": {
      //     print("اول القاهرة الجديدة");
      //   }
      //   break;
      //
      //   case "Second New Cairo": {
      //     print("Second New Cairo");
      //   }
      //   break;
      //
      //   case "ثانى القاهرة الجديدة": {
      //     print("ثانى القاهرة الجديدة");
      //   }
      //   break;
      //
      //   case "Third New Cairo": {
      //     print("Third New Cairo");
      //   }
      //   break;
      //
      //   case "ثالث القاهرة الجديدة": {
      //     print("ثالث القاهرة الجديدة");
      //   }
      //   break;
      //
      //
      //
      //   default: {
      //     print("Invalid choice");
      //   }
      //   break;
      // }


  }

}

























//import 'package:geolocator/geolocator.dart';
//import 'package:geocoder/geocoder.dart';
//_getLocation() async {
//  Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//  debugPrint('location: ${position.latitude}');
//  debugPrint('location: ${position.longitude}');
//
//  final coordinates = new Coordinates(position.latitude, position.longitude);
//  var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
//  var first = addresses.first;
//  print("${first.featureName} : ${first.addressLine}");
//}