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
  String nextPrayerTime = '-';

  @override
  void onInit() async {
    await determinePosition();
    if (currentPosition != null) {
      getPrayerTimes();
    }
    super.onInit();
  }

  DateTime _convertTime(String time) {
    if (time != '-') {
      String date = DateTime.now().toString().substring(0, 10);
      return DateTime.parse('$date $time');
    }
    return DateTime.now();
  }

  String _nextSalahTime(SalahTime salahTime) {
    if (DateTime.now().isBefore(_convertTime(salahTime.fajr))) {
      return 'Subuh ${salahTime.fajr}';
    } else if (DateTime.now().isBefore(_convertTime(salahTime.dhuhr))) {
      return 'Dzuhur ${salahTime.dhuhr}';
    } else if (DateTime.now().isBefore(_convertTime(salahTime.asr))) {
      return 'Asar ${salahTime.asr}';
    } else if (DateTime.now().isBefore(_convertTime(salahTime.maghrib))) {
      return 'Maghrib ${salahTime.maghrib}';
    } else if (DateTime.now().isAtSameMomentAs(_convertTime(salahTime.isha)) ||
        DateTime.now().isBefore(_convertTime(salahTime.isha))) {
      return 'Isya ${salahTime.isha}';
    } else {
      return '';
    }
  }

  void updateNextPrayerTime() {
    if (salahTime != null) {
      Future.delayed(Duration(seconds: 5), () {
        nextPrayerTime = _nextSalahTime(salahTime!);
        update();
      });
    }
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
          if (salahTime != null) {
            nextPrayerTime = _nextSalahTime(salahTime!);
          }
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
