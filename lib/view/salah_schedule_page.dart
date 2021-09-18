import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:quran/controller/user_location_controller.dart';
import 'package:quran/model/salah_time.dart';
import 'package:quran/utils/color.dart';
import 'package:quran/utils/text_style.dart';

class SalahSchedulePage extends StatelessWidget {
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

  String? _nextPrayer(List<String> prayerTime, List<String> prayerName) {
    for (int i = 0; i < prayerTime.length; i++) {
      if (i == 1 || i == 4) {
        continue;
      }
      print('${_convertTime(prayerTime[i])}' + ' ${DateTime.now()}');
      print(DateTime.now().isBefore(_convertTime(prayerTime[i])));
      if (DateTime.now().isBefore(_convertTime(prayerTime[i]))) {
        return '${prayerName[i]} ${prayerTime[i]}';
      }
    }
    return 'Waktu Isya telah lewat';
  }

  Widget salahTimeItem(String name, String time) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: AppColor.thirdColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          Text(
            time,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }

  final _todayHijri = HijriCalendar.now().toFormat('dd MMMM yyyy');
  final _today = DateFormat('d MMM y').format(DateTime.now());

  final locationController = Get.find<UserLocationController>();

  final _countdownStyle = TextStyle(
    color: AppColor.subColor,
    fontSize: 22,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Jadwal Solat'),
          actions: [
            IconButton(
                onPressed: () {
                  locationController.determinePosition();
                  locationController.getPrayerTimes();
                },
                icon: Icon(Icons.refresh))
          ],
        ),
        body: GetBuilder<UserLocationController>(
          builder: (controller) {
            return controller.currentAddress != null &&
                    controller.currentPosition != null
                ? ListView(children: [
                    Container(
                      height: 200,
                      width: double.infinity,
                      margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: AssetImage('assets/desert.jpg'),
                              fit: BoxFit.fill)),
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColor.thirdColor.withOpacity(0.85),
                            ),
                          ),
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  controller.salahTime != null
                                      ? controller.nextPrayerTime == ''
                                          ? 'Waktu Isya telah lewat'
                                          : controller.nextPrayerTime
                                              .split(' ')
                                              .first
                                      : 'Terjadi kesalahan',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                                Text(
                                  controller.salahTime != null
                                      ? controller.nextPrayerTime == ''
                                          ? '-'
                                          : controller.nextPrayerTime
                                              .split(' ')
                                              .last
                                      : '-',
                                  style: TextStyle(
                                      fontSize: 40,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                CountdownTimer(
                                  endTime: (controller.nextPrayerTime != '' &&
                                          controller.nextPrayerTime != '-')
                                      ? _convertTime(controller.nextPrayerTime
                                                  .split(' ')
                                                  .last)
                                              .millisecondsSinceEpoch +
                                          1000
                                      : 0,
                                  widgetBuilder: (context, time) {
                                    if (time == null) {
                                      print('Game over');
                                      controller.updateNextPrayerTime();
                                      return Text('(Waktu solat telah tiba)',
                                          style: TextStyle(
                                              color: AppColor.subColor));
                                    }
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            time.hours == null
                                                ? '(00:'
                                                : '(${time.hours}:',
                                            style: _countdownStyle),
                                        Text(
                                            time.min == null
                                                ? '00:'
                                                : '${time.min}:',
                                            style: _countdownStyle),
                                        Text(
                                            time.sec == null
                                                ? '00)'
                                                : '${time.sec})',
                                            style: _countdownStyle),
                                      ],
                                    );
                                  },
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      controller.currentAddress!.locality ??
                                          'mencari lokasi..',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      _today,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                    Text(
                                      ' ($_todayHijri)',
                                      style: TextStyle(
                                          color: AppColor.subColor,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    controller.salahTime != null
                        ? Column(
                            children: [
                              salahTimeItem(
                                  'Subuh', controller.salahTime!.fajr),
                              salahTimeItem(
                                  'Terbit', controller.salahTime!.sunrise),
                              salahTimeItem(
                                  'Dzuhur', controller.salahTime!.dhuhr),
                              salahTimeItem('Asar', controller.salahTime!.asr),
                              salahTimeItem(
                                  'Maghrib', controller.salahTime!.maghrib),
                              salahTimeItem('Isya', controller.salahTime!.isha),
                            ],
                          )
                        : Lottie.asset('assets/error_lottie.json',
                            width: 300, height: 300),
                    SizedBox(height: 10)
                  ])
                : Container(
                    child: Center(
                      child: Container(
                        width: 150,
                        child: Text(
                          'Nyalakan lokasi dan internet anda ntuk melihat jadwal solat',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ),
                  );
          },
        ));
  }
}
