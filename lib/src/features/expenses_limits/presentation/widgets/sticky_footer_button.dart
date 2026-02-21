import 'package:easy_localization/easy_localization.dart';
import 'package:finance_flow/core/assets/app_fonts.dart';
import 'package:finance_flow/core/generated/assets/assets.gen.dart';
import 'package:finance_flow/core/generated/localization/locale_keys.g.dart';
import 'package:finance_flow/core/shared/custom_widget_container.dart';
import 'package:flutter/material.dart';

const double _kButtonRadius = 16;
const double _kHorizontalPadding = 16;
const double _kVerticalPadding = 8;
const double _kGap = 6;

const double _kButtonPaddingVertical = 10;
const double _kIconSize = 18;

const BorderRadius _kFooterBorderRadius = BorderRadius.all(Radius.circular(20));

/// Футер внизу экрана с кнопками «Отмена» и «Применить» в стиле liquidGlass.
/// Кнопки активны только при [hasChanges] (есть несохранённые изменения).
class StickyFooterButtonWidget extends StatelessWidget {
  const StickyFooterButtonWidget({
    super.key,
    required this.onCancel,
    required this.onApply,
    required this.hasChanges,
  });

  final VoidCallback onCancel;
  final VoidCallback onApply;

  /// Есть несохранённые изменения — кнопки можно нажимать.
  final bool hasChanges;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        _kHorizontalPadding,
        0,
        _kHorizontalPadding,
        _kVerticalPadding + bottomInset,
      ),
      child: CustomWidgetContainer(
        borderRadius: _kFooterBorderRadius,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        child: Row(
          children: [
            Expanded(
              child: _SecondaryButton(
                label: LocaleKeys.expenses_limits_cancel.tr(),
                colorScheme: colorScheme,
                onPressed: hasChanges ? onCancel : null,
              ),
            ),
            const SizedBox(width: _kGap),
            Expanded(
              child: _PrimaryGradientButton(
                label: LocaleKeys.expenses_limits_apply.tr(),
                colorScheme: colorScheme,
                onPressed: hasChanges ? onApply : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Градиент как у выбранного сегмента в [PeriodSegmentSwitcher].
List<Color> _segmentStyleGradientColors(ColorScheme colorScheme) {
  return [
    Color.lerp(colorScheme.primary, colorScheme.primaryContainer, 0.4)!,
    colorScheme.primary,
    Color.lerp(colorScheme.primary, colorScheme.primaryContainer, 0.4)!,
  ];
}

class _SecondaryButton extends StatelessWidget {
  const _SecondaryButton({
    required this.label,
    required this.colorScheme,
    this.onPressed,
  });

  final String label;
  final ColorScheme colorScheme;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(_kButtonRadius),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: _kButtonPaddingVertical + 4,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_kButtonRadius),
            gradient: enabled
                ? LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color.lerp(
                        colorScheme.primaryContainer,
                        colorScheme.surface,
                        0.5,
                      )!,
                      colorScheme.primaryContainer,
                      Color.lerp(
                        colorScheme.primaryContainer,
                        colorScheme.surface,
                        0.5,
                      )!,
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  )
                : null,
            color: enabled
                ? null
                : colorScheme.surfaceContainerHigh.withValues(alpha: 0.35),
          ),
          child: Center(
            child: Text(
              label,
              style: AppFonts.b5s18medium.copyWith(
                color: enabled
                    ? colorScheme.onPrimaryContainer
                    : colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PrimaryGradientButton extends StatelessWidget {
  const _PrimaryGradientButton({
    required this.label,
    required this.colorScheme,
    this.onPressed,
  });

  final String label;
  final ColorScheme colorScheme;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;
    final onPrimary = colorScheme.onPrimary;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(_kButtonRadius),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: _kButtonPaddingVertical + 4,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_kButtonRadius),
            gradient: enabled
                ? LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: _segmentStyleGradientColors(colorScheme),
                    stops: const [0.0, 0.5, 1.0],
                  )
                : null,
            color: enabled
                ? null
                : colorScheme.surfaceContainerHigh.withValues(alpha: 0.35),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: AppFonts.b5s18medium.copyWith(
                  color: enabled
                      ? onPrimary
                      : colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                ),
              ),
              const SizedBox(width: 6),
              Assets.icons.arrowUpRight.svg(
                width: _kIconSize,
                height: _kIconSize,
                colorFilter: ColorFilter.mode(
                  enabled
                      ? onPrimary
                      : colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
