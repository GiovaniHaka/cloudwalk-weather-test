import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// [AppTextStyle] is a class that contains all the text styles used in the app.
class AppTextStyle {
  static const Color color = Colors.black;

  static TextStyle _baseTextStyle(TextStyle style) {
    return GoogleFonts.getFont(
      'Roboto',
      textStyle: style,
    );
  }

  static TextStyle headlineLarge() {
    const style = TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.w600,
      color: color,
    );

    return _baseTextStyle(style);
  }

  static TextStyle headlineMedium() {
    const style = TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w600,
      color: color,
      letterSpacing: 0.25,
    );

    return _baseTextStyle(style);
  }

  static TextStyle headlineSmall() {
    const style = TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: color,
    );

    return _baseTextStyle(style);
  }

  static TextStyle titleLarge() {
    const style = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: color,
      letterSpacing: 0.15,
    );

    return _baseTextStyle(style);
  }

  static TextStyle titleMedium() {
    const style = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: color,
    );

    return _baseTextStyle(style);
  }

  static TextStyle titleSmall() {
    const style = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: color,
    );

    return _baseTextStyle(style);
  }

  static TextStyle bodyLarge() {
    const style = TextStyle(
      fontSize: 16,
      height: 1.3,
      fontWeight: FontWeight.w400,
      color: color,
    );

    return _baseTextStyle(style);
  }

  static TextStyle bodyMedium() {
    const style = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.3,
      color: color,
    );

    return _baseTextStyle(style);
  }

  static TextStyle bodySmall() {
    final style = TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w400,
      color: Colors.grey[700],
      height: 1.3,
    );

    return _baseTextStyle(style);
  }

  static TextStyle labelSmall() {
    const style = TextStyle(
      fontSize: 11,
      height: 1.3,
      fontWeight: FontWeight.w500,
      color: color,
    );

    return _baseTextStyle(style);
  }

  static TextStyle labelMedium() {
    const style = TextStyle(
      height: 1.3,
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: color,
    );

    return _baseTextStyle(style);
  }

  static TextStyle labelLarge() {
    const style = TextStyle(
      height: 1.3,
      fontSize: 13,
      fontWeight: FontWeight.w500,
      color: color,
    );

    return _baseTextStyle(style);
  }

  static TextStyle caption() {
    const style = TextStyle(
      height: 1,
      fontSize: 10,
      fontWeight: FontWeight.w500,
      color: color,
    );

    return _baseTextStyle(style);
  }

  static TextStyle button() {
    const style = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: color,
    );

    return _baseTextStyle(style);
  }

  static TextStyle buttonMedium() {
    const style = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: color,
    );

    return _baseTextStyle(style);
  }

  static TextStyle buttonSmall() {
    const style = TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      color: color,
    );

    return _baseTextStyle(style);
  }

  static TextStyle form() {
    const style = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      height: 1.3,
      color: color,
    );

    return _baseTextStyle(style);
  }

  static TextStyle formHint() {
    const style = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      height: 1.3,
      color: Colors.grey,
    );

    return _baseTextStyle(style);
  }

  static TextStyle formError() {
    const style = TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      color: Colors.red,
      height: 1.3,
    );

    return _baseTextStyle(style);
  }
}
