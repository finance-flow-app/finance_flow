import 'package:finance_flow/core/generated/localization/codegen_loader.g.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'app/finance_flow_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      startLocale: Locale('en'),
      supportedLocales: [Locale('en'), Locale('ru')],
      fallbackLocale: Locale('en'),
      saveLocale: false,
      assetLoader: CodegenLoader(),
      path: 'assets/translations/',
      child: FinanceFlowApp(),
    ),
  );
  // runApp(const FinanceFlowApp());
}
