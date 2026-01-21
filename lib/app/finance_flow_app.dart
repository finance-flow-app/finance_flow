import 'package:easy_localization/easy_localization.dart';
import 'package:finance_flow/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../src/features/home/presentation/pages/home_page.dart';

class FinanceFlowApp extends StatelessWidget {
  const FinanceFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: const HomePage(),
    );
  }
}
