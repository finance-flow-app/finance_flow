import 'package:easy_localization/easy_localization.dart';
import 'package:finance_flow/core/assets/app_fonts.dart';
import 'package:finance_flow/core/generated/localization/locale_keys.g.dart';
import 'package:finance_flow/src/features/manage_categories/presentation/bloc/manage_categories_bloc.dart';
import 'package:flutter/material.dart';

/// Горизонтальный скроллируемый ряд чипов групп категорий для фильтрации списка.
/// По аналогии с [CategoryFilterWidget] в expenses_history.
class GroupChipsRowWidget extends StatelessWidget {
  const GroupChipsRowWidget({
    super.key,
    required this.selectedGroup,
    required this.onGroupSelected,
  });

  final CategoryGroup selectedGroup;
  final ValueChanged<CategoryGroup> onGroupSelected;

  static const List<CategoryGroup> _groups = CategoryGroup.values;

  /// Радиус контура виджета. Использовать тот же в [CustomWidgetContainer].
  static const BorderRadius liquidGlassBorderRadius = BorderRadius.all(
    Radius.circular(18),
  );

  static double get _horizontalPadding => liquidGlassBorderRadius.topLeft.x;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(right: _horizontalPadding),
        itemCount: _groups.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final group = _groups[index];
          final isSelected = group == selectedGroup;
          return _GroupChip(
            group: group,
            isSelected: isSelected,
            onTap: () {
              // Повторное нажатие на выбранный чип сбрасывает фильтр на "All"
              if (isSelected) {
                onGroupSelected(CategoryGroup.all);
              } else {
                onGroupSelected(group);
              }
            },
          );
        },
      ),
    );
  }
}

class _GroupChip extends StatelessWidget {
  const _GroupChip({
    required this.group,
    required this.isSelected,
    required this.onTap,
  });

  final CategoryGroup group;
  final bool isSelected;
  final VoidCallback onTap;

  static String _localeKey(CategoryGroup group) {
    return switch (group) {
      CategoryGroup.all => LocaleKeys.manage_categories_groups_all,
      CategoryGroup.essentials =>
        LocaleKeys.manage_categories_groups_essentials,
      CategoryGroup.lifestyle => LocaleKeys.manage_categories_groups_lifestyle,
      CategoryGroup.work => LocaleKeys.manage_categories_groups_work,
      CategoryGroup.subscriptions =>
        LocaleKeys.manage_categories_groups_subscriptions,
      CategoryGroup.custom => LocaleKeys.manage_categories_groups_custom,
    };
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.primary
              : colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? colorScheme.primary
                : colorScheme.outline.withValues(alpha: 0.3),
          ),
        ),
        child: Text(
          _localeKey(group).tr(),
          style: AppFonts.b4s14regular.copyWith(
            color: isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
