import 'package:flutter/material.dart';

extension ColorExtension on Color {
  // ignore: deprecated_member_use
  String toHex() => value.toRadixString(16).substring(2).toUpperCase();

  // ignore: deprecated_member_use
  Color get inverse => Color.fromRGBO(255 - red, 255 - green, 255 - blue, 1);
}
