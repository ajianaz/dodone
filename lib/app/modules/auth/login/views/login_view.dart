// ignore_for_file: sort_child_properties_last

import 'package:dodone/styles/colors.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dodone/utils/custom_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:dodone/widgets/google/sign_in_button.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'welcome_back'.tr,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ).addPadding(vertical: 14),
                Text(
                  'login_subtitle'.tr,
                  style: TextStyle(fontSize: 20),
                ).addPadding(vertical: 8),
                Text(
                  dotenv.env['FOOBAR'].toString(),
                  style: TextStyle(fontSize: 20),
                ).addPadding(vertical: 8),
                TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.done),
                  ),
                ),
                TextField(
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.mail,
                      color: AppColor.primaryColor1,
                    ),
                    labelText: "Email",
                    hintText: "Email",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(
                        color: AppColor.hintColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: AppColor.primaryColor1),
                    ),
                  ),
                ).addPadding(vertical: 12),
                TextField(
                  obscureText: controller.obscurePass.value,
                  textInputAction: TextInputAction.go,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock,
                      color: AppColor.primaryColor1,
                    ),
                    suffixIcon: GestureDetector(
                      child: Icon(
                        Icons.remove_red_eye,
                        color: AppColor.hintColor,
                      ),
                      onTap: () {
                        controller.obscurePass.value =
                            !controller.obscurePass.value;
                      },
                    ),
                    labelText: "Password",
                    hintText: "Password",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(
                        color: AppColor.hintColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: AppColor.primaryColor1),
                    ),
                  ),
                ).addPadding(vertical: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text("Forgot Password?"),
                  ),
                ),
                ElevatedButton(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                    child: Text(
                      "Sign In",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                    minimumSize: Size.fromHeight(50),
                    backgroundColor: AppColor.primaryColor1,
                    foregroundColor: AppColor.bgColor,
                  ),
                  onPressed: () {},
                ).addPadding(vertical: 12),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Or',
                    style: TextStyle(fontSize: 20, color: AppColor.hintColor),
                  ),
                ).addPadding(vertical: 12),
                Align(alignment: Alignment.center, child: buildGoogleLogin()),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget buildGoogleLogin() {
    if (controller.currentUser != null) {
      // The user is Authenticated
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ListTile(
            leading: GoogleUserCircleAvatar(
              identity: controller.currentUser!,
            ),
            title: Text(controller.currentUser!.displayName ?? ''),
            subtitle: Text(controller.currentUser!.email),
          ),
          const Text('Signed in successfully.'),
          if (controller.isAuthorized) ...<Widget>[
            // The user has Authorized all required scopes
            Text(controller.contactText),
            ElevatedButton(
              child: const Text('REFRESH'),
              onPressed: () =>
                  controller.handleGetContact(controller.currentUser!),
            ),
          ],
          if (!controller.isAuthorized) ...<Widget>[
            // The user has NOT Authorized all required scopes.
            // (Mobile users may never see this button!)
            const Text('Additional permissions needed to read your contacts.'),
            ElevatedButton(
              onPressed: controller.handleAuthorizeScopes,
              child: const Text('REQUEST PERMISSIONS'),
            ),
          ],
          ElevatedButton(
            onPressed: controller.handleSignOut,
            child: const Text('SIGN OUT'),
          ),
        ],
      );
    } else {
      // The user is NOT Authenticated
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const Text('You are not currently signed in.'),
          // InkWell(
          //   child: Text('Sign Here'),
          //   onTap: () {
          //     debugPrint("kliked");
          //     controller.signInClick();
          //   },
          // ),
          // This method is used to separate mobile from web code with conditional exports.
          // See: src/sign_in_button.dart
          buildSignInButton(onPressed: controller.handleSignIn)
        ],
      );
    }
  }
}
