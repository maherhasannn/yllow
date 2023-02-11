
import 'dart:math';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

const String P_LATITUDE = "latitude";
const String P_LONGITUDE = "longitude";
const String E_LATITUDE = "e_latitude";
const String E_LONGITUDE = "e_longitude";
String P_Address = "address";


class GetLocation {
  String location = 'Null, Press Button';

  static Future<Position> getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  static Future GetAddressFromLatLong(position) async {
    //
    // String Address = 'search';
    // List<Placemark> placemarks =
    // await placemarkFromCoordinates(position.latitude, position.longitude);
    // print(placemarks);
    // Placemark place = placemarks[0];
    // Address = '${place.street}, ${place.subLocality}, ${place.locality},${place.country}';
    // return Address;

    List<Placemark> placemarks =
    await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    P_Address = '${place.street},${place.subLocality},${place.locality},${place.country}';
    // ' ${place.postalCode},
    //   '${place.subLocality};
    // P_Address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    return P_Address;
  }



  static Future GetShortAddress(Position position) async {
    String Addresss = 'search';
    List<Placemark> placemarks =
    await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    Addresss = '${place.subLocality}, ${place.locality},${place.country}';
    return Addresss;
  }
  static DistanceInMeters(double a, double b, double x, double z) {
    log(a);
    log(b);
    log(x);
    log(z);
    return Geolocator.distanceBetween(a, b, x, z);
  }
}