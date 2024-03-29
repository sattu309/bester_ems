import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainHomeController extends GetxController {
  RxInt currentIndex = 0.obs;
  RxInt adminIndex = 0.obs;
  RxBool internetConnection = true.obs;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  ScrollController scrollController = ScrollController();
  onItemTap(int value) {
    currentIndex.value = value;
  }
  onItemTap1(int value) {
    adminIndex.value = value;
  }

  @override
  void onInit() {
    super.onInit();

  }
}
