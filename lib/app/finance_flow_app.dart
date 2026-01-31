import 'package:easy_localization/easy_localization.dart';
import 'package:finance_flow/core/router/app_router.dart';
import 'package:finance_flow/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FinanceFlowApp extends StatelessWidget {
  const FinanceFlowApp({super.key, required this.sharedPreferences});

  final SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routerConfig: AppRouter(sharedPreferences: sharedPreferences).router,
    );
  }
}
