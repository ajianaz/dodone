import 'package:flutter/material.dart';

extension CustomExtension on Widget {
  addPadding({double? horizontal, double? vertical}) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizontal ?? 0, vertical: vertical ?? 0),
      child: this,
    );
  }
  // ···
}
