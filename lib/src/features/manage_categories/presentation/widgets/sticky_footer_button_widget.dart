import 'package:easy_localization/easy_localization.dart';
import 'package:finance_flow/core/assets/app_fonts.dart';
import 'package:finance_flow/core/generated/assets/assets.gen.dart';
import 'package:finance_flow/core/generated/localization/locale_keys.g.dart';
import 'package:flutter/material.dart';

const double _kButtonRadius = 20;
const double _kHorizontalPadding = 16;
const double _kVerticalPaddingTop = 20;
const double _kVerticalPaddingBottom = -24;
const double _kGap = 12;

const double _kButtonPaddingVertical = 12;
const double _kButtonPaddingHorizontal = 16;
const double _kIconSize = 18;

/// Липкий футер с кнопками «Отмена» и «Сохранить» для экрана управления категориями.
class StickyFooterButtonWidget extends StatelessWidget {
  const StickyFooterButtonWidget({
    super.key,
    required this.onCancel,
    required this.onSaveChanges,
  });

  final VoidCallback onCancel;
  final VoidCallback onSaveChanges;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bottomPadding = MediaQuery.paddingOf(context).bottom;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        _kHorizontalPadding,
        _kVerticalPaddingTop,
        _kHorizontalPadding,
        _kVerticalPaddingBottom + bottomPadding,
      ),
      decoration: BoxDecoration(color: colorScheme.surface),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: _SecondaryButton(
                label: LocaleKeys.manage_categories_footer_cancel.tr(),
                colorScheme: colorScheme,
                onPressed: onCancel,
              ),
            ),
            const SizedBox(width: _kGap),
            Expanded(
              child: _PrimaryButton(
                label: LocaleKeys.manage_categories_footer_save_changes.tr(),
                colorScheme: colorScheme,
                onPressed: onSaveChanges,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SecondaryButton extends StatelessWidget {
  const _SecondaryButton({
    required this.label,
    required this.colorScheme,
    required this.onPressed,
  });

  final String label;
  final ColorScheme colorScheme;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: colorScheme.onPrimaryContainer,
        padding: const EdgeInsets.symmetric(
          vertical: _kButtonPaddingVertical,
          horizontal: _kButtonPaddingHorizontal,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_kButtonRadius),
        ),
        textStyle: AppFonts.b5s16medium,
      ),
      child: Text(label),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({
    required this.label,
    required this.colorScheme,
    required this.onPressed,
  });

  final String label;
  final ColorScheme colorScheme;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        padding: const EdgeInsets.symmetric(
          vertical: _kButtonPaddingVertical,
          horizontal: _kButtonPaddingHorizontal,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_kButtonRadius),
        ),
        textStyle: AppFonts.b5s16medium,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label),
          const SizedBox(width: 6),
          Assets.icons.arrowUpRight.svg(
            width: _kIconSize,
            height: _kIconSize,
            colorFilter: ColorFilter.mode(
              colorScheme.onPrimary,
              BlendMode.srcIn,
            ),
          ),
        ],
      ),
    );
  }
}
