import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:quran/utils/color.dart';
import 'package:quran/utils/text_style.dart';
import 'package:quran/view/bookmark_page.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Material(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            children: [
              Container(
                width: double.infinity,
                height: 50,
                child: Center(
                    child: Text('Quran', style: AppTextStyle.appBarStyle)),
              ),
              menuItem('Beranda', Icons.home, 0,
                  backColor: AppColor.primaryColor, textColor: Colors.white),
              menuItem('Bookmark', Icons.bookmark, 1),
            ],
          ),
        ),
      ),
    );
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
