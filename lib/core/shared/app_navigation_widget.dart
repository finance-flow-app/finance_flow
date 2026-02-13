import 'dart:ui';

import 'package:finance_flow/core/generated/assets/assets.gen.dart';
import 'package:finance_flow/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppNavigationWidget extends StatelessWidget {
  const AppNavigationWidget({
    super.key,
    this.selectedIndex = -1,
    this.bottomPadding,
  });

  /// -1 = none selected, 0 = home, 1 = chart, 2 = search, 3 = menu
  final int selectedIndex;

  final double? bottomPadding;

  static const double _iconSize = 32;
  static const double _dotSize = 7;

  static Widget _svgIcon(SvgGenImage asset, Color color, double size) {
    return asset.svg(
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;

    final selectedColor = isDark ? colorScheme.onSurface : colorScheme.primary;
    final unselectedColor = colorScheme.onSurfaceVariant.withValues(alpha: 0.7);
    final selectedBackgroundColor = isDark
        ? colorScheme.surfaceContainerHigh.withValues(alpha: 0.9)
        : colorScheme.surfaceContainerLowest;

    final borderRadius = BorderRadius.circular(48);

    return Container(
      margin: EdgeInsets.zero,
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: 0.18),
              blurRadius: 28,
              offset: const Offset(0, 10),
              spreadRadius: -6,
            ),
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: 0.1),
              blurRadius: 14,
              offset: const Offset(0, 5),
              spreadRadius: -2,
            ),
            BoxShadow(
              color: colorScheme.primary.withValues(alpha: 0.15),
              blurRadius: 24,
              offset: const Offset(0, 6),
              spreadRadius: 0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: borderRadius,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              padding: EdgeInsets.fromLTRB(12, 20, 12, 20),
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                border: Border.all(
                  color: colorScheme.primary.withValues(alpha: 0.5),
                  width: 1.5,
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: isDark
                      ? [
                          Color.lerp(
                            colorScheme.primaryContainer,
                            colorScheme.primary,
                            0.35,
                          )!,
                          colorScheme.primaryContainer,
                          Color.lerp(
                            colorScheme.primaryContainer,
                            colorScheme.surface,
                            0.3,
                          )!,
                        ]
                      : [
                          Color.lerp(
                            colorScheme.surfaceContainerLowest,
                            colorScheme.primaryContainer,
                            0.5,
                          )!,
                          colorScheme.primaryContainer,
                          Color.lerp(
                            colorScheme.primaryContainer,
                            colorScheme.primary.withValues(alpha: 0.12),
                            0.6,
                          )!,
                        ],
                  stops: const [0.0, 0.4, 1.0],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _NavItem(
                    iconBuilder: (color) =>
                        _svgIcon(Assets.icons.home, color, _iconSize),
                    isSelected: selectedIndex == 0,
                    selectedColor: selectedColor,
                    unselectedColor: unselectedColor,
                    selectedBackgroundColor: selectedBackgroundColor,
                    onTap: () => context.pushNamed(MobilePages.homePage.name),
                  ),
                  _NavItem(
                    iconBuilder: (color) => _svgIcon(
                      Assets.icons.chartClusterBar,
                      color,
                      _iconSize,
                    ),
                    isSelected: selectedIndex == 1,
                    selectedColor: selectedColor,
                    unselectedColor: unselectedColor,
                    selectedBackgroundColor: selectedBackgroundColor,
                    onTap: () {},
                  ),
                  _NavItem(
                    iconBuilder: (color) =>
                        _svgIcon(Assets.icons.search, color, _iconSize),
                    isSelected: selectedIndex == 2,
                    selectedColor: selectedColor,
                    unselectedColor: unselectedColor,
                    selectedBackgroundColor: selectedBackgroundColor,
                    onTap: () {},
                  ),
                  _NavItem(
                    iconBuilder: (color) => _svgIcon(
                      Assets.icons.researchHintonPlot,
                      color,
                      _iconSize,
                    ),
                    isSelected: selectedIndex == 3,
                    selectedColor: selectedColor,
                    unselectedColor: unselectedColor,
                    selectedBackgroundColor: selectedBackgroundColor,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.iconBuilder,
    required this.isSelected,
    required this.selectedColor,
    required this.unselectedColor,
    required this.selectedBackgroundColor,
    required this.onTap,
  });

  final Widget Function(Color color) iconBuilder;
  final bool isSelected;
  final Color selectedColor;
  final Color unselectedColor;
  final Color selectedBackgroundColor;
  final VoidCallback onTap;

  static const double _itemPaddingH = 24;
  static const double _itemPaddingV = 14;

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? selectedColor : unselectedColor;

    Widget content = Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: _itemPaddingH,
        vertical: _itemPaddingV,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          iconBuilder(color),
          if (isSelected) ...[
            const SizedBox(height: 6),
            Container(
              width: AppNavigationWidget._dotSize,
              height: AppNavigationWidget._dotSize,
              decoration: BoxDecoration(
                color: selectedColor,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ],
      ),
    );

    if (isSelected) {
      content = Container(
        decoration: BoxDecoration(
          color: selectedBackgroundColor,
          borderRadius: BorderRadius.circular(999),
        ),
        child: content,
      );
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: content,
      ),
    );
  }
}
