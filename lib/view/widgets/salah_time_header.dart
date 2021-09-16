import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quran/controller/user_location_controller.dart';
import 'package:quran/model/salah_time.dart';
import 'package:quran/utils/color.dart';
import 'package:quran/view/salah_schedule_page.dart';

class SalahTimeHeader extends StatelessWidget {
  SalahTimeHeader({Key? key}) : super(key: key);

  final locationController = Get.put(UserLocationController());

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

  var _today = DateFormat('d MMMM y').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        width: double.infinity,
        // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColor.secondaryColor, AppColor.thirdColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: -10,
              right: -5,
              child: Image.asset(
                'assets/mosque_vector.png',
                width: 150,
                height: 150,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GetBuilder<UserLocationController>(
                      builder: (controller) {
                        return controller.salahTime != null
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.salahTime != null
                                        ? _nextSalahTime(
                                                    controller.salahTime!) ==
                                                ''
                                            ? 'Waktu Isya telah lewat'
                                            : _nextSalahTime(
                                                    controller.salahTime!)
                                                .split(' ')
                                                .first
                                        : 'Terjadi kesalahan',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                  Text(
                                    controller.salahTime != null
                                        ? _nextSalahTime(
                                                    controller.salahTime!) ==
                                                ''
                                            ? '-'
                                            : _nextSalahTime(
                                                    controller.salahTime!)
                                                .split(' ')
                                                .last
                                        : '-',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 42,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )
                            : Text(
                                'Solat selanjutnya',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              );
                      },
                    ),
                    SizedBox(height: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 15,
                            ),
                            SizedBox(width: 5),
                            GetBuilder<UserLocationController>(
                              builder: (controller) {
                                return controller.currentAddress != null &&
                                        controller.currentPosition != null
                                    ? Text(
                                        controller.currentAddress!.locality ??
                                            'Mencari lokasi..',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 14),
                                      )
                                    : Text('Mencari lokasi..',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 14));
                              },
                            ),
                            SizedBox(width: 5),
                            IconButton(
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                                onPressed: () {
                                  locationController.determinePosition();
                                  locationController.getPrayerTimes();
                                },
                                icon: Icon(
                                  Icons.refresh,
                                  color: Colors.white,
                                  size: 24,
                                ))
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              color: Colors.white,
                              size: 15,
                            ),
                            SizedBox(width: 5),
                            Text(
                              _today,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 15,
              right: 10,
              child: GestureDetector(
                onTap: () => Get.to(() => SalahSchedulePage()),
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
