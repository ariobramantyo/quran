import 'package:get/get.dart';

class TabBarController extends GetxController {
  var tabBarSelected = 0.obs;

  void changeTabBar(int tab) {
    tabBarSelected.value = tab;
  }
}
