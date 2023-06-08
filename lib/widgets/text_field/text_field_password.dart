// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, prefer_const_constructors, must_be_immutable

import 'package:dodone/styles/colors.dart';
import 'package:dodone/utils/custom_extension.dart';
import 'package:flutter/material.dart';

class TextFieldPassword extends StatefulWidget {
  TextFieldPassword(
      {Key? key,
      this.obscureText = true,
      required this.controller,
      this.textInputAction = TextInputAction.go,
      this.hintText = "Password",
      this.labelText = "Password",
      this.colorHint = AppColor.hintColor,
      this.colorFocus = AppColor.primaryColor1,
      this.iconPrefix = Icons.lock})
      : super(key: key);

  bool? obscureText;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final String hintText;
  final String labelText;
  final Color colorHint;
  final Color colorFocus;
  final IconData iconPrefix;

  @override
  State<TextFieldPassword> createState() => _TextFieldPasswordState();
}

class _TextFieldPasswordState extends State<TextFieldPassword> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: widget.obscureText!,
      textInputAction: widget.textInputAction,
      controller: widget.controller,
      decoration: InputDecoration(
        prefixIcon: Icon(
          widget.iconPrefix,
          color: widget.colorFocus,
        ),
        suffixIcon: GestureDetector(
          child: Icon(
            Icons.remove_red_eye,
            color: AppColor.hintColor,
          ),
          onTap: () {
            setState(() {
              widget.obscureText = !widget.obscureText!;
            });
          },
        ),
        labelText: widget.labelText,
        hintText: widget.hintText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          borderSide: BorderSide(
            color: widget.colorHint,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: widget.colorFocus),
        ),
      ),
    ).addPadding(vertical: 12);
  }
}
