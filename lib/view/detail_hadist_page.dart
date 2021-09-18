import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:quran/controller/bookmark_controller.dart';
import 'package:quran/controller/theme_controller.dart';
import 'package:quran/model/bookmark_hadist.dart';
import 'package:quran/model/hadist.dart';
import 'package:quran/services/api_service.dart';
import 'package:quran/services/database_helper.dart';
import 'package:quran/utils/color.dart';
import 'package:quran/utils/text_style.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class DetailHadistPage extends StatelessWidget {
  final String id;
  final String name;
  final int initialScrollIndex;

  DetailHadistPage(
      {Key? key,
      required this.id,
      required this.name,
      required this.initialScrollIndex})
      : super(key: key);

  final bookmark = Get.find<BookmarkController>();
  final _themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        elevation: 1,
        backwardsCompatibility: false,
      ),
      body: FutureBuilder<HadistsFromAuthor?>(
        future: ApiService.getHadistByAuthor(id),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Lottie.asset('assets/error_lottie.json',
                width: 300, height: 300);
          }
          if (snapshot.hasData) {
            return snapshot.data != null
                ? ScrollablePositionedList.builder(
                    initialScrollIndex: initialScrollIndex == 0
                        ? initialScrollIndex
                        : initialScrollIndex - 1,
                    itemCount: snapshot.data!.hadiths.length,
                    itemBuilder: (context, index) {
                      var hadist = snapshot.data!.hadiths[index];
                      return Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColor.thirdColor.withOpacity(0.05),
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
                                        hadist.number.toString(),
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Obx(
                                    () => IconButton(
                                      onPressed: () {
                                        if (bookmark.checkBookmarkHadist(
                                            hadist.number, id)) {
                                          DatabaseHelper.instance
                                              .deleteHadistById(
                                                  id, hadist.number);
                                          bookmark.deleteHadistById(
                                              hadist.number, id);
                                          Get.snackbar('Bookmark',
                                              'Hadist $name no. ${hadist.number} dihapus dari folder bookmark');
                                        } else {
                                          var bookmarkHadist = BookmarkHadist(
                                              idName: id,
                                              number: hadist.number,
                                              name: name);

                                          DatabaseHelper.instance
                                              .addHadist(bookmarkHadist);
                                          bookmark.listHadist
                                              .add(bookmarkHadist);
                                          bookmark.listHadist.refresh();
                                          Get.snackbar('Bookmark',
                                              'Hadist $name no. ${hadist.number} ditambahkan ke folder bookmark');
                                        }
                                      },
                                      icon: Icon(bookmark.checkBookmarkHadist(
                                              hadist.number, id)
                                          ? Icons.bookmark
                                          : Icons.bookmark_border_outlined),
                                      iconSize: 28,
                                      color: _themeController.darkMode.value
                                          ? AppColor.thirdColor
                                          : AppColor.primaryColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                hadist.arab,
                                textAlign: TextAlign.right,
                                style: TextStyle(fontSize: 28),
                              ),
                            ),
                            SizedBox(height: 8),
                            Container(
                              width: double.infinity,
                              child: Text(
                                hadist.indo,
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 20),
                              ),
                            )
                          ],
                        ),
                      );
                    })
                : Lottie.asset('assets/error_lottie.json',
                    width: 300, height: 300);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
