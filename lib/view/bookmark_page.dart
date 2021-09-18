import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran/controller/bookmark_controller.dart';
import 'package:quran/services/database_helper.dart';
import 'package:quran/utils/text_style.dart';
import 'package:quran/view/detail_hadist_page.dart';
import 'package:quran/view/detail_surah_page.dart';

class BookmarkPage extends StatelessWidget {
  BookmarkPage({Key? key}) : super(key: key);

  final bookmark = Get.find<BookmarkController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Bookmark'),
          elevation: 1,
          backwardsCompatibility: false,
        ),
        body: ListView(
          children: [
            SizedBox(height: 10),
            Center(child: Text('Surah yang dibookmark')),
            Obx(
              () => bookmark.listVerse.length > 0
                  ? ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: bookmark.listVerse.length,
                      itemBuilder: (context, index) {
                        var verse = bookmark.listVerse[index];
                        return Dismissible(
                          key: UniqueKey(),
                          onDismissed: (_) {
                            DatabaseHelper.instance
                                .deleteVerseById(verse.numberInQuran);
                            bookmark.deleteVerseById(verse.numberInQuran);
                          },
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => Get.to(() => DetailSurahPage(
                                  id: verse.surahNumber,
                                  name: verse.surahName,
                                  initialIndex: verse.numberOfVerseBookmarked)),
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.fromLTRB(20, 15, 5, 15),
                                child: Text(
                                  'Q.S. ${verse.surahName} ${verse.surahNumber}: Ayat ${verse.numberOfVerseBookmarked}',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Tidak ada surah yang dibookmark',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )),
            ),
            Center(child: Text('Hadist yang dibookmark')),
            Obx(
              () => bookmark.listHadist.length > 0
                  ? ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: bookmark.listHadist.length,
                      itemBuilder: (context, index) {
                        var hadist = bookmark.listHadist[index];
                        return Dismissible(
                          key: UniqueKey(),
                          onDismissed: (_) {
                            DatabaseHelper.instance
                                .deleteHadistById(hadist.idName, hadist.number);
                            bookmark.deleteHadistById(
                                hadist.number, hadist.idName);
                          },
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Get.to(() => DetailHadistPage(
                                    id: hadist.idName,
                                    name: hadist.name,
                                    initialScrollIndex: hadist.number));
                                print(hadist.number);
                              },
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.fromLTRB(20, 15, 5, 15),
                                child: Text(
                                  '${hadist.name} no. ${hadist.number}',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Tidak ada surah yang dibookmark',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )),
            ),
          ],
        ));
  }
}
