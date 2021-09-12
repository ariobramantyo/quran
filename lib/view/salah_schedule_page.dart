import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
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
        DateTime.now().isAfter(_convertTime(salahTime.isha))) {
      return 'Subuh ${salahTime.fajr}';
    } else {
      return 'Isya ${salahTime.isha}';
    }
  }

  Widget salahTimeItem(String name, String time) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name),
          Text(time),
        ],
      ),
    );
  }

  final _todayHijri = HijriCalendar.now().toFormat('dd MMMM yyyy');
  final _today = DateFormat('d MMMM y').format(DateTime.now());

  final locationController = Get.find<UserLocationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Jadwal Solat',
            style: AppTextStyle.appBarStyle,
          ),
          actions: [
            IconButton(
                onPressed: () => locationController.determinePosition(),
                icon: Icon(Icons.refresh))
          ],
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.grey),
        ),
        body: GetBuilder<UserLocationController>(
          builder: (controller) {
            return controller.currentAddress != null &&
                    controller.currentPosition != null
                ? Column(children: [
                    Container(
                      height: Get.size.height / 3,
                      width: double.infinity,
                      color: AppColor.thirdColor,
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _nextSalahTime(controller.salahTime!),
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Icon(Icons.location_on, color: Colors.white),
                              SizedBox(width: 5),
                              Column(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.currentAddress!.locality ??
                                        'Address',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                  Text(
                                    controller.currentAddress!
                                            .subAdministrativeArea ??
                                        'Address',
                                    style: TextStyle(
                                        color: AppColor.subColor, fontSize: 18),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                color: Colors.white,
                              ),
                              SizedBox(width: 5),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _today,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                  Text(
                                    _todayHijri,
                                    style: TextStyle(
                                        color: AppColor.subColor, fontSize: 18),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    salahTimeItem('Subuh', controller.salahTime!.fajr),
                    salahTimeItem('Dzuhur', controller.salahTime!.dhuhr),
                    salahTimeItem('Asar', controller.salahTime!.asr),
                    salahTimeItem('Maghrib', controller.salahTime!.maghrib),
                    salahTimeItem('Isya', controller.salahTime!.isha),
                  ])
                : Container(
                    child: Text(
                        'Nyalakan lokasi dan internet anda ntuk melihat jadwal solat'),
                  );
          },
        ));
  }
}
