// ignore_for_file: prefer_const_constructors

import 'package:dodone/styles/colors.dart';
import 'package:dodone/utils/custom_extension.dart';
import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  const TextFieldInput({
    super.key,
    required this.hintText,
    required this.controller,
    this.iconPrefix = Icons.mail,
    this.labelText = '',
    this.colorHint = AppColor.hintColor,
    this.colorFocus = AppColor.primaryColor1,
    this.textInputAction = TextInputAction.next,
  });

  final String hintText;
  final TextEditingController controller;
  final IconData iconPrefix;
  final String labelText;
  final Color colorHint;
  final Color colorFocus;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.mail,
          color: colorFocus,
        ),
        labelText: labelText,
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          borderSide: BorderSide(
            color: colorHint,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: colorFocus),
        ),
      ),
    ).addPadding(vertical: 12);
  }
}
