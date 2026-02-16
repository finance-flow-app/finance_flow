import 'package:easy_localization/easy_localization.dart';
import 'package:finance_flow/core/assets/app_fonts.dart';
import 'package:finance_flow/core/generated/assets/assets.gen.dart';
import 'package:finance_flow/core/generated/localization/locale_keys.g.dart';
import 'package:finance_flow/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              LocaleKeys.welcome_to_finance_flow.tr(),
              style: AppFonts.b4s24regular,
            ),
            const SizedBox(height: 20),
            Assets.images.testSvgIcon.svg(width: 220, height: 220),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.pushNamed(MobilePages.expenseAddPage.name);
              },
              child: Text(
                LocaleKeys.expense_add_title.tr(),
                style: AppFonts.b4s18regular,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
