import 'package:flutter/material.dart';
import 'package:finance_flow/core/shared/custom_widget_container.dart';

class AddExpenseButton extends StatelessWidget
    implements LiquidGlassBorderRadiusProvider {
  const AddExpenseButton({
    super.key,
    required this.isEnabled,
    required this.isSubmitting,
    required this.onPressed,
    required this.child,
  });

  final bool isEnabled;
  final bool isSubmitting;
  final VoidCallback onPressed;
  final Widget child;

  /// Радиус контура виджета.
  static const BorderRadius kLiquidGlassBorderRadius = BorderRadius.all(
    Radius.circular(38),
  );

  @override
  BorderRadius get liquidGlassBorderRadius => kLiquidGlassBorderRadius;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final primary = colorScheme.primary;

    if (!isEnabled) {
      return SizedBox(
        width: double.infinity,
        height: 76,
        child: Material(
          color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
          borderRadius: liquidGlassBorderRadius,
          child: Center(child: child),
        ),
      );
    }

    final centerColor = Color.lerp(primary, colorScheme.shadow, 0.35)!;
    final edgeColor = Color.lerp(primary, colorScheme.tertiary, 0.25)!;
    final glowColor = Color.lerp(primary, colorScheme.tertiary, 0.2)!;

    return SizedBox(
      width: double.infinity,
      height: 76,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isSubmitting ? null : onPressed,
          borderRadius: liquidGlassBorderRadius,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [edgeColor, primary, centerColor, primary, edgeColor],
                stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
              ),
              borderRadius: liquidGlassBorderRadius,
              boxShadow: [
                BoxShadow(
                  color: glowColor.withValues(alpha: 0.9),
                  blurRadius: 8,
                  spreadRadius: 1,
                  offset: const Offset(0, 0),
                ),
                BoxShadow(
                  color: glowColor.withValues(alpha: 0.7),
                  blurRadius: 20,
                  spreadRadius: 0,
                  offset: const Offset(0, 0),
                ),
                BoxShadow(
                  color: glowColor.withValues(alpha: 0.4),
                  blurRadius: 40,
                  spreadRadius: -6,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Center(child: child),
          ),
        ),
      ),
    );
  }
}
