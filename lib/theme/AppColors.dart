import 'package:flutter/material.dart';

class AppColors {

  // 🔵 Primary Blue Shades
  static const Color primaryStart = Color(0xFF2962FF); // Deep Blue
  static const Color primaryEnd   = Color(0xFF00B0FF); // Light Blue

  // 🔵 Main Background Colors
  static const Color background = Color(0xFF0E0E0E);
  static const Color navBar = Color(0xFF151515);

  static const Color textGrey = Colors.grey;
  static const Color white = Colors.white;

  // 🔵 Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [
      primaryStart,
      primaryEnd,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}