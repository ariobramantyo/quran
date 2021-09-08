// // // This is a basic Flutter widget test.
// // //
// // // To perform an interaction with a widget in your test, use the WidgetTester
// // // utility that Flutter provides. For example, you can send tap and scroll
// // // gestures. You can also use WidgetTester to find child widgets in the widget
// // // tree, read text, and verify that the values of widget properties are correct.

// // import 'package:flutter/material.dart';
// // import 'package:flutter_test/flutter_test.dart';

// // import 'package:quran/main.dart';
// // import 'package:quran/model/list_surah.dart';
// // import 'package:quran/model/spesific_surah.dart';
// // import 'package:quran/services/api_service.dart';

// import 'package:quran/model/hadist.dart';
// import 'package:quran/model/spesific_surah.dart';
// import 'package:quran/services/api_service.dart';

// void main() async {
//   // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
//   //   // Build our app and trigger a frame.
//   //   await tester.pumpWidget(MyApp());

//   //   // Verify that our counter starts at 0.
//   //   expect(find.text('0'), findsOneWidget);
//   //   expect(find.text('1'), findsNothing);

//   //   // Tap the '+' icon and trigger a frame.
//   //   await tester.tap(find.byIcon(Icons.add));
//   //   await tester.pump();

//   //   // Verify that our counter has incremented.
//   //   expect(find.text('0'), findsNothing);
//   //   expect(find.text('1'), findsOneWidget);
//   // });
//   // List<ListSurah> lisSurah = await ApiService.getListSurah();
//   SpesificSurah? surah = await ApiService.getSpesificSurah(1);
//   print(surah!.nameIndo);
//   print(surah.number);
//   print(surah.numberOfVerses);
//   print(surah.preBismillah);
//   print(surah.revelation);
//   print(surah.translation);
//   print(surah.verses[0].number);
//   print(surah.verses[0].textArab);
//   print(surah.verses[0].textLatin);
//   print(surah.verses[0].translationIndo);

//   // List<HadistBook> listHadis = await ApiService.getHadistsBook();
//   // listHadis.forEach((element) {
//   //   print(element.name);
//   // });

//   // HadistsFromAuthor? hadist = await ApiService.getHadistByAuthor('muslim');
//   // print(hadist!.hadiths[10].arab);
//   // print(hadist.hadiths[10].indo);

//   // void printSurah(List<ListSurah> surah) {
//   //   surah.forEach((element) async {
//   //     SpesificSurah? surah = await ApiService.getSpesificSurah(element.number);

//   //     print(surah!.verses[1].textArab);

//   //     // print(element.nameIndo);
//   //   });
//   // }

//   // print('masuk');
//   // print(surah!.verses[1].textArab);
//   // printSurah(lisSurah);
// }
