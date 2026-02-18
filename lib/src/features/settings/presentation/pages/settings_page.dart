import 'package:finance_flow/core/assets/app_fonts.dart';
import 'package:finance_flow/core/shared/app_custom_appbar.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppCustomAppBar(
        title: Text('Settings', style: AppFonts.b5s26medium),
        automaticallyImplyLeading: false,
      ),
      body: Center(child: Text('Settings', style: AppFonts.b5s20medium)),
    );
  }
}
