import 'dart:ui';
import 'package:flutter/material.dart';

abstract interface class LiquidGlassBorderRadiusProvider {
  BorderRadius get liquidGlassBorderRadius;
}

class CustomWidgetContainer extends StatelessWidget {
  const CustomWidgetContainer({
    super.key,
    required this.child,
    this.borderRadius,
    this.padding,
    this.outerPadding,
    this.margin,
    this.blurSigma = 3,
  });

  final Widget child;

  /// Если null — попробуем взять из child (если он LiquidGlassBorderRadiusProvider).
  final BorderRadius? borderRadius;

  /// Внутренний padding (внутри "стекла").
  final EdgeInsetsGeometry? padding;

  /// Внешний padding вокруг "стекла" (как padding у контейнера-обёртки в navbar).
  final EdgeInsetsGeometry? outerPadding;

  final EdgeInsetsGeometry? margin;

  /// Сила блюра (как в navbar = 3).
  final double blurSigma;

  @override
  Widget build(BuildContext context) {
    final providedRadius = borderRadius;
    final inferredRadius = (child is LiquidGlassBorderRadiusProvider)
        ? (child as LiquidGlassBorderRadiusProvider).liquidGlassBorderRadius
        : null;

    final radius = providedRadius ?? inferredRadius;
    if (radius == null) {
      throw FlutterError(
        'CustomWidgetContainer: borderRadius is null, and child does not '
        'implement LiquidGlassBorderRadiusProvider.\n'
        'Передай borderRadius вручную или сделай child провайдером радиуса.',
      );
    }

    final colorScheme = Theme.of(context).colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;

    final backgroundColor = isDark
        ? colorScheme.surface.withValues(alpha: 0.3)
        : colorScheme.surface.withValues(alpha: 0.6);

    final borderColor = isDark
        ? colorScheme.onSurface.withValues(alpha: 0.1)
        : colorScheme.onSurface.withValues(alpha: 0.05);
    final shadows = [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.1),
        blurRadius: 30,
        offset: const Offset(0, 10),
      ),
      BoxShadow(
        color: Colors.white.withValues(alpha: 0.2),
        blurRadius: 20,
        offset: const Offset(0, -5),
        spreadRadius: -5,
      ),
    ];

    Widget content = DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: radius,
        boxShadow: shadows,
      ),
      child: ClipRRect(
        borderRadius: radius,
        clipBehavior: Clip.antiAlias,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: radius,
              border: Border.all(color: borderColor, width: 1),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  backgroundColor,
                  backgroundColor.withValues(alpha: 0.25),
                ],
              ),
            ),
            padding: padding ?? EdgeInsets.zero,
            child: child,
          ),
        ),
      ),
    );

    if (outerPadding != null) {
      content = Padding(padding: outerPadding!, child: content);
    }

    if (margin != null) {
      content = Padding(padding: margin!, child: content);
    }

    return content;
  }
}
