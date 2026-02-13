import 'package:finance_flow/core/assets/app_fonts.dart';
import 'package:flutter/material.dart';

class DescriptionFormFieldWidget extends StatelessWidget {
  static const _maxLength = 240;

  final String hintText;
  final Color? color;
  final ValueChanged<String>? onChanged;

  const DescriptionFormFieldWidget({
    super.key,
    required this.hintText,
    this.color = Colors.grey,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppFonts.b5s20medium,
      maxLength: _maxLength,
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppFonts.b5s20medium.copyWith(color: color),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 24,
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surfaceContainerHigh,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
