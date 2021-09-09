import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran/controller/bookmark_controller.dart';
import 'package:quran/model/spesific_surah.dart';
import 'package:quran/model/surah.dart';
import 'package:quran/services/api_service.dart';
import 'package:quran/services/database_helper.dart';
import 'package:quran/utils/color.dart';
import 'package:quran/utils/text_style.dart';
import 'package:sqflite/sqflite.dart';

class DetailSurahPage extends StatelessWidget {
  final Surah surah;

  DetailSurahPage({Key? key, required this.surah}) : super(key: key);

  final bookmark = Get.find<BookmarkController>();

  @override
  Widget build(BuildContext context) {
    print(surah.number);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          surah.nameIndo,
          style: AppTextStyle.appBarStyle,
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey),
      ),
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            padding: EdgeInsets.symmetric(vertical: 30),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColor.secondaryColor, AppColor.thirdColor],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.thirdColor.withOpacity(0.3),
                    blurRadius: 10,
                    offset: Offset(5, 5),
                    spreadRadius: 8,
                  )
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  surah.nameIndo,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 27,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 10),
                Text(
                  surah.translation,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.w500),
                ),
                Divider(
                  height: 40,
                  thickness: 0.6,
                  indent: 50,
                  endIndent: 50,
                  color: Colors.white,
                ),
                Text(
                  '${surah.revelation.toUpperCase()} - ${surah.numberOfVerses} AYAT',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                if (surah.number != 1)
                  Column(
                    children: [
                      SizedBox(height: 10),
                      Text(surah.preBismillah,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
              ],
            ),
          ),
          ListView.builder(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: surah.numberOfVerses,
            itemBuilder: (context, index) {
              var verse = surah.verses[index];
              return Container(
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                // color: Colors.grey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      // height: 40,
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColor.thirdColor.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: AppColor.primaryColor,
                                  shape: BoxShape.circle),
                              child: Text(
                                verse.numberInSurah.toString(),
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.push_pin_outlined),
                                iconSize: 28,
                                color: AppColor.primaryColor,
                              ),
                              Obx(
                                () => IconButton(
                                  onPressed: () {
                                    if (bookmark
                                        .checkBookmark(verse.numberInQuran)) {
                                      DatabaseHelper.instance
                                          .deleteById(verse.numberInQuran);
                                      bookmark.deleteById(verse.numberInQuran);
                                    } else {
                                      DatabaseHelper.instance.addVerse(verse);
                                      bookmark.listVerse.add(verse);
                                      bookmark.listVerse.refresh();
                                    }
                                  },
                                  icon: Icon(bookmark
                                          .checkBookmark(verse.numberInQuran)
                                      ? Icons.bookmark
                                      : Icons.bookmark_border_outlined),
                                  iconSize: 28,
                                  color: AppColor.primaryColor,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        verse.textArab,
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 28),
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      child: Text(
                        verse.textLatin,
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
