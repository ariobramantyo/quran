// // This is a basic Flutter widget test.
// //
// // To perform an interaction with a widget in your test, use the WidgetTester
// // utility that Flutter provides. For example, you can send tap and scroll
// // gestures. You can also use WidgetTester to find child widgets in the widget
// // tree, read text, and verify that the values of widget properties are correct.

// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';

// import 'package:quran/main.dart';
// import 'package:quran/model/list_surah.dart';
// import 'package:quran/model/spesific_surah.dart';
// import 'package:quran/services/api_service.dart';

// import 'package:flutter/material.dart';
// import 'package:quran/model/hadist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:quran/model/salah_time.dart';
// import 'package:quran/model/spesific_surah.dart';
import 'package:quran/services/api_service.dart';

void main() async {
  // var dummy = List.filled(4, '');

  // for (int i = 0; i < 5; i++) {
  //   dummy[i] = i.toString();
  // }

  // print(dummy);
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;
  CountdownTimer(
    endTime: endTime,
    widgetBuilder: (context, time) {
      if (time == null) {
        print('Game over');
      }
      print(time!.days);
      return Text(
          'days: [ ${time.days} ], hours: [ ${time.hours} ], min: [ ${time.min} ], sec: [ ${time.sec} ]');
    },
  );
}
