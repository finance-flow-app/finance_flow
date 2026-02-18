import 'package:finance_flow/core/assets/app_fonts.dart';
import 'package:finance_flow/core/shared/app_custom_appbar.dart';
import 'package:flutter/material.dart';

class MockPage extends StatelessWidget {
  const MockPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppCustomAppBar(
        title: Text('Mock Analytics', style: AppFonts.b5s26medium),
      ),
      body: Center(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text('Mock Analytics', style: AppFonts.b5s20medium)],
          ),
        ),
      ),
    );
  }
}
