import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran/controller/bookmark_controller.dart';
import 'package:quran/model/list_surah.dart';
import 'package:quran/services/api_service.dart';
import 'package:quran/utils/color.dart';
import 'package:quran/utils/text_style.dart';
import 'package:quran/view/detail_surah_page.dart';

class SurahTab extends StatelessWidget {
  SurahTab({Key? key}) : super(key: key);

  final bookmark = Get.put(BookmarkController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ListSurah>>(
        future: ApiService.getListSurah(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: ListView.builder(
                physics: ClampingScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var surah = snapshot.data![index];
                  return Column(
                    children: [
                      ListTile(
                        onTap: () => Get.to(() => DetailSurahPage(
                              // surah: surah,
                              id: surah.number,
                              name: surah.nameIndo,
                              initialIndex: 0,
                            )),
                        leading: Container(
                          height: 45,
                          width: 45,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                'assets/number_shape.png',
                                color: AppColor.primaryColor.withOpacity(0.7),
                              ),
                              Text(
                                surah.number.toString(),
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        // leading: Container(
                        //   height: 40,
                        //   width: 40,
                        //   decoration: BoxDecoration(
                        //     color: AppColor.thirdColor.withOpacity(0.7),
                        //     borderRadius: BorderRadius.circular(5),
                        //   ),
                        //   child: Center(
                        //     child: Text(
                        //       surah.number.toString(),
                        //       style: TextStyle(
                        //           color: Colors.white,
                        //           fontSize: 16,
                        //           fontWeight: FontWeight.w600),
                        //     ),
                        //   ),
                        // ),
                        title: Text(
                          surah.nameIndo,
                          style: AppTextStyle.titleListTile,
                        ),
                        subtitle: Text(
                            '${surah.revelation.toUpperCase()} - ${surah.numberOfVerses.toString()} AYAT'),
                        trailing: Text(
                          surah.nameArab,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontSize: 18,
                              color: AppColor.primaryColor,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                      if (index != snapshot.data!.length)
                        Divider(
                          height: 8,
                          thickness: 0.5,
                          indent: 10,
                          endIndent: 10,
                        ),
                    ],
                  );
                },
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
