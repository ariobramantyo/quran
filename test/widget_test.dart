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
//   List<ListSurah> lisSurah = await ApiService.getListSurah();
//   SpesificSurah? surah = await ApiService.getSpesificSurah(10);

//   // void printSurah(List<ListSurah> surah) {
//   //   surah.forEach((element) async {
//   //     SpesificSurah? surah = await ApiService.getSpesificSurah(element.number);

//   //     print(surah!.verses[1].textArab);

//   //     // print(element.nameIndo);
//   //   });
//   // }

//   print('masuk');
//   print(surah!.verses[1].textArab);
//   // printSurah(lisSurah);
// }
