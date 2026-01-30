import 'package:finance_flow/core/assets/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AmountFormFieldWidget extends StatelessWidget {
  final String initialValue;
  final String hintText;
  final Widget? suffixIcon;
  final Color? iconColor;
  final ValueChanged<double>? onChanged;

  const AmountFormFieldWidget({
    super.key,
    this.initialValue = '',
    required this.hintText,
    this.suffixIcon,
    this.iconColor = Colors.grey,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppFonts.b4s18regular,
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
          onChanged?.call(0.0);
          return;
        }
        if (value.endsWith(',')) return;
        final parsed = double.tryParse(value.replaceAll(',', '.')) ?? 0.0;
        onChanged?.call(parsed);
      },
      decoration: InputDecoration(
        suffixIcon: suffixIcon != null
            ? Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: suffixIcon!,
              )
            : null,
        suffixIconConstraints: const BoxConstraints(
          minWidth: 24,
          minHeight: 24,
        ),
        hintText: hintText,
        hintStyle: AppFonts.b4s18regular.copyWith(color: iconColor),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
        filled: true,
        fillColor: const Color.fromARGB(16, 0, 0, 0),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
