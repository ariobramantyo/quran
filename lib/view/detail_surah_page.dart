import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:quran/controller/bookmark_controller.dart';
import 'package:quran/controller/theme_controller.dart';
import 'package:quran/model/bookmark_verse.dart';
import 'package:quran/model/surah.dart';
import 'package:quran/model/verse.dart';
import 'package:quran/services/api_service.dart';
import 'package:quran/services/database_helper.dart';
import 'package:quran/utils/color.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class DetailSurahPage extends StatelessWidget {
  final Surah surah;
  final int initialIndex;

  DetailSurahPage({Key? key, required this.surah, required this.initialIndex})
      : super(key: key);

  final bookmark = Get.find<BookmarkController>();
  final themeController = Get.find<ThemeController>();

  void pinLastRead(int numberInSurah) {
    final box = GetStorage();

    Map<String, dynamic> value = {
      'numberInSurah': numberInSurah,
      'surah': this.surah.toMap()
    };

    bookmark.lastRead.value = value;
    box.write('lastRead', value);
  }

  String _removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }

  void showSnackbar(String title, String message) {
    Get.snackbar(title, message);
  }

  Widget containerHeader(
      String nameIndo,
      String translation,
      String preBismillah,
      int numberOfVerses,
      String revelation,
      String number) {
    return Container(
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
            nameIndo,
            style: TextStyle(
                color: Colors.white, fontSize: 27, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 10),
          Text(
            translation,
            style: TextStyle(
                color: Colors.white, fontSize: 19, fontWeight: FontWeight.w500),
          ),
          Divider(
            height: 40,
            thickness: 0.6,
            indent: 50,
            endIndent: 50,
            color: Colors.white,
          ),
          Text(
            '${revelation.toUpperCase()} - $numberOfVerses AYAT',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          if (number != "1" && number != "9")
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                Text(preBismillah,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w500)),
              ],
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(surah.nameIndo),
          elevation: 1,
          // backwardsCompatibility: false,
        ),
        body: FutureBuilder<List<Verse?>>(
          future: ApiService.getSurahVerses(surah.number),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Lottie.asset('assets/error_lottie.json',
                  width: 300, height: 300);
            }
            if (snapshot.hasData) {
              return snapshot.data != null
                  ? ScrollablePositionedList.builder(
                      initialScrollIndex: initialIndex,
                      itemCount: snapshot.data!.length + 1,
                      itemBuilder: (context, index) {
                        // var surah = snapshot.data;
                        print(snapshot.data!.length);
                        var verse = index == 0
                            ? snapshot.data![index]
                            : snapshot.data![index - 1];

                        return (index == 0)
                            ? containerHeader(
                                this.surah.nameIndo,
                                this.surah.translation,
                                this.surah.preBismillah,
                                this.surah.numberOfVerses,
                                this.surah.revelation,
                                this.surah.number)
                            : Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: AppColor.thirdColor
                                            .withOpacity(0.05),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  color: AppColor.primaryColor,
                                                  shape: BoxShape.circle),
                                              child: Text(
                                                verse!.numberInSurah.toString(),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                          Row(
                                            children: [
                                              Obx(
                                                () => IconButton(
                                                  onPressed: () {
                                                    pinLastRead(int.parse(
                                                        verse.numberInSurah));
                                                    Get.snackbar(
                                                        'Terakhir dibaca',
                                                        'Q.S. ${this.surah.nameIndo} ayat ${verse.numberInSurah} ditandai terakhir dibaca');
                                                  },
                                                  icon: Icon(bookmark.lastRead[
                                                                  'numberInSurah'] ==
                                                              verse
                                                                  .numberInSurah &&
                                                          bookmark.lastRead[
                                                                  'id'] ==
                                                              this.surah.number
                                                      ? Icons.push_pin
                                                      : Icons
                                                          .push_pin_outlined),
                                                  iconSize: 28,
                                                  color: themeController
                                                          .darkMode.value
                                                      ? AppColor.thirdColor
                                                      : AppColor.primaryColor,
                                                ),
                                              ),
                                              Obx(
                                                () => IconButton(
                                                  onPressed: () {
                                                    if (bookmark
                                                        .checkBookmarkVerse(verse
                                                            .numberInQuran)) {
                                                      DatabaseHelper.instance
                                                          .deleteVerseById(verse
                                                              .numberInQuran);
                                                      bookmark.deleteVerseById(
                                                          verse.numberInQuran);
                                                      Get.snackbar('Bookmark',
                                                          'Q.S. ${this.surah.nameIndo} ayat ${verse.numberInSurah} dihapus dari folder bookmark');
                                                    } else {
                                                      var bookmarkVerse = BookmarkVerse(
                                                          surah: this.surah,
                                                          numberInQuran: verse
                                                              .numberInQuran,
                                                          surahName: this
                                                              .surah
                                                              .nameIndo,
                                                          surahNumber:
                                                              this.surah.number,
                                                          numberOfVerseBookmarked:
                                                              int.parse(verse
                                                                  .numberInSurah));

                                                      DatabaseHelper.instance
                                                          .addVerse(
                                                              bookmarkVerse);
                                                      bookmark.listVerse
                                                          .add(bookmarkVerse);
                                                      bookmark.listVerse
                                                          .refresh();
                                                      Get.snackbar('Bookmark',
                                                          'Q.S. ${this.surah.nameIndo} ayat ${verse.numberInSurah} ditambahkan ke folder bookmark');
                                                    }
                                                  },
                                                  icon: Icon(bookmark
                                                          .checkBookmarkVerse(
                                                              verse
                                                                  .numberInQuran)
                                                      ? Icons.bookmark
                                                      : Icons
                                                          .bookmark_border_outlined),
                                                  iconSize: 28,
                                                  color: themeController
                                                          .darkMode.value
                                                      ? AppColor.thirdColor
                                                      : AppColor.primaryColor,
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
                                        child: Obx(
                                          () => Text(
                                            _removeAllHtmlTags(verse.textLatin),
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: themeController
                                                        .darkMode.value
                                                    ? AppColor.thirdColor
                                                    : AppColor.primaryColor),
                                          ),
                                        )),
                                    SizedBox(height: 8),
                                    Container(
                                      width: double.infinity,
                                      child: Text(
                                        verse.translationIndo,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    )
                                  ],
                                ),
                              );
                      },
                    )
                  : Lottie.asset('assets/error_lottie.json',
                      width: 300, height: 300);
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
