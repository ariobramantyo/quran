import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quran/utils/color.dart';
import 'package:quran/utils/text_style.dart';

class ThemeController extends GetxController {
  var darkMode = Get.isDarkMode.obs;
  var themeMode = ThemeMode.light.obs;

  @override
  void onInit() {
    super.onInit();
    themeMode.value = _getTheme();
    firstInitialization();
    print('inisialisasi');
  }

  get darkTheme => ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppColor.darkBackgroundColor,
        // dialogBackgroundColor: Colors.grey[850],
        appBarTheme: AppBarTheme(
            brightness: Brightness.dark,
            titleTextStyle:
                AppTextStyle.appBarStyle.copyWith(color: Colors.white),
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: AppColor.darkBackgroundColor),
        // primaryColor: Colors.black,
        // inputDecorationTheme: InputDecorationTheme(
        //   hintStyle: TextStyle(
        //     color: Colors.grey,
        //   ),
        // ),
        // brightness: Brightness.dark,
        // elevatedButtonTheme: ElevatedButtonThemeData(
        //     style: ElevatedButton.styleFrom(
        //   primary: Colors.grey[850],
        //   shape: RoundedRectangleBorder(
        //     borderRadius: new BorderRadius.circular(30.0),
        //   ),
        //   shadowColor: Colors.black,
        //   minimumSize: Size(200, 50),
        // )),
      );

  get lightTheme => ThemeData.light().copyWith(
        scaffoldBackgroundColor: AppColor.lightBackgroundColor,
        // primaryColor: Colors.white,
        // primaryTextTheme: TextTheme(headline6: TextStyle(color: Colors.white)),
        appBarTheme: AppBarTheme(
          brightness: Brightness.light,
          backgroundColor: AppColor.lightBackgroundColor,
          iconTheme: IconThemeData(color: Colors.grey[700]),
          titleTextStyle: AppTextStyle.appBarStyle,
        ),
        // elevatedButtonTheme: ElevatedButtonThemeData(
        //     style: ElevatedButton.styleFrom(
        //   primary: Colors.white,
        //   elevation: 6,
        //   shape: RoundedRectangleBorder(
        //     borderRadius: new BorderRadius.circular(30.0),
        //   ),
        //   minimumSize: Size(200, 50),
        // )),
        // brightness: Brightness.light,
      );

  Future<void> firstInitialization() async {
    final box = GetStorage();

    if (box.read('darkMode') != null) {
      darkMode.value = box.read('darkMode');
    } else {
      darkMode.value = Get.isDarkMode;
    }
  }

  void changeTheme() {
    final box = GetStorage();

    if (darkMode.value) {
      Get.changeTheme(ThemeController().lightTheme);
      darkMode.value = false;
      box.write('darkMode', false);
      themeMode.value = ThemeMode.light;
    } else {
      Get.changeTheme(ThemeController().darkTheme);
      darkMode.value = true;
      box.write('darkMode', true);
      themeMode.value = ThemeMode.dark;
    }
  }

  ThemeMode _getTheme() {
    final box = GetStorage();

    if (box.read('darkMode') != null) {
      if (box.read('darkMode')) {
        print(box.read('darkMode').toString() + 'ini themenya');
        return ThemeMode.dark;
      } else {
        return ThemeMode.light;
      }
    } else {
      return ThemeMode.light;
    }
  }
}
