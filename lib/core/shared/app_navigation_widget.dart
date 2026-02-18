import 'dart:ui';

import 'package:finance_flow/core/generated/assets/assets.gen.dart';
import 'package:finance_flow/core/router/page_transitions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppNavigationWidget extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const AppNavigationWidget({super.key, required this.navigationShell});

  /// -1 = none selected, 0 = home, 1 = chart, 2 = search, 3 = menu

  static const double _iconSize = 28;
  static const double _dotSize = 6;

  static Widget _svgIcon(SvgGenImage asset, Color color, double size) {
    return asset.svg(
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }

  void _onTap(int index) {
    final isReselect = navigationShell.currentIndex == index;

    if (isReselect) {
      setDismissDown(); // <-- важно: reset ветки должен закрывать модалки вниз
    }

    navigationShell.goBranch(index, initialLocation: isReselect);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;

    final selectedColor = colorScheme.primary;
    final unselectedColor = colorScheme.onSurfaceVariant.withValues(alpha: 0.6);
    final backgroundColor = isDark
        ? colorScheme.surface.withValues(alpha: 0.3)
        : colorScheme.surface.withValues(alpha: 0.6);

    final borderColor = isDark
        ? colorScheme.onSurface.withValues(alpha: 0.1)
        : colorScheme.onSurface.withValues(alpha: 0.05);

    final borderRadius = BorderRadius.circular(30);

    return Scaffold(
      body: Stack(
        children: [
          navigationShell,
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 24),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: ClipRRect(
                borderRadius: borderRadius,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: borderRadius,
                      border: Border.all(color: borderColor, width: 1),
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
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _NavItem(
                          iconBuilder: (color, isSelected) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _svgIcon(Assets.icons.home, color, _iconSize),
                              if (isSelected) ...[
                                const SizedBox(height: 4),
                                Container(
                                  width: _dotSize,
                                  height: _dotSize,
                                  decoration: BoxDecoration(
                                    color: selectedColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            ],
                          ),
                          isSelected: navigationShell.currentIndex == 0,
                          selectedColor: selectedColor,
                          unselectedColor: unselectedColor,
                          onTap: () => _onTap(0),
                        ),
                        _NavItem(
                          iconBuilder: (color, isSelected) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _svgIcon(
                                Assets.icons.chartClusterBar,
                                color,
                                _iconSize,
                              ),
                              if (isSelected) ...[
                                const SizedBox(height: 4),
                                Container(
                                  width: _dotSize,
                                  height: _dotSize,
                                  decoration: BoxDecoration(
                                    color: selectedColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            ],
                          ),
                          isSelected: navigationShell.currentIndex == 1,
                          selectedColor: selectedColor,
                          unselectedColor: unselectedColor,
                          onTap: () => _onTap(1),
                        ),
                        _NavItem(
                          iconBuilder: (color, isSelected) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _svgIcon(Assets.icons.search, color, _iconSize),
                              if (isSelected) ...[
                                const SizedBox(height: 4),
                                Container(
                                  width: _dotSize,
                                  height: _dotSize,
                                  decoration: BoxDecoration(
                                    color: selectedColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            ],
                          ),
                          isSelected: navigationShell.currentIndex == 2,
                          selectedColor: selectedColor,
                          unselectedColor: unselectedColor,
                          onTap: () => _onTap(2),
                        ),
                        _NavItem(
                          iconBuilder: (color, isSelected) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _svgIcon(
                                Assets.icons.researchHintonPlot,
                                color,
                                _iconSize,
                              ),
                              if (isSelected) ...[
                                const SizedBox(height: 4),
                                Container(
                                  width: _dotSize,
                                  height: _dotSize,
                                  decoration: BoxDecoration(
                                    color: selectedColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            ],
                          ),
                          isSelected: navigationShell.currentIndex == 3,
                          selectedColor: selectedColor,
                          unselectedColor: unselectedColor,
                          onTap: () => _onTap(3),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
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
    required this.onTap,
  });

  final Widget Function(Color color, bool isSelected) iconBuilder;
  final bool isSelected;
  final Color selectedColor;
  final Color unselectedColor;
  final VoidCallback onTap;

  static const double _itemPaddingH = 20;
  static const double _itemPaddingV = 12;

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? selectedColor : unselectedColor;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(32),
        splashColor: selectedColor.withValues(alpha: 0.1),
        highlightColor: Colors.transparent,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(
            horizontal: _itemPaddingH,
            vertical: _itemPaddingV,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? selectedColor.withValues(alpha: 0.08)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(32),
          ),
          child: iconBuilder(color, isSelected),
        ),
      ),
    );
  }
}
