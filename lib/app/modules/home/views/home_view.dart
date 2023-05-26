// ignore_for_file: prefer_const_constructors

import 'package:dodone/app/data/models/menu.dart';
import 'package:dodone/app/widgets/btm_nav_item.dart';
import 'package:dodone/app/utils/rive_utils.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Transform.translate(
        offset: Offset(0, 100 * controller.animation.value),
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(8),
            height: 80,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.cyan[600],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ...List.generate(
                      bottomNavItems.length,
                      (index) {
                        Menu navBar = bottomNavItems[index];
                        return BtmNavItem(
                          navBar: navBar,
                          press: () {
                            RiveUtils.chnageSMIBoolState(navBar.rive.status!);
                            controller.updateSelectedBtmNav(navBar);
                          },
                          riveOnInit: (artboard) {
                            navBar.rive.status = RiveUtils.getRiveInput(
                                artboard,
                                stateMachineName: navBar.rive.stateMachineName);
                          },
                          selectedNav: controller.selectedBottonNav.value,
                        );
                      },
                    )
                  ],
                )),
          ),
        ),
      ),
      body: Center(
        child: Text(
          "Center",
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}
