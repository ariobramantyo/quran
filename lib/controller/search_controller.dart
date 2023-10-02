import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:quran/model/surah.dart';
import 'package:quran/services/api_service.dart';

class SearchController extends GetxController {
  late TextEditingController searchField;
  var listSurah = List<Surah>.empty().obs;
  var listSurahDisplay = List<Surah>.empty().obs;

  @override
  void onInit() async {
    searchField = TextEditingController();
    listSurah.value = await ApiService.getListSurah();
    listSurah.refresh();
    super.onInit();
  }

  void searchSurah() {
    if (searchField.text != '') {
      listSurahDisplay.value = listSurah.where((surah) {
        var surahName = surah.nameIndo.toLowerCase();
        return surahName.contains(searchField.text);
      }).toList();
    } else {
      listSurahDisplay.clear();
    }
    listSurahDisplay.refresh();
  }
}
