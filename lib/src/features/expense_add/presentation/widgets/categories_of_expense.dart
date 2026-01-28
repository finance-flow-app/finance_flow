import 'package:easy_localization/easy_localization.dart';
import 'package:finance_flow/core/assets/app_fonts.dart';
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
    LocaleKeys.categories_transport,
    LocaleKeys.categories_shopping,
    LocaleKeys.categories_bills,
    LocaleKeys.categories_sources,
    LocaleKeys.categories_education,
    'categories.other',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: _categoryKeys.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final categoryKey = _categoryKeys[index];
          final isSelected = categoryKey == selectedCategory;

          return GestureDetector(
            onTap: () => onCategorySelected(isSelected ? null : categoryKey),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(
                          context,
                        ).colorScheme.outline.withValues(alpha: 0.3),
                ),
              ),
              child: Text(
                categoryKey.tr(),
                style: AppFonts.b4s14regular.copyWith(
                  color: isSelected
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
