import 'package:finance_flow/core/assets/app_fonts.dart';
import 'package:finance_flow/core/shared/app_custom_appbar.dart';
import 'package:finance_flow/src/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:finance_flow/src/features/theme/presentation/widgets/theme_switch_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemePage extends StatelessWidget {
  const ThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppCustomAppBar(
        title: Text('Theme', style: AppFonts.b5s26medium),
      ),
      body: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: ThemeSwitchWidget(
              selectedThemeMode: state.themeMode,
              onThemeModeChanged: (mode) {
                // Откладываем смену темы на следующий кадр, чтобы не вызывать
                // setState/markNeedsBuild у Router во время build (см. GoRouter).
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (context.mounted) {
                    context.read<ThemeBloc>().add(ThemeChanged(mode));
                  }
                });
              },
            ),
          );
        },
      ),
    );
  }
}
