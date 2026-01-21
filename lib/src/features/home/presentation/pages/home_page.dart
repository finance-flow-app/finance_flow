import 'package:easy_localization/easy_localization.dart';
import 'package:finance_flow/core/assets/app_fonts.dart';
import 'package:finance_flow/core/generated/assets/assets.gen.dart';
import 'package:finance_flow/core/generated/localization/locale_keys.g.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Finance Flow', style: AppFonts.regular),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(LocaleKeys.hello_world.tr(), style: AppFonts.light),
            const SizedBox(height: 20),
            Assets.images.testSvgIcon.svg(width: 220, height: 220),
            const SizedBox(height: 20),
            Assets.images.testSvgIcon2.svg(width: 220, height: 220),
          ],
        ),
      ),
    );
  }
}
