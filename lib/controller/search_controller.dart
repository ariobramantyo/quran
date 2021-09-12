import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:quran/model/list_surah.dart';
import 'package:quran/services/api_service.dart';

class SearchController extends GetxController {
  late TextEditingController searchField;
  var listSurah = List<ListSurah>.empty().obs;
  var listSurahDisplay = List<ListSurah>.empty().obs;

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
