import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quran/controller/bookmark_controller.dart';
import 'package:quran/model/surah.dart';
import 'package:quran/utils/color.dart';
import 'package:quran/utils/surah_alfatihah.dart';
import 'package:quran/view/detail_surah_page.dart';

class LastReadHeader extends StatelessWidget {
  LastReadHeader({Key? key}) : super(key: key);

  int _getLastReadSurahVerse() {
    final box = GetStorage();

    if (box.read('lastRead') != null) {
      var surahName = box.read('lastRead') as Map<String, dynamic>;
      print(surahName);

      return surahName['numberInSurah'];
    }

    return 1;
  }

  Surah _getLastReadSurah() {
    final box = GetStorage();

    if (box.read('lastRead') != null) {
      var surah = box.read('lastRead') as Map<String, dynamic>;

      return Surah.fromJson(surah['surah']);
    }

    return surahAlfatihah;
  }

  final _bookmark = Get.put(BookmarkController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      // padding: EdgeInsets.all(20),
      margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColor.secondaryColor, AppColor.thirdColor],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: -30,
            right: -10,
            child: Image.asset(
              'assets/quran_vector.png',
              height: 175,
              width: 175,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.menu_book,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Bacaan Terakhir',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Obx(
                      () => Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _bookmark.lastRead['surah']['nama'],
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.w800),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Ayat No: ' +
                                _bookmark.lastRead['numberInSurah'].toString(),
                            style: TextStyle(
                                fontSize: 16,
                                color: Color(0xffddc6f7),
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () => Get.to(() => DetailSurahPage(
                              surah: _getLastReadSurah(),
                              initialIndex: _getLastReadSurahVerse(),
                            )),
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.white, width: 1.5),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Lanjut baca',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 5),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
