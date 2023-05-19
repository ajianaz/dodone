// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rive/rive.dart';

import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          RiveAnimation.asset(
            'assets/animations/shapes.riv',
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
            child: Container(
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.1)),
            ),
          ),
          // Positioned.fill(
          //   child: Align(
          //     alignment: Alignment.centerLeft,
          //     child: BackdropFilter(
          //       filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
          //       child: Container(
          //         height: 200,
          //         margin: EdgeInsets.symmetric(horizontal: 16),
          //         decoration: BoxDecoration(
          //             color: Colors.black.withOpacity(0.2),
          //             borderRadius: BorderRadius.circular(12)),
          //       ),
          //     ),
          //   ),
          // ),
          Positioned(
            bottom: 50,
            right: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // <-- Radius
                ),
              ),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Get Started"),
                  Icon(Icons.chevron_right_sharp),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
