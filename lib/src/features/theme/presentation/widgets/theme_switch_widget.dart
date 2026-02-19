import 'package:finance_flow/core/assets/app_fonts.dart';
import 'package:finance_flow/core/generated/assets/assets.gen.dart';
import 'package:finance_flow/core/shared/custom_widget_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Переключатель темы в стиле iOS (CupertinoSlidingSegmentedControl).
/// Light / Dark / System с иконками light, moon, brightnessContrast.
class ThemeSwitchWidget extends StatelessWidget {
  const ThemeSwitchWidget({
    super.key,
    required this.selectedThemeMode,
    required this.onThemeModeChanged,
  });

  final ThemeMode selectedThemeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return CustomWidgetContainer(
      borderRadius: BorderRadius.circular(20),
      padding: const EdgeInsets.all(8),
      child: CupertinoSlidingSegmentedControl<ThemeMode>(
        groupValue: selectedThemeMode,
        thumbColor: colorScheme.primary,
        backgroundColor: colorScheme.surfaceContainerHigh.withValues(
          alpha: 0.4,
        ),
        padding: const EdgeInsets.all(4),
        children: {
          ThemeMode.light: _ThemeSegment(
            icon: Assets.icons.light,
            label: 'Light',
            isSelected: selectedThemeMode == ThemeMode.light,
          ),
          ThemeMode.dark: _ThemeSegment(
            icon: Assets.icons.moon,
            label: 'Dark',
            isSelected: selectedThemeMode == ThemeMode.dark,
          ),
          ThemeMode.system: _ThemeSegment(
            icon: Assets.icons.brightnessContrast,
            label: 'System',
            isSelected: selectedThemeMode == ThemeMode.system,
          ),
        },
        onValueChanged: (ThemeMode? value) {
          if (value != null) onThemeModeChanged(value);
        },
      ),
    );
  }
}

class _ThemeSegment extends StatelessWidget {
  const _ThemeSegment({
    required this.icon,
    required this.label,
    required this.isSelected,
  });

  final SvgGenImage icon;
  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final fgColor = isSelected
        ? colorScheme.onPrimary
        : colorScheme.onSurfaceVariant;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon.svg(
            width: 22,
            height: 22,
            colorFilter: ColorFilter.mode(fgColor, BlendMode.srcIn),
          ),
          const SizedBox(width: 8),
          Text(label, style: AppFonts.b5s16medium.copyWith(color: fgColor)),
        ],
      ),
    );
  }
}
