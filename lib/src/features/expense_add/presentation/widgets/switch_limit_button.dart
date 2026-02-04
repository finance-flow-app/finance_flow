import 'package:easy_localization/easy_localization.dart';
import 'package:finance_flow/core/assets/app_fonts.dart';
import 'package:finance_flow/core/generated/localization/locale_keys.g.dart';
import 'package:finance_flow/src/features/expense_add/presentation/Bloc/expense_add_bloc.dart';
import 'package:flutter/material.dart';

class SwitchLimitButtonWidget extends StatelessWidget {
  const SwitchLimitButtonWidget({
    super.key,
    required this.selectedPeriod,
    required this.onPeriodChanged,
  });

  final LimitPeriod selectedPeriod;
  final ValueChanged<LimitPeriod> onPeriodChanged;

  static const List<LimitPeriod> _periods = LimitPeriod.values;

  String _getPeriodLabel(LimitPeriod period) {
    return switch (period) {
      LimitPeriod.day => LocaleKeys.limit_period_day.tr(),
      LimitPeriod.week => LocaleKeys.limit_period_week.tr(),
      LimitPeriod.month => LocaleKeys.limit_period_month.tr(),
    };
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 40,
      child: Row(
        children: _periods.map((period) {
          final isSelected = period == selectedPeriod;
          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                right: period != LimitPeriod.month ? 8 : 0,
              ),
              child: Container(
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
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    onTap: () => onPeriodChanged(period),
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      child: Center(
                        child: Text(
                          _getPeriodLabel(period),
                          style: AppFonts.b4s14regular.copyWith(
                            color: isSelected
                                ? colorScheme.onPrimary
                                : colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
