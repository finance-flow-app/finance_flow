import 'package:easy_localization/easy_localization.dart';
import 'package:finance_flow/core/assets/app_fonts.dart';
import 'package:finance_flow/core/generated/assets/assets.gen.dart';
import 'package:finance_flow/core/generated/localization/locale_keys.g.dart';
import 'package:finance_flow/core/shared/custom_widget_container.dart';
import 'package:finance_flow/src/features/expense_add/presentation/Bloc/expense_add_bloc.dart';
import 'package:flutter/material.dart';

class SwitchLimitButtonWidget extends StatelessWidget
    implements LiquidGlassBorderRadiusProvider {
  const SwitchLimitButtonWidget({
    super.key,
    required this.selectedPeriod,
    required this.onPeriodChanged,
  });

  final LimitPeriod selectedPeriod;
  final ValueChanged<LimitPeriod> onPeriodChanged;

  /// Радиус контура виджета.
  static const BorderRadius kLiquidGlassBorderRadius = BorderRadius.all(
    Radius.circular(16),
  );

  @override
  BorderRadius get liquidGlassBorderRadius => kLiquidGlassBorderRadius;

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

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: liquidGlassBorderRadius,
        border: Border.all(
          color: colorScheme.onSurface.withValues(alpha: 0.12),
          width: 1,
        ),
      ),
      child: Row(
        children: _periods.map((period) {
          final isSelected = period == selectedPeriod;
          return Expanded(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  if (period == selectedPeriod && period != LimitPeriod.day) {
                    onPeriodChanged(LimitPeriod.day);
                  } else {
                    onPeriodChanged(period);
                  }
                },
                borderRadius: BorderRadius.circular(12),
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
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Assets.icons.calendar.svg(
                        width: 18,
                        height: 18,
                        colorFilter: ColorFilter.mode(
                          isSelected
                              ? colorScheme.onPrimary
                              : colorScheme.onSurfaceVariant,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _getPeriodLabel(period),
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
            ),
          );
        }).toList(),
      ),
    );
  }
}
