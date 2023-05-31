import 'package:dodone/app/data/models/menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  Rx<Menu> selectedBottonNav = bottomNavItems.first.obs;
  // Rx<Menu> selectedSideMenu = sidebarMenus.first.obs;

  late SMIBool isMenuOpenInput;

  var tabIndex = 0.obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  void updateSelectedBtmNav(Menu menu) {
    if (selectedBottonNav.value != menu) {
      selectedBottonNav.value = menu;
      debugPrint("selected: ${selectedBottonNav.value.title}");
    }
  }

  late AnimationController _animationController;
  late Animation<double> scalAnimation;
  late Animation<double> animation;

  @override
  void onInit() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(
        () {},
      );
    scalAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    super.onInit();
  }
}
