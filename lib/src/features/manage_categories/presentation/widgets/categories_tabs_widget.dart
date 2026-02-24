import 'package:easy_localization/easy_localization.dart';
import 'package:finance_flow/core/assets/app_fonts.dart';
import 'package:finance_flow/core/generated/localization/locale_keys.g.dart';
import 'package:finance_flow/core/shared/custom_widget_container.dart';
import 'package:finance_flow/src/features/manage_categories/presentation/bloc/manage_categories_bloc.dart';
import 'package:flutter/material.dart';

/// Переключатель табов категорий (Active / Archived / Auto) в стиле liquid glass,
/// по аналогии с [PeriodSegmentSwitcher].
class CategoriesTabsWidget extends StatelessWidget {
  const CategoriesTabsWidget({
    super.key,
    required this.selectedTab,
    required this.onTabChanged,
  });

  final CategoryTab selectedTab;
  final ValueChanged<CategoryTab> onTabChanged;

  static const List<CategoryTab> _tabs = CategoryTab.values;

  static const BorderRadius kLiquidGlassBorderRadius = BorderRadius.all(
    Radius.circular(16),
  );

  String _getTabLabel(CategoryTab tab) {
    return switch (tab) {
      CategoryTab.active => LocaleKeys.manage_categories_tabs_active.tr(),
      CategoryTab.archived => LocaleKeys.manage_categories_tabs_archived.tr(),
      CategoryTab.auto => LocaleKeys.manage_categories_tabs_auto.tr(),
    };
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return CustomWidgetContainer(
      borderRadius: kLiquidGlassBorderRadius,
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          for (final tab in _tabs)
            Expanded(
              child: _CategoriesSegment(
                tab: tab,
                isSelected: tab == selectedTab,
                label: _getTabLabel(tab),
                colorScheme: colorScheme,
                onTap: () {
                  if (tab == selectedTab) {
                    onTabChanged(CategoryTab.active);
                  } else {
                    onTabChanged(tab);
                  }
                },
              ),
            ),
        ],
      ),
    );
  }
}

class _CategoriesSegment extends StatelessWidget {
  const _CategoriesSegment({
    required this.tab,
    required this.isSelected,
    required this.label,
    required this.colorScheme,
    required this.onTap,
  });

  final CategoryTab tab;
  final bool isSelected;
  final String label;
  final ColorScheme colorScheme;
  final VoidCallback onTap;

  static const double _radius = 12;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(_radius),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? null : Colors.transparent,
            gradient: isSelected
                ? LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color.lerp(
                        colorScheme.primary,
                        colorScheme.primaryContainer,
                        0.4,
                      )!,
                      colorScheme.primary,
                      Color.lerp(
                        colorScheme.primary,
                        colorScheme.primaryContainer,
                        0.4,
                      )!,
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  )
                : null,
            borderRadius: BorderRadius.circular(_radius),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 6),
              Text(
                label,
                style: AppFonts.b5s18medium.copyWith(
                  color: isSelected
                      ? colorScheme.onPrimary
                      : colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
