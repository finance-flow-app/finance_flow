import 'package:finance_flow/core/assets/app_fonts.dart';
import 'package:flutter/material.dart';

enum AlertType { success, error, info }

class AlertServices {
  static void show(
    BuildContext context, {
    required String title,
    required AlertType type,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    final (backgroundColor, textColor) = switch (type) {
      AlertType.success => (colorScheme.primary, colorScheme.onPrimary),
      AlertType.error => (colorScheme.error, colorScheme.onError),
      AlertType.info => (colorScheme.secondary, colorScheme.onSecondary),
    };

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        content: Center(
          child: Text(
            title,
            style: AppFonts.b4s18regular.copyWith(color: textColor),
          ),
        ),
      ),
    );
  }
}
