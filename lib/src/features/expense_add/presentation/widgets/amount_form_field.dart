import 'dart:ui' as ui;

import 'package:finance_flow/core/assets/app_fonts.dart';
import 'package:finance_flow/core/shared/custom_widget_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AmountFormFieldWidget extends StatelessWidget
    implements LiquidGlassBorderRadiusProvider {
  final String initialValue;
  final String hintText;
  final String currency;
  final Color? hintColor;
  final ValueChanged<double>? onChanged;

  const AmountFormFieldWidget({
    super.key,
    this.initialValue = '',
    this.hintText = '0,00',
    required this.currency,
    this.hintColor = Colors.grey,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return _AmountFormFieldWithController(
      hintText: hintText,
      currency: currency,
      hintColor: hintColor,
      onChanged: onChanged,
    );
  }

  /// Радиус контура виджета.
  static const BorderRadius kLiquidGlassBorderRadius = BorderRadius.all(
    Radius.circular(20),
  );

  @override
  BorderRadius get liquidGlassBorderRadius => kLiquidGlassBorderRadius;
}

class _AmountFormFieldWithController extends StatefulWidget {
  final String hintText;
  final String currency;
  final Color? hintColor;
  final ValueChanged<double>? onChanged;

  const _AmountFormFieldWithController({
    required this.hintText,
    required this.currency,
    this.hintColor,
    this.onChanged,
  });

  @override
  State<_AmountFormFieldWithController> createState() =>
      _AmountFormFieldWithControllerState();
}

class _AmountFormFieldWithControllerState
    extends State<_AmountFormFieldWithController> {
  late final TextEditingController _controller;

  static const double _contentPaddingLeft = 14;
  static const double _contentPaddingRight = 12;
  static const double _currencyGap = 8;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _measureTextWidth(String text, TextStyle style) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: ui.TextDirection.ltr,
    )..layout();
    return textPainter.width;
  }

  @override
  Widget build(BuildContext context) {
    final displayText = _controller.text.isEmpty
        ? widget.hintText
        : _controller.text;
    final style = AppFonts.b6s26semiBold;
    final textWidth = _measureTextWidth(displayText, style);
    final currencyLeft = _contentPaddingLeft + textWidth + _currencyGap;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        TextFormField(
          controller: _controller,
          textAlign: TextAlign.left,
          style: style,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            LengthLimitingTextInputFormatter(10),
            TextInputFormatter.withFunction((oldValue, newValue) {
              var text = newValue.text;
              if (text.isEmpty) return newValue;
              if (text.length >= 2 &&
                  text.startsWith('0') &&
                  text[1] != ',' &&
                  !oldValue.text.contains(',')) {
                text = '0,${text.substring(1)}';
                return TextEditingValue(
                  text: text,
                  selection: TextSelection.collapsed(offset: text.length),
                );
              }

              final moneyPattern = RegExp(r'^\d*,?\d{0,2}$');
              if (!moneyPattern.hasMatch(text)) return oldValue;
              if (text.length > 1 && text.startsWith('0') && text[1] != ',') {
                return oldValue;
              }
              return newValue;
            }),
          ],
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          onChanged: (value) {
            if (value.isEmpty) {
              widget.onChanged?.call(0.0);
              return;
            }
            if (value.endsWith(',')) return;
            final parsed = double.tryParse(value.replaceAll(',', '.')) ?? 0.0;
            widget.onChanged?.call(parsed);
          },
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: style.copyWith(color: widget.hintColor),
            isDense: true,
            contentPadding: const EdgeInsets.only(
              left: _contentPaddingLeft,
              right: _contentPaddingRight,
              top: 32,
              bottom: 32,
            ),
            filled: true,
            fillColor: Colors.transparent,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.12),
                width: 1,
              ),
              borderRadius: AmountFormFieldWidget.kLiquidGlassBorderRadius,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.12),
                width: 1,
              ),
              borderRadius: AmountFormFieldWidget.kLiquidGlassBorderRadius,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 1.5,
              ),
              borderRadius: AmountFormFieldWidget.kLiquidGlassBorderRadius,
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
              borderRadius: AmountFormFieldWidget.kLiquidGlassBorderRadius,
            ),
          ),
        ),
        Positioned(
          left: currencyLeft,
          top: 0,
          bottom: 0,
          child: IgnorePointer(
            child: Center(
              child: Text(
                widget.currency,
                style: style.copyWith(
                  color: _controller.text.isEmpty
                      ? widget.hintColor
                      : Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
