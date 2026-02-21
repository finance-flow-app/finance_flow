import 'package:easy_localization/easy_localization.dart';
import 'package:finance_flow/core/assets/app_fonts.dart';
import 'package:finance_flow/core/generated/assets/assets.gen.dart';
import 'package:finance_flow/core/generated/localization/locale_keys.g.dart';
import 'package:finance_flow/core/shared/custom_widget_container.dart';
import 'package:finance_flow/src/features/expenses_limits/domain/default_limits.dart';
import 'package:finance_flow/src/features/expenses_limits/presentation/widgets/total_limit_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Максимум слайдера по локали: RUB до 100 000, USD до 1 000.
double _sliderMaxForLocale(BuildContext context) {
  return context.locale.languageCode == 'ru' ? 100000.0 : 1000.0;
}

/// Верхняя граница для поля ввода (можно вводить свыше лимита слайдера, напр. 9999 USD).
const double _kInputMaxAmount = 999999999.99;

/// Цвета градиента активного трека слайдера (как в [CategoryProgressBar]).
const Color _kSliderGradientStart = Color(0xFF00D4FF);

/// Слайдер, который меняет значение только при перетаскивании ползунка;
/// нажатие по треку не двигает ползунок.
class _DragOnlySlider extends StatefulWidget {
  const _DragOnlySlider({
    required this.value,
    required this.max,
    required this.primaryColor,
    required this.inactiveTrackColor,
    required this.onChanged,
  });

  final double value;
  final double max;
  final Color primaryColor;
  final Color inactiveTrackColor;
  final ValueChanged<double> onChanged;

  @override
  State<_DragOnlySlider> createState() => _DragOnlySliderState();
}

class _DragOnlySliderState extends State<_DragOnlySlider> {
  static const double _trackHeight = 8;
  static const double _thumbRadius = 8;

  /// Зона нажатия вокруг ползунка — только с неё начинается перетаскивание.
  static const double _thumbHitSlop = 20;

  bool _isDragging = false;

  double _valueToPosition(double value, double width) {
    if (widget.max <= 0 || width <= 0) return 0;
    return (value.clamp(0.0, widget.max) / widget.max) * width;
  }

  double _positionToValue(double dx, double width) {
    if (width <= 0) return 0;
    return (dx / width).clamp(0.0, 1.0) * widget.max;
  }

  bool _isWithinThumb(Offset localPosition, double width) {
    final centerX = _valueToPosition(widget.value, width);
    final thumbCenter = Offset(centerX, _trackHeight / 2);
    return (localPosition - thumbCenter).distance <=
        _thumbRadius + _thumbHitSlop;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final thumbCenterX = _valueToPosition(widget.value, width);

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onHorizontalDragStart: (details) {
            if (_isWithinThumb(details.localPosition, width)) {
              setState(() => _isDragging = true);
            }
          },
          onHorizontalDragUpdate: (details) {
            if (!_isDragging) return;
            final box = context.findRenderObject() as RenderBox?;
            if (box == null) return;
            final local = box.globalToLocal(details.globalPosition);
            final newValue = _positionToValue(local.dx, width);
            widget.onChanged(newValue);
          },
          onHorizontalDragEnd: (_) {
            if (_isDragging) setState(() => _isDragging = false);
          },
          onHorizontalDragCancel: () {
            if (_isDragging) setState(() => _isDragging = false);
          },
          child: SizedBox(
            height: 24,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                SizedBox(
                  height: _trackHeight,
                  width: width,
                  child: CustomPaint(
                    painter: _DragOnlySliderTrackPainter(
                      value: widget.value,
                      max: widget.max,
                      primaryColor: widget.primaryColor,
                      inactiveColor: widget.inactiveTrackColor,
                    ),
                  ),
                ),
                Positioned(
                  left: thumbCenterX - _thumbRadius,
                  child: Container(
                    width: _thumbRadius * 2,
                    height: _thumbRadius * 2,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.primaryColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _DragOnlySliderTrackPainter extends CustomPainter {
  _DragOnlySliderTrackPainter({
    required this.value,
    required this.max,
    required this.primaryColor,
    required this.inactiveColor,
  });

  final double value;
  final double max;
  final Color primaryColor;
  final Color inactiveColor;

  static const double _trackHeight = 8;

  @override
  void paint(Canvas canvas, Size size) {
    final trackRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, _trackHeight),
      const Radius.circular(_trackHeight / 2),
    );
    canvas.drawRRect(trackRect, Paint()..color = inactiveColor);
    if (max > 0) {
      final t = (value.clamp(0.0, max) / max).clamp(0.0, 1.0);
      final activeWidth = size.width * t;
      if (activeWidth > 0) {
        final activeRect = Rect.fromLTWH(0, 0, activeWidth, _trackHeight);
        final activeRRect = RRect.fromRectAndRadius(
          activeRect,
          const Radius.circular(_trackHeight / 2),
        );
        final gradient = LinearGradient(
          colors: [_kSliderGradientStart, primaryColor],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        );
        canvas.drawRRect(
          activeRRect,
          Paint()..shader = gradient.createShader(activeRect),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DragOnlySliderTrackPainter old) {
    return old.value != value ||
        old.max != max ||
        old.primaryColor != primaryColor ||
        old.inactiveColor != inactiveColor;
  }
}

/// Категории для лимитов по категориям (внутри виджета списка).
enum CategoryForLimit {
  food,
  restaurant,
  taxi,
  transport,
  shopping,
  bills,
  education,
  health,
  entertainment,
  internet,
  other,
}

extension CategoryForLimitExtension on CategoryForLimit {
  Widget icon({double size = 20, Color? color}) {
    final svgIcon = switch (this) {
      CategoryForLimit.food => Assets.icons.apple,
      CategoryForLimit.restaurant => Assets.icons.restaurant,
      CategoryForLimit.taxi => Assets.icons.taxi,
      CategoryForLimit.transport => Assets.icons.train,
      CategoryForLimit.shopping => Assets.icons.shoppingCart,
      CategoryForLimit.bills => Assets.icons.catalog,
      CategoryForLimit.education => Assets.icons.education,
      CategoryForLimit.health => Assets.icons.healthCross,
      CategoryForLimit.entertainment => Assets.icons.faceSatisfied,
      CategoryForLimit.internet => Assets.icons.wifi,
      CategoryForLimit.other => Assets.icons.filter,
    };
    return svgIcon.svg(
      width: size,
      height: size,
      colorFilter: color != null
          ? ColorFilter.mode(color, BlendMode.srcIn)
          : null,
    );
  }

  String get localeKey => switch (this) {
    CategoryForLimit.food => LocaleKeys.categories_food,
    CategoryForLimit.restaurant => LocaleKeys.categories_restaurants,
    CategoryForLimit.taxi => LocaleKeys.categories_taxi,
    CategoryForLimit.transport => LocaleKeys.categories_transport,
    CategoryForLimit.shopping => LocaleKeys.categories_shopping,
    CategoryForLimit.bills => LocaleKeys.categories_bills,
    CategoryForLimit.education => LocaleKeys.categories_education,
    CategoryForLimit.health => LocaleKeys.categories_health,
    CategoryForLimit.entertainment => LocaleKeys.categories_entertainment,
    CategoryForLimit.internet => LocaleKeys.categories_internet,
    CategoryForLimit.other => LocaleKeys.categories_other_category,
  };
}

/// Дефолтные лимиты по категориям в зависимости от локали (из domain).
Map<CategoryForLimit, double> defaultCategoryLimitsFor(String languageCode) {
  final m = defaultCategoryLimitsMap(languageCode);
  return {
    for (final e in CategoryForLimit.values)
      if (m[e.name] != null) e: m[e.name]!,
  };
}

/// Список лимитов по категориям: иконка, название, поле суммы, слайдер.
/// Лимиты в [categoryLimits] хранятся «за день»; для отображения умножаются на
/// [selectedPeriod].periodFactor (неделя ×7, месяц ×30).
class CategoryLimitListWidget extends StatelessWidget {
  const CategoryLimitListWidget({
    super.key,
    required this.categoryLimits,
    required this.selectedPeriod,
    required this.onCategoryLimitChanged,
  });

  /// Лимит по каждой категории (за день).
  final Map<CategoryForLimit, double> categoryLimits;

  /// Выбранный период: отображаемые значения и макс. слайдера умножаются на periodFactor.
  final TotalLimitPeriod selectedPeriod;

  final void Function(CategoryForLimit category, double value)
  onCategoryLimitChanged;

  static const List<CategoryForLimit> _categories = CategoryForLimit.values;

  String _currency(BuildContext context) {
    return context.locale.languageCode == 'ru' ? 'RUB' : 'USD';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final currency = _currency(context);
    final periodFactor = selectedPeriod.periodFactor.toDouble();
    final sliderMaxPerDay = _sliderMaxForLocale(context);
    final sliderMaxLimit = sliderMaxPerDay * periodFactor;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 8),
              child: Text(
                LocaleKeys.expenses_limits_limits_by_categories.tr(),
                style: AppFonts.b6s22semiBold.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            // Column вместо ListView.separated(shrinkWrap), чтобы не было лишнего
            // вертикального зазора под списком (shrinkWrap в Column давал артефакт).
            ..._categories.expand((category) {
              final perDay = categoryLimits[category] ?? 0.0;
              final value = perDay * periodFactor;
              final card = CustomWidgetContainer(
                key: ValueKey(category),
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: _CategoryLimitRow(
                    category: category,
                    value: value,
                    sliderMaxLimit: sliderMaxLimit,
                    inputMaxLimit: _kInputMaxAmount,
                    currency: currency,
                    onChanged: (v) =>
                        onCategoryLimitChanged(category, v / periodFactor),
                    colorScheme: colorScheme,
                  ),
                ),
              );
              final isFirst = category == _categories.first;
              return [if (!isFirst) const SizedBox(height: 8), card];
            }),
          ],
        ),
      ),
    );
  }
}

double? _parseAmount(String text) {
  final cleaned = text.replaceAll(RegExp(r'[^\d.,]'), '').replaceAll(',', '.');
  if (cleaned.isEmpty) return 0;
  return double.tryParse(cleaned);
}

/// Максимум цифр в целой части (до запятой).
const int _kMaxIntegerDigits = 5;

/// Форматтер: после единственной "0" второй "0" вставляет запятую (0,0),
/// после запятой не более 2 знаков; целая часть — не более [_kMaxIntegerDigits] цифр.
class _LimitAmountInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text;

    // Второй "0" после единственной "0" → "0," (запятая)
    if (oldValue.text == '0' && text == '00') {
      return TextEditingValue(
        text: '0,',
        selection: const TextSelection.collapsed(offset: 2),
      );
    }

    final buffer = StringBuffer();
    bool hasDecimal = false;
    int decimalDigits = 0;
    int integerDigits = 0;

    for (int i = 0; i < text.length; i++) {
      final c = text[i];
      if (c == ',' || c == '.') {
        if (!hasDecimal) {
          hasDecimal = true;
          buffer.write(',');
        }
      } else if (RegExp(r'\d').hasMatch(c)) {
        if (hasDecimal) {
          if (decimalDigits < 2) {
            buffer.write(c);
            decimalDigits++;
          }
        } else {
          if (integerDigits < _kMaxIntegerDigits) {
            buffer.write(c);
            integerDigits++;
          }
        }
      }
    }

    final result = buffer.toString();
    if (result != text) {
      return TextEditingValue(
        text: result,
        selection: TextSelection.collapsed(offset: result.length),
      );
    }

    return newValue;
  }
}

String _formatValue(double value) {
  return value == value.truncateToDouble()
      ? value.toInt().toString()
      : value.toStringAsFixed(2);
}

/// Только поле ввода — StatefulWidget для фокуса и контроллера.
class _CategoryLimitInputField extends StatefulWidget {
  const _CategoryLimitInputField({
    super.key,
    required this.value,
    required this.maxLimit,
    required this.colorScheme,
    required this.onChanged,
  });

  final double value;
  final double maxLimit;
  final ColorScheme colorScheme;
  final ValueChanged<double> onChanged;

  @override
  State<_CategoryLimitInputField> createState() =>
      _CategoryLimitInputFieldState();
}

class _CategoryLimitInputFieldState extends State<_CategoryLimitInputField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _formatValue(widget.value));
    _focusNode = FocusNode();
  }

  @override
  void didUpdateWidget(_CategoryLimitInputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value && !_focusNode.hasFocus) {
      _controller.text = _formatValue(widget.value);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = widget.colorScheme;
    return SizedBox(
      width: 92,
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        style: AppFonts.b5s16medium,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[\d.,]')),
          _LimitAmountInputFormatter(),
        ],
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 8,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: colorScheme.onSurface.withValues(alpha: 0.12),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: colorScheme.onSurface.withValues(alpha: 0.12),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: colorScheme.primary.withValues(alpha: 0.6),
              width: 1.5,
            ),
          ),
        ),
        onChanged: (text) {
          final parsed = _parseAmount(text);
          if (parsed != null) {
            widget.onChanged(parsed.clamp(0.0, widget.maxLimit));
          }
        },
      ),
    );
  }
}

class _CategoryLimitRow extends StatelessWidget {
  const _CategoryLimitRow({
    required this.category,
    required this.value,
    required this.currency,
    required this.sliderMaxLimit,
    required this.inputMaxLimit,
    required this.onChanged,
    required this.colorScheme,
  });

  final CategoryForLimit category;
  final double value;
  final String currency;
  final double sliderMaxLimit;
  final double inputMaxLimit;
  final ValueChanged<double> onChanged;
  final ColorScheme colorScheme;

  void _unfocus(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => _unfocus(context),
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: category.icon(
                    size: 20,
                    color: colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GestureDetector(
                onTap: () => _unfocus(context),
                behavior: HitTestBehavior.opaque,
                child: Text(
                  category.localeKey.tr(),
                  style: AppFonts.b5s20medium.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _CategoryLimitInputField(
                    key: ValueKey(category),
                    value: value,
                    maxLimit: inputMaxLimit,
                    colorScheme: colorScheme,
                    onChanged: onChanged,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    currency,
                    style: AppFonts.b5s16medium.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => _unfocus(context),
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: _DragOnlySlider(
              value: value.clamp(0.0, sliderMaxLimit),
              max: sliderMaxLimit,
              primaryColor: colorScheme.primary,
              inactiveTrackColor: colorScheme.surfaceContainerHighest,
              onChanged: (v) {
                _unfocus(context);
                onChanged(v);
              },
            ),
          ),
        ),
      ],
    );
  }
}
