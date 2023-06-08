import 'package:dodone/config/constant.dart';
import 'package:dodone/styles/colors.dart';
import 'package:dodone/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/routes/app_pages.dart';
import 'languages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(
    ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: APPNAME,
          translations: Languages(),
          locale: Get.deviceLocale,
          fallbackLocale: const Locale('en', 'US'),
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          theme: ThemeData(
            fontFamily: GoogleFonts.poppins().fontFamily,
            scaffoldBackgroundColor: AppColor.bgColor,
            primarySwatch: getMaterialColor(AppColor.primaryColor1),
            inputDecorationTheme: const InputDecorationTheme(
              hintStyle: TextStyle(color: AppColor.hintColor), //<-- SEE HERE
              labelStyle: TextStyle(color: AppColor.hintColor), //<-- SEE HERE
            ),
            textTheme: Theme.of(context).textTheme.apply(
                  bodyColor: AppColor.textColor, //<-- SEE HERE
                  displayColor: AppColor.textColor, //<-- SEE HERE
                ),
          ),
        );
      },
    ),
  );
}
