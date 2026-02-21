import 'package:finance_flow/core/assets/app_fonts.dart';
import 'package:finance_flow/core/generated/assets/assets.gen.dart';
import 'package:finance_flow/core/shared/custom_widget_container.dart';
import 'package:flutter/material.dart';

/// Общий переключатель периода (день / неделя / месяц) в стиле liquid glass.
/// Используется в add_expense и в expenses_limits.
///
/// [T] — тип варианта (например [LimitPeriod] или [TotalLimitPeriod]).
class PeriodSegmentSwitcher<T> extends StatelessWidget {
  const PeriodSegmentSwitcher({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.labelBuilder,
    required this.onValueChanged,
  });

  final List<T> items;
  final T selectedValue;
  final String Function(T) labelBuilder;
  final ValueChanged<T> onValueChanged;

  static const BorderRadius _borderRadius = BorderRadius.all(
    Radius.circular(16),
  );

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return CustomWidgetContainer(
      borderRadius: _borderRadius,
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          for (final item in items) ...[
            if (item != items.first) const SizedBox(width: 0),
            Expanded(
              child: _Segment<T>(
                item: item,
                isSelected: item == selectedValue,
                label: labelBuilder(item),
                colorScheme: colorScheme,
                onTap: () => onValueChanged(item),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _Segment<T> extends StatelessWidget {
  const _Segment({
    required this.item,
    required this.isSelected,
    required this.label,
    required this.colorScheme,
    required this.onTap,
  });

  final T item;
  final bool isSelected;
  final String label;
  final ColorScheme colorScheme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(_radius),
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
            borderRadius: BorderRadius.circular(_radius),
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
                label,
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
    );
  }

  static const double _radius = 12;
}
