import 'package:easy_localization/easy_localization.dart';
import 'package:finance_flow/core/assets/app_fonts.dart';
import 'package:finance_flow/core/generated/assets/assets.gen.dart';
import 'package:finance_flow/core/generated/localization/locale_keys.g.dart';
import 'package:flutter/material.dart';

class CategoriesOfExpenseWidget extends StatelessWidget {
  const CategoriesOfExpenseWidget({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  final String? selectedCategory;
  final ValueChanged<String?> onCategorySelected;

  static const List<String> _categoryKeys = [
    LocaleKeys.categories_food,
    LocaleKeys.categories_restaurants,
    LocaleKeys.categories_taxi,
    LocaleKeys.categories_transport,
    LocaleKeys.categories_shopping,
    LocaleKeys.categories_bills,
    LocaleKeys.categories_education,
    LocaleKeys.categories_health,
    LocaleKeys.categories_entertainment,
    LocaleKeys.categories_internet,
    LocaleKeys.categories_other,
  ];

  static Widget _iconForCategoryKey(
    String categoryKey, {
    required double size,
    Color? color,
  }) {
    final svg = switch (categoryKey) {
      LocaleKeys.categories_food => Assets.icons.apple,
      LocaleKeys.categories_restaurants => Assets.icons.restaurant,
      LocaleKeys.categories_taxi => Assets.icons.taxi,
      LocaleKeys.categories_transport => Assets.icons.train,
      LocaleKeys.categories_shopping => Assets.icons.shoppingCart,
      LocaleKeys.categories_bills => Assets.icons.catalog,
      LocaleKeys.categories_education => Assets.icons.education,
      LocaleKeys.categories_health => Assets.icons.healthCross,
      LocaleKeys.categories_entertainment => Assets.icons.faceSatisfied,
      LocaleKeys.categories_internet => Assets.icons.wifi,
      _ => Assets.icons.filter,
    };
    return svg.svg(
      width: size,
      height: size,
      colorFilter: color != null
          ? ColorFilter.mode(color, BlendMode.srcIn)
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: _categoryKeys.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final categoryKey = _categoryKeys[index];
          final isSelected = categoryKey == selectedCategory;

          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => onCategorySelected(isSelected ? null : categoryKey),
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
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _iconForCategoryKey(
                    categoryKey,
                    size: 18,
                    color: isSelected
                        ? colorScheme.onPrimary
                        : colorScheme.onSurface,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    categoryKey.tr(),
                    style: AppFonts.b4s14regular.copyWith(
                      color: isSelected
                          ? colorScheme.onPrimary
                          : colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
