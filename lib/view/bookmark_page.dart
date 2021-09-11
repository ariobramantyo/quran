import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran/controller/bookmark_controller.dart';
import 'package:quran/services/database_helper.dart';
import 'package:quran/utils/text_style.dart';
import 'package:quran/view/detail_surah_page.dart';

class BookmarkPage extends StatelessWidget {
  BookmarkPage({Key? key}) : super(key: key);

  final bookmark = Get.find<BookmarkController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Bookmark',
            style: AppTextStyle.appBarStyle,
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.grey),
          elevation: 1,
        ),
        body: Obx(
          () => ListView.builder(
            itemCount: bookmark.listVerse.length,
            itemBuilder: (context, index) {
              var verse = bookmark.listVerse[index];
              return Dismissible(
                key: UniqueKey(),
                onDismissed: (_) {
                  DatabaseHelper.instance.deleteById(verse.numberInQuran);
                  bookmark.deleteById(verse.numberInQuran);
                },
                child: Material(
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
          ),
        )
        // FutureBuilder<List<BookmarkVerse>>(
        //   future: DatabaseHelper.instance.getVerse(),
        //   builder: (context, snapshot) {
        //     if (snapshot.hasData) {
        //       return ListView.builder(
        //         itemCount: snapshot.data!.length,
        //         itemBuilder: (context, index) {
        //           var verse = snapshot.data![index];
        //           return Dismissible(
        //             key: UniqueKey(),
        //             onDismissed: (_) {
        //               DatabaseHelper.instance.deleteById(verse.numberInQuran);
        //             },
        //             child: Material(
        //               child: InkWell(
        //                 onTap: () => Get.to(() => DetailSurahPage(
        //                     id: verse.surahNumber,
        //                     name: verse.surahName,
        //                     initialIndex: verse.numberOfVerseBookmarked)),
        //                 child: Container(
        //                   width: double.infinity,
        //                   padding:
        //                       EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        //                   child: Text(
        //                     'Q.S. ${verse.surahName} ${verse.surahNumber}: Ayat ${verse.numberOfVerseBookmarked}',
        //                     style: TextStyle(fontSize: 18),
        //                   ),
        //                 ),
        //               ),
        //             ),
        //           );
        //         },
        //       );
        //     }

        //     return Center(
        //       child: CircularProgressIndicator(),
        //     );
        //   },
        // ),
        );
  }
}
