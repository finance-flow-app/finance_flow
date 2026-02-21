import 'package:easy_localization/easy_localization.dart';
import 'package:finance_flow/core/generated/localization/locale_keys.g.dart';
import 'package:finance_flow/core/shared/limit_card_widget.dart';
import 'package:finance_flow/src/features/expense_add/domain/entity/expense_add_limits_entity.dart';
import 'package:finance_flow/src/features/expense_add/presentation/Bloc/expense_add_bloc.dart';
import 'package:flutter/material.dart';

/// Карточка «Текущий лимит» на экране добавления расхода: сумма/лимит по периоду
/// (суммарный или по выбранной категории с учётом множителя дня/недели/месяца),
/// прогресс-бар и подпись. Использует общий [LimitCardWidget] из core/shared.
class CurrentLimitFieldWidget extends StatelessWidget {
  const CurrentLimitFieldWidget({
    super.key,
    required this.amount,
    required this.limitPeriod,
    required this.limits,
    this.selectedCategory,
  });

  final double amount;
  final LimitPeriod limitPeriod;
  final ExpenseAddLimitsEntity? limits;
  /// Ключ локали категории (например [LocaleKeys.categories_food]).
  final String? selectedCategory;

  /// Ключи в [ExpenseAddLimitsEntity.categoryLimitsPerDay] (фича limits).
  static String? _categoryLocaleKeyToLimitKey(String? localeKey) {
    if (localeKey == null) return null;
    final suffix = localeKey.contains('.') ? localeKey.split('.').last : localeKey;
    return switch (suffix) {
      'restaurants' => 'restaurant',
      'other_category' => 'other',
      'food' => 'food',
      'taxi' => 'taxi',
      'transport' => 'transport',
      'shopping' => 'shopping',
      'bills' => 'bills',
      'education' => 'education',
      'health' => 'health',
      'entertainment' => 'entertainment',
      'internet' => 'internet',
      _ => suffix,
    };
  }

  /// Эффективный лимит для отображения: суммарный по периоду или лимит по категории × множитель.
  static double? _effectiveLimit(
    ExpenseAddLimitsEntity? limits,
    LimitPeriod limitPeriod,
    String? selectedCategory,
  ) {
    if (limits == null) return null;
    final multiplier = limitPeriodMultiplier(limitPeriod);
    if (selectedCategory == null) {
      return switch (limitPeriod) {
        LimitPeriod.day => limits.limitForDay,
        LimitPeriod.week => limits.limitForWeek,
        LimitPeriod.month => limits.limitForMonth,
      };
    }
    final key = _categoryLocaleKeyToLimitKey(selectedCategory);
    if (key == null) return limits.limitForDay * multiplier;
    final perDay = limits.categoryLimitsPerDay[key];
    if (perDay == null) {
      return switch (limitPeriod) {
        LimitPeriod.day => limits.limitForDay,
        LimitPeriod.week => limits.limitForWeek,
        LimitPeriod.month => limits.limitForMonth,
      };
    }
    return perDay * multiplier;
  }

  @override
  Widget build(BuildContext context) {
    final limit = _effectiveLimit(limits, limitPeriod, selectedCategory);
    return LimitCardWidget(
      title: LocaleKeys.current_limit.tr(),
      amount: amount,
      limit: limit,
      subtitle: switch (limitPeriod) {
        LimitPeriod.day => LocaleKeys.limit_for_period_day.tr(),
        LimitPeriod.week => LocaleKeys.limit_for_period_week.tr(),
        LimitPeriod.month => LocaleKeys.limit_for_period_month.tr(),
      },
      exceededMessage: switch (limitPeriod) {
        LimitPeriod.day => LocaleKeys.limit_exceeded_day.tr(),
        LimitPeriod.week => LocaleKeys.limit_exceeded_week.tr(),
        LimitPeriod.month => LocaleKeys.limit_exceeded_month.tr(),
      },
      decorativeBackground: true,
    );
  }
}
