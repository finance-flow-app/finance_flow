import 'dart:ui';

import 'package:flutter/material.dart';

/// AppBar в стиле LiquidGlass (блюр, градиент, скругление снизу).
class AppCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppCustomAppBar({
    super.key,
    required this.title,
    this.blurSigma = 3,
    this.bottomRadius = 24,
  });

  final Widget title;

  /// Сила блюра (как в navbar и CustomWidgetContainer).
  final double blurSigma;

  /// Радиус скругления нижних углов.
  final double bottomRadius;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;
    final backgroundColor = isDark
        ? colorScheme.surface.withValues(alpha: 0.3)
        : colorScheme.surface.withValues(alpha: 0.6);
    final borderColor = isDark
        ? colorScheme.onSurface.withValues(alpha: 0.1)
        : colorScheme.onSurface.withValues(alpha: 0.05);
    final appBarBorderRadius = BorderRadius.vertical(
      bottom: Radius.circular(bottomRadius),
    );

    return AppBar(
      title: title,
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      iconTheme: IconThemeData(color: colorScheme.onSurface),
      flexibleSpace: ClipRRect(
        borderRadius: appBarBorderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: appBarBorderRadius,
              border: Border(
                left: BorderSide(color: borderColor, width: 1),
                right: BorderSide(color: borderColor, width: 1),
                bottom: BorderSide(color: borderColor, width: 1),
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  backgroundColor,
                  backgroundColor.withValues(alpha: 0.25),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.15),
                  blurRadius: 16,
                  offset: const Offset(0, -4),
                  spreadRadius: -4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
