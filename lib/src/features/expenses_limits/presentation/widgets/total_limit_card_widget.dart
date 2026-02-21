import 'package:easy_localization/easy_localization.dart';
import 'package:finance_flow/core/generated/localization/locale_keys.g.dart';
import 'package:finance_flow/core/shared/custom_widget_container.dart';
import 'package:finance_flow/core/shared/limit_card_widget.dart';
import 'package:flutter/material.dart';

/// Период лимита для подписи «Текущий лимит за день/неделю/месяц».
enum TotalLimitPeriod { day, week, month }

/// Множитель периода: день = 1, неделя = 7, месяц = 30.
extension TotalLimitPeriodFactor on TotalLimitPeriod {
  int get periodFactor => switch (this) {
    TotalLimitPeriod.day => 1,
    TotalLimitPeriod.week => 7,
    TotalLimitPeriod.month => 30,
  };
}

/// Карточка «Total limit»: общий лимит за период, одна сумма и полностью
/// заполненная градиентная полоска. Использует [LimitCardWidget] из core/shared.
class TotalLimitCardWidget extends StatelessWidget {
  const TotalLimitCardWidget({
    super.key,
    required this.amount,
    required this.period,
  });

  final double amount;
  final TotalLimitPeriod period;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomWidgetContainer(
        borderRadius: LimitCardWidget.kLiquidGlassBorderRadius,
        child: LimitCardWidget(
          title: LocaleKeys.expenses_limits_total_limit.tr(),
          amount: amount,
          subtitle: switch (period) {
            TotalLimitPeriod.day =>
              LocaleKeys.expenses_limits_current_limit_for_day.tr(),
            TotalLimitPeriod.week =>
              LocaleKeys.expenses_limits_current_limit_for_week.tr(),
            TotalLimitPeriod.month =>
              LocaleKeys.expenses_limits_current_limit_for_month.tr(),
          },
          limit: null,
          decorativeBackground: false,
        ),
      ),
    );
  }
}
