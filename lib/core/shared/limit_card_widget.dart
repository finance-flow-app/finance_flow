import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:finance_flow/core/assets/app_fonts.dart';
import 'package:finance_flow/core/shared/custom_widget_container.dart';
import 'package:flutter/material.dart';

/// Общая карточка лимита: поддерживает два режима.
///
/// - **Текущий лимит** ([limit] задан): заголовок, «сумма/лимит», прогресс-бар
///   по соотношению сумма/лимит, при превышении — [exceededMessage], подпись [subtitle].
/// - **Общий лимит** ([limit] == null): заголовок, только «сумма», полоска
///   градиента на всю ширину текста суммы, подпись [subtitle].
///
/// [decorativeBackground]: при true рисуются декоративные полосы/орбы (как в
/// экране добавления расхода); при false — только рамка и контент.
class LimitCardWidget extends StatelessWidget
    implements LiquidGlassBorderRadiusProvider {
  const LimitCardWidget({
    super.key,
    required this.title,
    required this.amount,
    required this.subtitle,
    this.limit,
    this.exceededMessage,
    this.decorativeBackground = true,
  });

  final String title;
  final double amount;
  final String subtitle;

  /// Если задан — режим «текущий лимит» (сумма/лимит + прогресс-бар).
  /// Если null — режим «общий лимит» (только сумма + полная полоска).
  final double? limit;

  /// Сообщение при превышении лимита (используется только при [limit] != null и amount > limit).
  final String? exceededMessage;

  /// Рисовать ли декоративный фон (полосы, орбы, блик).
  final bool decorativeBackground;

  static const BorderRadius kLiquidGlassBorderRadius = BorderRadius.all(
    Radius.circular(20),
  );

  @override
  BorderRadius get liquidGlassBorderRadius => kLiquidGlassBorderRadius;

  static String formatAmount(BuildContext context, double value) {
    final locale = context.locale.languageCode;
    final isRu = locale == 'ru';
    final intPart = value.truncate().abs();
    final frac = ((value - value.truncate()) * 100).round().clamp(0, 99);
    final str = intPart.toString();
    final sep = isRu ? ' ' : ',';
    final buffer = StringBuffer();
    for (var i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) buffer.write(sep);
      buffer.write(str[i]);
    }
    final fracStr = frac.toString().padLeft(2, '0');
    buffer.write(isRu ? ',' : '.');
    buffer.write(fracStr);
    return buffer.toString();
  }

  static String currency(BuildContext context) {
    return context.locale.languageCode == 'ru' ? 'RUB' : 'USD';
  }

  bool get _isCurrentLimitMode => limit != null;

  double _measureTextWidth(BuildContext context, String text) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: AppFonts.b6s30semiBold),
      textDirection: ui.TextDirection.ltr,
    )..layout();
    return textPainter.width;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final limitValue = limit;
    final isExceeded = limitValue != null && amount > limitValue;
    final isDark = colorScheme.brightness == Brightness.dark;

    final String mainText;
    if (limitValue != null) {
      mainText =
          '${formatAmount(context, amount)}/${formatAmount(context, limitValue)} ${currency(context)}';
    } else {
      mainText = '${formatAmount(context, amount)} ${currency(context)}';
    }

    final content = Padding(
      padding: const EdgeInsets.all(20),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final textWidth = _measureTextWidth(
            context,
            mainText,
          ).clamp(0.0, constraints.maxWidth);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: AppFonts.b5s20medium.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: constraints.maxWidth,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    mainText,
                    style: AppFonts.b6s30semiBold.copyWith(
                      color: isExceeded
                          ? colorScheme.error
                          : colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: textWidth,
                child:
                    _isCurrentLimitMode && limitValue != null && limitValue > 0
                    ? _LimitProgressBar(
                        progress: amount / limitValue,
                        isOverLimit: isExceeded,
                        height: 15,
                      )
                    : _FullGradientBar(height: 15),
              ),
              if (isExceeded && (exceededMessage ?? '').isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  exceededMessage!,
                  style: AppFonts.b4s16regular.copyWith(
                    color: colorScheme.error,
                  ),
                ),
              ],
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: AppFonts.b4s16regular.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          );
        },
      ),
    );

    final inner = Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: kLiquidGlassBorderRadius,
        color: Colors.transparent,
        border: Border.all(
          color: colorScheme.onSurface.withValues(alpha: 0.12),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(19),
        child: decorativeBackground
            ? _DecoratedStack(isDark: isDark, child: content)
            : content,
      ),
    );

    return SizedBox(width: double.infinity, child: inner);
  }
}

class _DecoratedStack extends StatelessWidget {
  const _DecoratedStack({required this.isDark, required this.child});

  final bool isDark;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Stack(
      children: [
        Positioned(
          top: -60,
          right: -80,
          child: Transform.rotate(
            angle: 0.6,
            child: Container(
              width: 180,
              height: 120,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    colorScheme.primary.withValues(alpha: 0.2),
                    colorScheme.primary.withValues(alpha: 0.08),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -40,
          left: -60,
          child: Transform.rotate(
            angle: -0.5,
            child: Container(
              width: 140,
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    colorScheme.tertiary.withValues(alpha: 0.18),
                    colorScheme.tertiary.withValues(alpha: 0.06),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: -50,
          right: -50,
          child: Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  colorScheme.primary.withValues(alpha: 0.22),
                  colorScheme.primary.withValues(alpha: 0.1),
                  colorScheme.primary.withValues(alpha: 0.03),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.35, 0.65, 1.0],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -30,
          left: -30,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  colorScheme.tertiary.withValues(alpha: 0.18),
                  colorScheme.tertiary.withValues(alpha: 0.06),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(19),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.white.withValues(alpha: isDark ? 0.06 : 0.12),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.5],
              ),
            ),
          ),
        ),
        child,
      ],
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

class _FullGradientBar extends StatelessWidget {
  const _FullGradientBar({this.height = 15});

  final double height;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(height / 2),
        gradient: LinearGradient(
          colors: [const Color(0xFF00D4FF), colorScheme.primary],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: 0.4),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
    );
  }
}
