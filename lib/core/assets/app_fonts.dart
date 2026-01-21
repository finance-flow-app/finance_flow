import 'package:flutter/material.dart';

class AppFonts {
  AppFonts._();

  static const fontFamily = 'Rubik';

  static const TextStyle _baseStyle = TextStyle(fontFamily: fontFamily);

  static final light = _baseStyle.copyWith(fontWeight: FontWeight.w300);
  static final lightItalic = _baseStyle.copyWith(
    fontWeight: FontWeight.w300,
    fontStyle: FontStyle.italic,
  );

  static final regular = _baseStyle.copyWith(fontWeight: FontWeight.w400);
  static final italic = _baseStyle.copyWith(
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
  );

  static final medium = _baseStyle.copyWith(fontWeight: FontWeight.w500);
  static final mediumItalic = _baseStyle.copyWith(
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.italic,
  );

  static final semiBold = _baseStyle.copyWith(fontWeight: FontWeight.w600);
  static final semiBoldItalic = _baseStyle.copyWith(
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.italic,
  );

  static final bold = _baseStyle.copyWith(fontWeight: FontWeight.w700);
  static final boldItalic = _baseStyle.copyWith(
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.italic,
  );

  static final extraBold = _baseStyle.copyWith(fontWeight: FontWeight.w800);
  static final extraBoldItalic = _baseStyle.copyWith(
    fontWeight: FontWeight.w800,
    fontStyle: FontStyle.italic,
  );

  static final black = _baseStyle.copyWith(fontWeight: FontWeight.w900);
  static final blackItalic = _baseStyle.copyWith(
    fontWeight: FontWeight.w900,
    fontStyle: FontStyle.italic,
  );
}
