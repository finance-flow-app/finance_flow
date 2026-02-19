import 'package:easy_localization/easy_localization.dart';
import 'package:finance_flow/core/di/service_locator.dart';
import 'package:finance_flow/core/router/app_router.dart';
import 'package:finance_flow/core/theme/app_backgroud.dart';
import 'package:finance_flow/core/theme/app_theme.dart';
import 'package:finance_flow/src/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FinanceFlowApp extends StatelessWidget {
  const FinanceFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<ThemeBloc>(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        buildWhen: (prev, curr) => prev.themeMode != curr.themeMode,
        builder: (context, state) {
          return MaterialApp.router(
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: state.themeMode,
            builder: (context, child) {
              return AppBackground(child: child ?? const SizedBox.shrink());
            },
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            routerConfig: AppRouter().router,
          );
        },
      ),
    );
  }
}
