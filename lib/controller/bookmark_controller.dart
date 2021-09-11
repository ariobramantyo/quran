import 'package:get/get.dart';
import 'package:quran/model/bookmark_verse.dart';
import 'package:quran/services/database_helper.dart';

class BookmarkController extends GetxController {
  var listVerse = List<BookmarkVerse>.empty().obs;

  @override
  void onInit() async {
    listVerse.value = await DatabaseHelper.instance.getVerse();
    super.onInit();
  }

  bool checkBookmark(int numberInQuran) {
    for (int i = 0; i < listVerse.length; i++) {
      if (listVerse[i].numberInQuran == numberInQuran) {
        return true;
      }
    }
    return false;
  }

  void deleteById(int numberInQuran) {
    listVerse.removeWhere((element) => element.numberInQuran == numberInQuran);
    listVerse.refresh();
  }
}
