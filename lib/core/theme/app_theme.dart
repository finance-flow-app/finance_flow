import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:finance_flow/core/assets/app_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// The [AppTheme] defines light and dark themes for the app.
///
/// Важная идея (как в твоём референсе):
/// - Тема (ColorScheme + subThemes) отвечает за компоненты (кнопки, карточки, поля).
/// - Общий фон/градиент/свечение рисуется отдельно (AppBackground),
///   поэтому Scaffold делаем прозрачным.
abstract final class AppTheme {
  /// ✅ Dark: ближе к референсу (неон + “glass”)
  static const FlexSchemeColor _neonPurpleDark = FlexSchemeColor(
    primary: Color(0xFFB26DFF), // brighter neon purple
    primaryContainer: Color(0xFF2A0B52), // rich purple surface
    secondary: Color(0xFF44D7FF), // cyan neon
    secondaryContainer: Color(0xFF062B33),
    tertiary: Color(0xFFFF4FD8), // neon magenta
    tertiaryContainer: Color(0xFF3A0A2C),
  );

  /// ✅ Light: не “белый лист”, а пастельный lavender/frosted
  static const FlexSchemeColor _neonPurpleLight = FlexSchemeColor(
    primary: Color(0xFF7B3DFF), // modern purple
    primaryContainer: Color(0xFFE9DDFF), // lavender surface
    secondary: Color(0xFF1AA3C8), // fresh cyan
    secondaryContainer: Color(0xFFD7F6FF),
    tertiary: Color(0xFFD43AAE), // soft magenta
    tertiaryContainer: Color(0xFFFFD8F2),
  );

  /// Light theme (пастель + frosted glass компоненты).
  static final ThemeData light =
      FlexThemeData.light(
        colors: _neonPurpleLight,
        useMaterial3: true,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 12,
        fontFamily: AppFonts.fontFamily,
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
        subThemesData: const FlexSubThemesData(
          interactionEffects: true,
          tintedDisabledControls: true,
          useM2StyleDividerInM3: true,

          // Inputs: лёгкое стекло
          inputDecoratorIsFilled: true,
          inputDecoratorBorderType: FlexInputBorderType.outline,
          inputDecoratorRadius: 18,
          inputDecoratorFillColor: Color(0x66FFFFFF),

          // Shapes: pill/rounded
          filledButtonRadius: 999,
          elevatedButtonRadius: 999,
          outlinedButtonRadius: 999,
          textButtonRadius: 999,
          cardRadius: 26,
          chipRadius: 18,
          snackBarRadius: 18,
          bottomSheetRadius: 28,

          alignedDropdown: true,
          navigationRailUseIndicator: true,
        ),
      ).copyWith(
        // Прозрачный scaffold, чтобы был виден общий фон из AppBackground.
        scaffoldBackgroundColor: Colors.transparent,
        canvasColor: Colors.transparent,
        dividerColor: const Color(0x14000000),

        // Cards "frosted"
        cardTheme: CardThemeData(
          color: const Color(0xB3FFFFFF), // frosted white
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
          clipBehavior: Clip.antiAlias,
        ),

        dialogTheme: DialogThemeData(
          backgroundColor: const Color(0xD9FFFFFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),

        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: const Color(0xD9FFFFFF),
          modalBackgroundColor: const Color(0xD9FFFFFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),

        // Primary action в light — фиолетовая pill кнопка
        filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
            backgroundColor: const WidgetStatePropertyAll(Color(0xFF7B3DFF)),
            foregroundColor: const WidgetStatePropertyAll(Colors.white),
            padding: const WidgetStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            ),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
            ),
          ),
        ),

        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            foregroundColor: const WidgetStatePropertyAll(Color(0xFF2B2140)),
            side: const WidgetStatePropertyAll(
              BorderSide(color: Color(0x332B2140), width: 1),
            ),
            backgroundColor: const WidgetStatePropertyAll(Color(0x55FFFFFF)),
            padding: const WidgetStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            ),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
            ),
          ),
        ),

        progressIndicatorTheme: const ProgressIndicatorThemeData(
          strokeWidth: 2,
        ),
      );

  /// Dark theme (главная референсная).
  static final ThemeData dark =
      FlexThemeData.dark(
        colors: _neonPurpleDark,
        useMaterial3: true,
        darkIsTrueBlack: true,

        // Делает поверхности более “слоёными” и контрастными
        surfaceMode: FlexSurfaceMode.highScaffoldLevelSurface,
        blendLevel: 22,

        fontFamily: AppFonts.fontFamily,
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
        subThemesData: const FlexSubThemesData(
          interactionEffects: true,
          tintedDisabledControls: true,
          blendOnColors: true,
          useM2StyleDividerInM3: true,

          // Inputs: стекло + обводка
          inputDecoratorIsFilled: true,
          inputDecoratorBorderType: FlexInputBorderType.outline,
          inputDecoratorRadius: 18,
          inputDecoratorFillColor: Color(0x1EFFFFFF),

          // Shapes: pill/rounded
          filledButtonRadius: 999,
          elevatedButtonRadius: 999,
          outlinedButtonRadius: 999,
          textButtonRadius: 999,
          cardRadius: 26,
          chipRadius: 18,
          snackBarRadius: 18,
          bottomSheetRadius: 28,

          alignedDropdown: true,
          navigationRailUseIndicator: true,
        ),
      ).copyWith(
        // Фон рисуем через AppBackground.
        scaffoldBackgroundColor: Colors.transparent,
        canvasColor: Colors.transparent,
        dividerColor: const Color(0x1AFFFFFF),

        // Cards "glass"
        cardTheme: CardThemeData(
          color: const Color(0x14FFFFFF), // translucent white
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
          clipBehavior: Clip.antiAlias,
        ),

        dialogTheme: DialogThemeData(
          backgroundColor: const Color(0x1AFFFFFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),

        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: const Color(0x1AFFFFFF),
          modalBackgroundColor: const Color(0x1AFFFFFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),

        // ✅ Референс: primary action часто белой pill-кнопкой
        filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
              Colors.white.withValues(alpha: 0.92),
            ),
            foregroundColor: const WidgetStatePropertyAll(Color(0xFF140A1D)),
            padding: const WidgetStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            ),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
            ),
          ),
        ),

        // Secondary: “glass outline”
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            foregroundColor: const WidgetStatePropertyAll(Colors.white),
            side: WidgetStatePropertyAll(
              BorderSide(color: Colors.white.withValues(alpha: 0.22), width: 1),
            ),
            backgroundColor: const WidgetStatePropertyAll(Color(0x0FFFFFFF)),
            padding: const WidgetStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            ),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
            ),
          ),
        ),

        listTileTheme: const ListTileThemeData(
          iconColor: Colors.white70,
          textColor: Colors.white,
        ),

        progressIndicatorTheme: const ProgressIndicatorThemeData(
          strokeWidth: 2,
        ),
      );
}
