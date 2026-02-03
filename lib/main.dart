import 'package:easy_localization/easy_localization.dart';
import 'package:finance_flow/core/di/service_locator.dart';
import 'package:finance_flow/core/generated/localization/codegen_loader.g.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/finance_flow_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  await setupServiceLocator(sharedPreferences);
  runApp(
    EasyLocalization(
      startLocale: const Locale('en'),
      supportedLocales: const [Locale('en'), Locale('ru')],
      fallbackLocale: const Locale('en'),
      saveLocale: false,
      assetLoader: CodegenLoader(),
      path: 'assets/translations/',
      child: const FinanceFlowApp(),
    ),
  );
}
