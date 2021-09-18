import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:quran/controller/theme_controller.dart';
import 'package:quran/utils/color.dart';
import 'package:quran/utils/text_style.dart';
import 'package:quran/view/bookmark_page.dart';

class NavigationDrawer extends StatelessWidget {
  final _themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
        elevation: 0,
        child: Obx(
          () => Material(
            color: _themeController.darkMode.value
                ? AppColor.darkBackgroundColor
                : AppColor.lightBackgroundColor,
            child: SafeArea(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                children: [
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: Center(
                        child: Text('Quran',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: _themeController.darkMode.value
                                    ? Colors.white
                                    : AppColor.primaryColor))),
                  ),
                  menuItem('Beranda', Icons.home, 0,
                      backColor: AppColor.primaryColor,
                      textColor: Colors.white),
                  menuItem('Bookmark', Icons.bookmark, 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tema gelap',
                        style: TextStyle(fontSize: 20),
                      ),
                      Switch(
                          value: _themeController.darkMode.value,
                          activeColor: AppColor.thirdColor,
                          onChanged: (_) {
                            _themeController.changeTheme();

                            print('sesudah: ' + Get.isDarkMode.toString());
                          })
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

Widget menuItem(String title, IconData icon, int callback,
    {Color? backColor, Color? textColor}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 10),
    child: ListTile(
      horizontalTitleGap: 0,
      dense: true,
      leading: Icon(
        icon,
        color: textColor ?? Colors.black,
        size: 25,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor ?? Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.normal,
        ),
      ),
      tileColor: backColor ?? Colors.grey[200],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
      onTap: () {
        Get.back();
        switch (callback) {
          case 0:
            Get.back();
            break;
          case 1:
            Get.to(() => BookmarkPage());
            break;
          // case 2:
          //   Get.to(() => SettingsPage());
          //   break;
          // case 3:
          //   Get.to(() => HistoryPage());
          //   break;
        }
      },
    ),
  );
}
