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
    this.colorScheme,
  });

  final LimitPeriod selectedPeriod;
  final ValueChanged<LimitPeriod> onPeriodChanged;
  final ColorScheme? colorScheme;

  static const List<LimitPeriod> _periods = LimitPeriod.values;

  String _getPeriodLabel(LimitPeriod period) {
    return switch (period) {
      LimitPeriod.day => LocaleKeys.limit_period_day.tr(),
      LimitPeriod.week => LocaleKeys.limit_period_week.tr(),
      LimitPeriod.month => LocaleKeys.limit_period_month.tr(),
    };
  }

  List<Widget> _buildChildren() {
    final List<Widget> children = [];

    for (int i = 0; i < _periods.length; i++) {
      final period = _periods[i];
      final isSelected = period == selectedPeriod;
      final isFirst = i == 0;
      final isLast = i == _periods.length - 1;

      children.add(
        GestureDetector(
          onTap: () => onPeriodChanged(period),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: isSelected ? colorScheme?.primary : Colors.transparent,
              borderRadius: BorderRadius.horizontal(
                left: isFirst ? const Radius.circular(14) : Radius.zero,
                right: isLast ? const Radius.circular(14) : Radius.zero,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              _getPeriodLabel(period),
              style: AppFonts.b4s12regular.copyWith(
                color: isSelected
                    ? colorScheme?.onPrimary
                    : colorScheme?.onSurface,
              ),
            ),
          ),
        ),
      );

      if (!isLast) {
        children.add(
          Container(
            width: 1,
            height: 28,
            color: colorScheme?.outline.withValues(alpha: 0.3),
          ),
        );
      }
    }

    return children;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      decoration: BoxDecoration(
        color: colorScheme?.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color:
              colorScheme?.outline.withValues(alpha: 0.3) ?? Colors.transparent,
        ),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: _buildChildren()),
    );
  }
}
