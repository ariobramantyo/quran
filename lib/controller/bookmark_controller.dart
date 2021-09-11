import 'package:get/get.dart';
import 'package:quran/model/bookmark_hadist.dart';
import 'package:quran/model/bookmark_verse.dart';
import 'package:quran/services/database_helper.dart';

class BookmarkController extends GetxController {
  var listVerse = List<BookmarkVerse>.empty().obs;
  var listHadist = List<BookmarkHadist>.empty().obs;

  @override
  void onInit() async {
    listVerse.value = await DatabaseHelper.instance.getVerse();
    listHadist.value = await DatabaseHelper.instance.getHadist();
    super.onInit();
  }

  bool checkBookmarkVerse(int numberInQuran) {
    for (int i = 0; i < listVerse.length; i++) {
      if (listVerse[i].numberInQuran == numberInQuran) {
        return true;
      }
    }
    return false;
  }

  void deleteVerseById(int numberInQuran) {
    listVerse.removeWhere((element) => element.numberInQuran == numberInQuran);
    listVerse.refresh();
  }

  bool checkBookmarkHadist(int number, String idName) {
    for (int i = 0; i < listHadist.length; i++) {
      if (listHadist[i].number == number && listHadist[i].idName == idName) {
        return true;
      }
    }
    return false;
  }

  void deleteHadistById(int number, String idName) {
    listHadist.removeWhere(
        (element) => element.number == number && element.idName == idName);
    listHadist.refresh();
  }
}
