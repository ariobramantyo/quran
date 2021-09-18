import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quran/controller/theme_controller.dart';
import 'package:quran/view/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Quran',
      debugShowCheckedModeBanner: false,
      darkTheme: themeController.darkTheme,
      theme: themeController.lightTheme,
      themeMode: themeController.themeMode.value,
      home: HomePage(),
    );
  }
}
