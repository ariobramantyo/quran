import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran/view/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Quran',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
