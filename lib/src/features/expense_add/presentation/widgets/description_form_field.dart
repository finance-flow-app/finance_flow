import 'package:finance_flow/core/assets/app_fonts.dart';
import 'package:finance_flow/core/shared/custom_widget_container.dart';
import 'package:flutter/material.dart';

class DescriptionFormFieldWidget extends StatefulWidget
    implements LiquidGlassBorderRadiusProvider {
  const DescriptionFormFieldWidget({
    super.key,
    required this.hintText,
    this.color = Colors.grey,
    this.onChanged,
  });

  final String hintText;
  final Color? color;
  final ValueChanged<String>? onChanged;

  /// Радиус контура виджета.
  static const BorderRadius kLiquidGlassBorderRadius = BorderRadius.all(
    Radius.circular(20),
  );

  @override
  BorderRadius get liquidGlassBorderRadius => kLiquidGlassBorderRadius;

  static const int _maxLength = 240;

  @override
  State<DescriptionFormFieldWidget> createState() =>
      _DescriptionFormFieldWidgetState();
}

class _DescriptionFormFieldWidgetState
    extends State<DescriptionFormFieldWidget> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    widget.onChanged?.call(_controller.text);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomWidgetContainer(
          borderRadius: DescriptionFormFieldWidget.kLiquidGlassBorderRadius,
          child: TextFormField(
            controller: _controller,
            style: AppFonts.b5s20medium,
            maxLength: DescriptionFormFieldWidget._maxLength,
            onTapOutside: (event) =>
                FocusManager.instance.primaryFocus?.unfocus(),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: AppFonts.b5s20medium.copyWith(color: widget.color),
              counterText: '',
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 24,
              ),
              filled: true,
              fillColor: colorScheme.surfaceContainerHigh,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: colorScheme.primary.withValues(alpha: 0.15),
                  width: 1,
                ),
                borderRadius:
                    DescriptionFormFieldWidget.kLiquidGlassBorderRadius,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: colorScheme.onSurface.withValues(alpha: 0.15),
                  width: 1,
                ),
                borderRadius:
                    DescriptionFormFieldWidget.kLiquidGlassBorderRadius,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
                borderRadius:
                    DescriptionFormFieldWidget.kLiquidGlassBorderRadius,
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 1.5),
                borderRadius:
                    DescriptionFormFieldWidget.kLiquidGlassBorderRadius,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              '${_controller.text.length}/${DescriptionFormFieldWidget._maxLength}',
              style: AppFonts.b5s20medium.copyWith(
                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
