import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:quran/model/salah_time.dart';
import 'package:quran/services/api_service.dart';
import 'package:quran/utils/salah_tine.dart';

class UserLocationController extends GetxController {
  Position? currentPosition;
  Placemark? currentAddress;
  SalahTime? salahTime;
  List<String>? prayerTimes;
  List<String>? prayerNames;

  @override
  void onInit() async {
    await determinePosition();
    if (currentPosition != null) {
      getPrayerTimes();
    }
    super.onInit();
  }

  Future determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

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
        print(currentPosition!.longitude);
        print(salahTime);
      } catch (e) {
        print(e);
        currentAddress = null;
        currentAddress = null;
      }
    }
    update();
  }

  getPrayerTimes() {
    PrayerTime prayers = new PrayerTime();

    prayers.setTimeFormat(prayers.getTime24());
    prayers.setCalcMethod(prayers.getKarachi());
    prayers.setAsrJuristic(prayers.getHanafi());
    prayers.setAdjustHighLats(prayers.getAdjustHighLats());

    var offsets = [
      -8,
      0,
      0,
      -64,
      0,
      0,
      0
    ]; // {Fajr,Sunrise,Dhuhr,Asr,Sunset,Maghrib,Isha}
    prayers.tune(offsets);

    String tmx = '${DateTime.now().timeZoneOffset}';

    var currentTime = DateTime.now();
    var timeZone = double.parse(tmx[0]);

    prayerTimes = prayers.getPrayerTimes(currentTime, currentPosition!.latitude,
        currentPosition!.longitude, timeZone);
    prayerNames = prayers.getTimeNames();
  }
}
