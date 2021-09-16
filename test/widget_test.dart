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
import 'package:quran/model/salah_time.dart';
// import 'package:quran/model/spesific_surah.dart';
import 'package:quran/services/api_service.dart';

void main() async {
  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(MyApp());

  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);

  //   // Tap the '+' icon and trigger a frame.
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();

  //   // Verify that our counter has incremented.
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  // });
  // List<ListSurah> lisSurah = await ApiService.getListSurah();
  // DateTime convertTime(String time) {
  //   if (time != '-') {
  //     String date = DateTime.now().toString().substring(0, 10);
  //     return DateTime.parse('$date $time');
  //   }
  //   return DateTime.now();
  // }

  // String nextSalahTime(SalahTime salahTime) {
  //   if (DateTime.now().isBefore(convertTime(salahTime.fajr))) {
  //     return 'Subuh ${salahTime.fajr}';
  //   } else if (DateTime.now().isBefore(convertTime(salahTime.dhuhr))) {
  //     return 'Dzuhur ${salahTime.dhuhr}';
  //   } else if (DateTime.now().isBefore(convertTime(salahTime.asr))) {
  //     return 'Asar ${salahTime.asr}';
  //   } else if (DateTime.now().isBefore(convertTime(salahTime.maghrib))) {
  //     return 'Maghrib ${salahTime.maghrib}';
  //   } else if (DateTime.now().isAtSameMomentAs(convertTime(salahTime.isha)) ||
  //       DateTime.now().isAfter(convertTime(salahTime.isha))) {
  //     return 'Subuh ${salahTime.fajr}';
  //   } else {
  //     return 'Isya ${salahTime.isha}';
  //   }
  // }

  var dummy = List.filled(4, '');

  for (int i = 0; i < 5; i++) {
    dummy[i] = i.toString();
  }

  print(dummy);

  // String nextSalahTimeTest(SalahTime salahTime) {
  //   DateTime date = DateTime.parse('2021-09-11 19:00');
  //   if (date.isBefore(convertTime(salahTime.fajr))) {
  //     return 'Subuh ${salahTime.fajr}';
  //   } else if (date.isBefore(convertTime(salahTime.dhuhr))) {
  //     return 'Dzuhur ${salahTime.dhuhr}';
  //   } else if (date.isBefore(convertTime(salahTime.asr))) {
  //     return 'Asar ${salahTime.asr}';
  //   } else if (date.isBefore(convertTime(salahTime.maghrib))) {
  //     return 'Maghrib ${salahTime.maghrib}';
  //   } else if (date.isAtSameMomentAs(convertTime(salahTime.isha)) ||
  //       date.isAfter(convertTime(salahTime.isha))) {
  //     return 'Subuh ${salahTime.fajr}';
  //   } else {
  //     return 'Isya ${salahTime.isha}';
  //   }
  // }

  // SalahTime? salahTime =
  //     await ApiService.getSalahTime(39.81666564941406, 21.416667938232425);

  // print(salahTime!.fajr);
  // print(salahTime.dhuhr);
  // print(salahTime.asr);
  // print(salahTime.maghrib);
  // print(salahTime.isha);

  // print('waktu solat selanjutnya ${nextSalahTimeTest(salahTime)}');

  // String time = convertTime(salahTime.dhuhr);

  // print(DateTime.parse(time));

  // List<HadistBook> listHadis = await ApiService.getHadistsBook();
  // listHadis.forEach((element) {
  //   print(element.name);
  // });

  // HadistsFromAuthor? hadist = await ApiService.getHadistByAuthor('muslim');
  // print(hadist!.hadiths[10].arab);
  // print(hadist.hadiths[10].indo);

  // void printSurah(List<ListSurah> surah) {
  //   surah.forEach((element) async {
  //     SpesificSurah? surah = await ApiService.getSpesificSurah(element.number);

  //     print(surah!.verses[1].textArab);

  //     // print(element.nameIndo);
  //   });
  // }

  // print('masuk');
  // print(surah!.verses[1].textArab);
  // printSurah(lisSurah);
}
