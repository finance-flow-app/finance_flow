import 'package:easy_localization/easy_localization.dart';
import 'package:finance_flow/core/assets/app_fonts.dart';
import 'package:finance_flow/core/generated/localization/locale_keys.g.dart';
import 'package:finance_flow/src/features/expense_add/presentation/Bloc/expense_add_bloc.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class CurrentLimitFieldWidget extends StatelessWidget {
  const CurrentLimitFieldWidget({
    super.key,
    required this.amount,
    required this.limitPeriod,
  });

  final double amount;
  final LimitPeriod limitPeriod;

  static const Map<LimitPeriod, int> _limits = {
    LimitPeriod.day: 5000,
    LimitPeriod.week: 35000,
    LimitPeriod.month: 150000,
  };

  String _formatAmount(BuildContext context, double value) {
    final intPart = value.truncate().abs();
    final frac = ((value - value.truncate()) * 100).round().clamp(0, 99);
    final intStr = intPart.toString();
    final buffer = StringBuffer();
    for (var i = 0; i < intStr.length; i++) {
      if (i > 0 && (intStr.length - i) % 3 == 0) buffer.write(' ');
      buffer.write(intStr[i]);
    }
    final fracStr = frac.toString().padLeft(2, '0');
    return '$buffer,$fracStr';
  }

  String _currency(BuildContext context) {
    return context.locale.languageCode == 'ru' ? 'RUB' : 'USD';
  }

  String _limitForPeriodSubtitle(BuildContext context) {
    return switch (limitPeriod) {
      LimitPeriod.day => LocaleKeys.limit_for_period_day.tr(),
      LimitPeriod.week => LocaleKeys.limit_for_period_week.tr(),
      LimitPeriod.month => LocaleKeys.limit_for_period_month.tr(),
    };
  }

  String _getExceededMessage() {
    return switch (limitPeriod) {
      LimitPeriod.day => LocaleKeys.limit_exceeded_day.tr(),
      LimitPeriod.week => LocaleKeys.limit_exceeded_week.tr(),
      LimitPeriod.month => LocaleKeys.limit_exceeded_month.tr(),
    };
  }

  double _measureAmountTextWidth(
    BuildContext context,
    double amount,
    int limit,
  ) {
    final text =
        '${_formatAmount(context, amount)}/${_formatAmount(context, limit.toDouble())} ${_currency(context)}';
    final style = AppFonts.b6s30semiBold;
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: ui.TextDirection.ltr,
    )..layout();
    return textPainter.width;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final limit = _limits[limitPeriod] ?? 0;
    final isExceeded = amount > limit;

    return SizedBox(
      width: double.infinity,
      child: Card(
        margin: EdgeInsets.zero,
        color: colorScheme.surfaceContainerHighest,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: colorScheme.outline.withValues(alpha: 0.3)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                LocaleKeys.current_limit.tr(),
                style: AppFonts.b5s20medium.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 20),
              LayoutBuilder(
                builder: (context, constraints) {
                  final textWidth = _measureAmountTextWidth(
                    context,
                    amount,
                    limit,
                  );
                  final barWidth = textWidth.clamp(0.0, constraints.maxWidth);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${_formatAmount(context, amount)}/${_formatAmount(context, limit.toDouble())} ${_currency(context)}',
                        style: AppFonts.b6s30semiBold.copyWith(
                          color: isExceeded
                              ? colorScheme.error
                              : colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: barWidth,
                        child: _LimitProgressBar(
                          progress: limit > 0 ? amount / limit : 0,
                          isOverLimit: isExceeded,
                          height: 6,
                        ),
                      ),
                    ],
                  );
                },
              ),
              if (isExceeded) ...[
                const SizedBox(height: 8),
                Text(
                  _getExceededMessage(),
                  style: AppFonts.b4s14regular.copyWith(
                    color: colorScheme.error,
                  ),
                ),
              ],
              const SizedBox(height: 8),
              Text(
                _limitForPeriodSubtitle(context),
                style: AppFonts.b4s14regular.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LimitProgressBar extends StatelessWidget {
  const _LimitProgressBar({
    required this.progress,
    required this.isOverLimit,
    this.height = 6,
  });

  final double progress;
  final bool isOverLimit;
  final double height;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final clampedProgress = progress.clamp(0.0, 1.0);

    final gradientColors = isOverLimit
        ? [colorScheme.error.withValues(alpha: 0.7), colorScheme.error]
        : [const Color(0xFF00D4FF), colorScheme.primary];

    return Container(
      height: height,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(height / 2),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: constraints.maxWidth * clampedProgress,
                height: height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: gradientColors,
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(height / 2),
                  boxShadow: [
                    BoxShadow(
                      color: gradientColors.last.withValues(alpha: 0.4),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
