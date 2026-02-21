import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:finance_flow/core/assets/app_fonts.dart';
import 'package:finance_flow/core/di/service_locator.dart';
import 'package:finance_flow/core/generated/localization/locale_keys.g.dart';
import 'package:finance_flow/core/presentation/widgets/alert_servies.dart';
import 'package:finance_flow/core/shared/app_custom_appbar.dart';
import 'package:finance_flow/core/shared/app_navigation_widget.dart';
import 'package:finance_flow/src/features/expenses_limits/domain/entity/saved_limits.dart';
import 'package:finance_flow/src/features/expenses_limits/domain/repository/expenses_limits_repository.dart';
import 'package:finance_flow/src/features/expenses_limits/presentation/bloc/expenses_limits_bloc.dart';
import 'package:finance_flow/core/shared/period_segment_switcher.dart';
import 'package:finance_flow/src/features/expenses_limits/presentation/widgets/category_limit_list.dart';
import 'package:finance_flow/src/features/expenses_limits/presentation/widgets/sticky_footer_button.dart';
import 'package:finance_flow/src/features/expenses_limits/presentation/widgets/total_limit_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpensesLimitsPage extends StatelessWidget {
  const ExpensesLimitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ExpensesLimitsBloc>(),
      child: const _ExpensesLimitsContent(),
    );
  }
}

class _ExpensesLimitsContent extends StatelessWidget {
  const _ExpensesLimitsContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppCustomAppBar(
        title: Text(
          LocaleKeys.expenses_limits_title.tr(),
          style: AppFonts.b5s26medium,
        ),
      ),
      body: BlocBuilder<ExpensesLimitsBloc, ExpensesLimitsState>(
        builder: (context, state) {
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            behavior: HitTestBehavior.opaque,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                top: 16,
                bottom: 16 + AppNavigationWidget.bottomNavBarReservedHeight,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: PeriodSegmentSwitcher<TotalLimitPeriod>(
                      items: TotalLimitPeriod.values,
                      selectedValue: state.selectedPeriod,
                      labelBuilder: (p) => switch (p) {
                        TotalLimitPeriod.day =>
                          LocaleKeys.limit_period_day.tr(),
                        TotalLimitPeriod.week =>
                          LocaleKeys.limit_period_week.tr(),
                        TotalLimitPeriod.month =>
                          LocaleKeys.limit_period_month.tr(),
                      },
                      onValueChanged: (period) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        context.read<ExpensesLimitsBloc>().add(
                          PeriodChanged(period),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  TotalLimitCardWidget(
                    amount:
                        state.totalLimitAmount *
                        state.selectedPeriod.periodFactor,
                    period: state.selectedPeriod,
                  ),
                  CategoryLimitListWidget(
                    categoryLimits: state.categoryLimits,
                    selectedPeriod: state.selectedPeriod,
                    onCategoryLimitChanged: (category, value) {
                      context.read<ExpensesLimitsBloc>().add(
                        CategoryLimitChanged(category, value),
                      );
                    },
                  ),
                  const SizedBox(height: 22),
                  StickyFooterButtonWidget(
                    hasChanges: state.hasUnsavedChanges,
                    onCancel: () async {
                      final repo = sl<ExpensesLimitsRepository>();
                      final saved = await repo.load();
                      if (!context.mounted) return;
                      if (saved != null) {
                        final limits = <CategoryForLimit, double>{};
                        for (final e in CategoryForLimit.values) {
                          final v = saved.categoryLimits[e.name];
                          if (v != null) limits[e] = v;
                        }
                        final period =
                            TotalLimitPeriod.values.firstWhereOrNull(
                              (p) => p.name == saved.selectedPeriod,
                            ) ??
                            TotalLimitPeriod.day;
                        context.read<ExpensesLimitsBloc>().add(
                          RevertLimits(
                            categoryLimits: limits,
                            selectedPeriod: period,
                          ),
                        );
                      }
                    },
                    onApply: () async {
                      final bloc = context.read<ExpensesLimitsBloc>();
                      final state = bloc.state;
                      final data = SavedLimits(
                        categoryLimits: state.categoryLimits.map(
                          (k, v) => MapEntry(k.name, v),
                        ),
                        selectedPeriod: state.selectedPeriod.name,
                      );
                      try {
                        await sl<ExpensesLimitsRepository>().save(data);
                        if (!context.mounted) return;
                        bloc.add(LimitsSaved());
                        if (!context.mounted) return;
                        AlertServices.show(
                          context,
                          title: LocaleKeys.expenses_limits_limits_saved.tr(),
                          type: AlertType.success,
                        );
                      } catch (_) {
                        if (!context.mounted) return;
                        AlertServices.show(
                          context,
                          title: LocaleKeys.expenses_limits_limits_save_error
                              .tr(),
                          type: AlertType.error,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
