import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:quran/model/salah_time.dart';
import 'package:quran/services/api_service.dart';

class UserLocationController extends GetxController {
  Position? currentPosition;
  Placemark? currentAddress;
  SalahTime? salahTime;

  @override
  void onInit() async {
    await determinePosition();
    if (currentPosition != null) {
      salahTime = await ApiService.getSalahTime(
          currentPosition!.longitude, currentPosition!.latitude);
    }
    super.onInit();
  }

  Future determinePosition() async {
    // bool serviceEnabled;
    LocationPermission permission;

    // serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!serviceEnabled) {
    //   Fluttertoast.showToast(msg: 'Please enable Your Location Service');
    // }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      // if (permission == LocationPermission.denied) {
      //   Fluttertoast.showToast(msg: 'Location permissions are denied');
      // }
    }

    // if (permission == LocationPermission.deniedForever) {
    //   Fluttertoast.showToast(
    //       msg:
    //           'Location permissions are permanently denied, we cannot request permissions.');
    // }
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(
            position.latitude, position.longitude);

        Placemark place = placemarks[0];

        currentPosition = position;
        currentAddress = place;
        if (currentPosition != null) {
          salahTime = await ApiService.getSalahTime(
              currentPosition!.longitude, currentPosition!.latitude);
        }
        print(currentAddress!.locality);
        print(currentPosition!.latitude);
      } catch (e) {
        print(e);
        currentAddress = null;
        currentAddress = null;
      }
    }
    update();
  }
}
