import 'package:flutter/material.dart';

class AppFonts {
  AppFonts._();

  static const fontFamily = 'Rubik';

  static const TextStyle _baseStyle = TextStyle(
    fontFamily: fontFamily,
    letterSpacing: 0.5,
  );

  static TextStyle _style({
    required double fontSize,
    required FontWeight fontWeight,
    double height = 1,
    FontStyle? fontStyle,
  }) {
    return _baseStyle.copyWith(
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      height: height,
    );
  }

  // Standart variants (all weights)
  static final b3s34light = _style(
    fontSize: 34,
    fontWeight: FontWeight.w300,
    height: 40 / 34,
  );
  static final b4s34regular = _style(
    fontSize: 34,
    fontWeight: FontWeight.w400,
    height: 40 / 34,
  );
  static final b5s34medium = _style(
    fontSize: 34,
    fontWeight: FontWeight.w500,
    height: 40 / 34,
  );
  static final b6s34semiBold = _style(
    fontSize: 34,
    fontWeight: FontWeight.w600,
    height: 40 / 34,
  );
  static final b7s34bold = _style(
    fontSize: 34,
    fontWeight: FontWeight.w700,
    height: 40 / 34,
  );
  static final b8s34extraBold = _style(
    fontSize: 34,
    fontWeight: FontWeight.w800,
    height: 40 / 34,
  );
  static final b9s34black = _style(
    fontSize: 34,
    fontWeight: FontWeight.w900,
    height: 40 / 34,
  );

  static final b3s30light = _style(
    fontSize: 30,
    fontWeight: FontWeight.w300,
    height: 36 / 30,
  );
  static final b4s30regular = _style(
    fontSize: 30,
    fontWeight: FontWeight.w400,
    height: 36 / 30,
  );
  static final b5s30medium = _style(
    fontSize: 30,
    fontWeight: FontWeight.w500,
    height: 36 / 30,
  );
  static final b6s30semiBold = _style(
    fontSize: 30,
    fontWeight: FontWeight.w600,
    height: 36 / 30,
  );
  static final b7s30bold = _style(
    fontSize: 30,
    fontWeight: FontWeight.w700,
    height: 36 / 30,
  );
  static final b8s30extraBold = _style(
    fontSize: 30,
    fontWeight: FontWeight.w800,
    height: 36 / 30,
  );
  static final b9s30black = _style(
    fontSize: 30,
    fontWeight: FontWeight.w900,
    height: 36 / 30,
  );

  static final b3s26light = _style(
    fontSize: 26,
    fontWeight: FontWeight.w300,
    height: 32 / 26,
  );
  static final b4s26regular = _style(
    fontSize: 26,
    fontWeight: FontWeight.w400,
    height: 32 / 26,
  );
  static final b5s26medium = _style(
    fontSize: 26,
    fontWeight: FontWeight.w500,
    height: 32 / 26,
  );
  static final b6s26semiBold = _style(
    fontSize: 26,
    fontWeight: FontWeight.w600,
    height: 32 / 26,
  );
  static final b7s26bold = _style(
    fontSize: 26,
    fontWeight: FontWeight.w700,
    height: 32 / 26,
  );
  static final b8s26extraBold = _style(
    fontSize: 26,
    fontWeight: FontWeight.w800,
    height: 32 / 26,
  );
  static final b9s26black = _style(
    fontSize: 26,
    fontWeight: FontWeight.w900,
    height: 32 / 26,
  );

  static final b3s24light = _style(
    fontSize: 24,
    fontWeight: FontWeight.w300,
    height: 32 / 24,
  );
  static final b4s24regular = _style(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    height: 32 / 24,
  );
  static final b5s24medium = _style(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    height: 32 / 24,
  );
  static final b6s24semiBold = _style(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 32 / 24,
  );
  static final b7s24bold = _style(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 32 / 24,
  );
  static final b8s24extraBold = _style(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    height: 32 / 24,
  );
  static final b9s24black = _style(
    fontSize: 24,
    fontWeight: FontWeight.w900,
    height: 32 / 24,
  );

  static final b3s22light = _style(
    fontSize: 22,
    fontWeight: FontWeight.w300,
    height: 28 / 22,
  );
  static final b4s22regular = _style(
    fontSize: 22,
    fontWeight: FontWeight.w400,
    height: 28 / 22,
  );
  static final b5s22medium = _style(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    height: 28 / 22,
  );
  static final b6s22semiBold = _style(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 28 / 22,
  );
  static final b7s22bold = _style(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    height: 28 / 22,
  );
  static final b8s22extraBold = _style(
    fontSize: 22,
    fontWeight: FontWeight.w800,
    height: 28 / 22,
  );
  static final b9s22black = _style(
    fontSize: 22,
    fontWeight: FontWeight.w900,
    height: 28 / 22,
  );

  static final b3s20light = _style(
    fontSize: 20,
    fontWeight: FontWeight.w300,
    height: 28 / 20,
  );
  static final b4s20regular = _style(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    height: 28 / 20,
  );
  static final b5s20medium = _style(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    height: 28 / 20,
  );
  static final b6s20semiBold = _style(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 28 / 20,
  );
  static final b7s20bold = _style(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 28 / 20,
  );
  static final b8s20extraBold = _style(
    fontSize: 20,
    fontWeight: FontWeight.w800,
    height: 28 / 20,
  );
  static final b9s20black = _style(
    fontSize: 20,
    fontWeight: FontWeight.w900,
    height: 28 / 20,
  );

  static final b3s18light = _style(
    fontSize: 18,
    fontWeight: FontWeight.w300,
    height: 26 / 18,
  );
  static final b4s18regular = _style(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    height: 26 / 18,
  );
  static final b5s18medium = _style(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    height: 26 / 18,
  );
  static final b6s18semiBold = _style(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 26 / 18,
  );
  static final b7s18bold = _style(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    height: 26 / 18,
  );
  static final b8s18extraBold = _style(
    fontSize: 18,
    fontWeight: FontWeight.w800,
    height: 26 / 18,
  );
  static final b9s18black = _style(
    fontSize: 18,
    fontWeight: FontWeight.w900,
    height: 26 / 18,
  );

  static final b3s16light = _style(
    fontSize: 16,
    fontWeight: FontWeight.w300,
    height: 24 / 16,
  );
  static final b4s16regular = _style(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 24 / 16,
  );
  static final b5s16medium = _style(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 24 / 16,
  );
  static final b6s16semiBold = _style(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 24 / 16,
  );
  static final b7s16bold = _style(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    height: 24 / 16,
  );
  static final b8s16extraBold = _style(
    fontSize: 16,
    fontWeight: FontWeight.w800,
    height: 24 / 16,
  );
  static final b9s16black = _style(
    fontSize: 16,
    fontWeight: FontWeight.w900,
    height: 24 / 16,
  );

  static final b3s14light = _style(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    height: 20 / 14,
  );
  static final b4s14regular = _style(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 20 / 14,
  );
  static final b5s14medium = _style(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 20 / 14,
  );
  static final b6s14semiBold = _style(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 20 / 14,
  );
  static final b7s14bold = _style(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    height: 20 / 14,
  );
  static final b8s14extraBold = _style(
    fontSize: 14,
    fontWeight: FontWeight.w800,
    height: 20 / 14,
  );
  static final b9s14black = _style(
    fontSize: 14,
    fontWeight: FontWeight.w900,
    height: 20 / 14,
  );

  static final b3s12light = _style(
    fontSize: 12,
    fontWeight: FontWeight.w300,
    height: 16 / 12,
  );
  static final b4s12regular = _style(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 16 / 12,
  );
  static final b5s12medium = _style(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 16 / 12,
  );
  static final b6s12semiBold = _style(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 16 / 12,
  );
  static final b7s12bold = _style(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    height: 16 / 12,
  );
  static final b8s12extraBold = _style(
    fontSize: 12,
    fontWeight: FontWeight.w800,
    height: 16 / 12,
  );
  static final b9s12black = _style(
    fontSize: 12,
    fontWeight: FontWeight.w900,
    height: 16 / 12,
  );

  static final b3s10light = _style(
    fontSize: 10,
    fontWeight: FontWeight.w300,
    height: 12 / 10,
  );
  static final b4s10regular = _style(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    height: 12 / 10,
  );
  static final b5s10medium = _style(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    height: 12 / 10,
  );
  static final b6s10semiBold = _style(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    height: 12 / 10,
  );
  static final b7s10bold = _style(
    fontSize: 10,
    fontWeight: FontWeight.w700,
    height: 12 / 10,
  );
  static final b8s10extraBold = _style(
    fontSize: 10,
    fontWeight: FontWeight.w800,
    height: 12 / 10,
  );
  static final b9s10black = _style(
    fontSize: 10,
    fontWeight: FontWeight.w900,
    height: 12 / 10,
  );

  // Italic variants (size 16)
  static final b3s16lightItalic = _style(
    fontSize: 16,
    fontWeight: FontWeight.w300,
    fontStyle: FontStyle.italic,
    height: 24 / 16,
  );
  static final b4s16italic = _style(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
    height: 24 / 16,
  );
  static final b5s16mediumItalic = _style(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.italic,
    height: 24 / 16,
  );
  static final b6s16semiBoldItalic = _style(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.italic,
    height: 24 / 16,
  );
  static final b7s16boldItalic = _style(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.italic,
    height: 24 / 16,
  );
  static final b8s16extraBoldItalic = _style(
    fontSize: 16,
    fontWeight: FontWeight.w800,
    fontStyle: FontStyle.italic,
    height: 24 / 16,
  );
  static final b9s16blackItalic = _style(
    fontSize: 16,
    fontWeight: FontWeight.w900,
    fontStyle: FontStyle.italic,
    height: 24 / 16,
  );
}
