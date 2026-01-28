import 'package:easy_localization/easy_localization.dart';
import 'package:finance_flow/core/assets/app_fonts.dart';
import 'package:finance_flow/core/generated/localization/locale_keys.g.dart';
import 'package:finance_flow/src/features/expense_add/presentation/Bloc/expense_add_bloc.dart';
import 'package:flutter/material.dart';

class CurrentLimitFieldWidget extends StatelessWidget {
  const CurrentLimitFieldWidget({
    super.key,
    this.style,
    required this.amount,
    required this.limitPeriod,
  });

  final TextStyle? style;
  final double amount;
  final LimitPeriod limitPeriod;

  static const Map<LimitPeriod, int> _limits = {
    LimitPeriod.day: 5000,
    LimitPeriod.week: 35000,
    LimitPeriod.month: 150000,
  };

  String _formatAmount(double value) {
    if (value == value.truncateToDouble()) {
      return value.toInt().toString();
    }
    return value.toStringAsFixed(2).replaceAll('.', ',');
  }

  String _getExceededMessage() {
    return switch (limitPeriod) {
      LimitPeriod.day => LocaleKeys.limit_exceeded_day.tr(),
      LimitPeriod.week => LocaleKeys.limit_exceeded_week.tr(),
      LimitPeriod.month => LocaleKeys.limit_exceeded_month.tr(),
    };
  }

  @override
  Widget build(BuildContext context) {
    final limit = _limits[limitPeriod] ?? 0;
    final isExceeded = amount > limit;
    final errorColor = Theme.of(context).colorScheme.error;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '${_formatAmount(amount)}/$limit',
          style:
              style?.copyWith(color: isExceeded ? errorColor : null) ??
              AppFonts.b4s20regular.copyWith(
                color: isExceeded ? errorColor : null,
              ),
        ),
        if (isExceeded) ...[
          const SizedBox(height: 8),
          Text(
            _getExceededMessage(),
            style: AppFonts.b4s14regular.copyWith(color: errorColor),
          ),
        ],
      ],
    );
  }
}
