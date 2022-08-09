import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran/controller/search_controller.dart';
import 'package:quran/controller/theme_controller.dart';
import 'package:quran/utils/color.dart';
import 'package:quran/utils/text_style.dart';
import 'package:quran/view/detail_surah_page.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);

  final _searchController = Get.put(SearchController());
  final _themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Container(
                height: 40,
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Obx(
                  () => TextFormField(
                    controller: _searchController.searchField,
                    autofocus: true,
                    textAlignVertical: TextAlignVertical.bottom,
                    cursorColor: AppColor.primaryColor,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: _themeController.darkMode.value
                          ? AppColor.primaryColor.withOpacity(0.3)
                          : Colors.grey[200],
                      prefixIcon: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(Icons.arrow_back),
                        color: _themeController.darkMode.value
                            ? Colors.white
                            : AppColor.primaryColor,
                      ),
                      hintText: 'Cari Surat...',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide.none),
                    ),
                    onChanged: (_) {
                      _searchController.searchSurah();
                    },
                  ),
                )),
            Obx(() => Expanded(
                  child: ListView.builder(
                    // shrinkWrap: true,
                    // physics: ClampingScrollPhysics(),
                    itemCount: _searchController.listSurahDisplay.length,
                    itemBuilder: (context, index) {
                      var surah = _searchController.listSurahDisplay[index];
                      return Column(
                        children: [
                          ListTile(
                            onTap: () => Get.to(() => DetailSurahPage(
                                  surah: surah,
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
                                    color:
                                        AppColor.primaryColor.withOpacity(0.7),
                                  ),
                                  Text(
                                    surah.number.toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
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
                                  color: _themeController.darkMode.value
                                      ? AppColor.thirdColor
                                      : AppColor.primaryColor,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                          if (index !=
                              _searchController.listSurahDisplay.length)
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
                ))
          ],
        ),
      ),
    );
  }
}
