import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SliderController extends GetxController {
  var currentPage = 0.obs;

  final pageController = PageController(initialPage: 0, viewportFraction: 0.9);

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
