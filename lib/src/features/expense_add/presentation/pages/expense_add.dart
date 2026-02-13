import 'package:easy_localization/easy_localization.dart';
import 'package:finance_flow/core/assets/app_fonts.dart';
import 'package:finance_flow/core/di/service_locator.dart';
import 'package:finance_flow/core/generated/localization/locale_keys.g.dart';
import 'package:finance_flow/core/presentation/widgets/alert_servies.dart';
import 'package:finance_flow/core/shared/app_navigation_widget.dart';
import 'package:finance_flow/src/features/expense_add/domain/repository/expense_add_repository.dart';
import 'package:finance_flow/src/features/expense_add/presentation/Bloc/expense_add_bloc.dart';
import 'package:finance_flow/src/features/expense_add/presentation/widgets/add_expense_button.dart';
import 'package:finance_flow/src/features/expense_add/presentation/widgets/amount_form_field.dart';
import 'package:finance_flow/src/features/expense_add/presentation/widgets/categories_of_expense.dart';
import 'package:finance_flow/src/features/expense_add/presentation/widgets/current_limit_field.dart';
import 'package:finance_flow/src/features/expense_add/presentation/widgets/description_form_field.dart';
import 'package:finance_flow/src/features/expense_add/presentation/widgets/switch_limit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ExpenseAddScreen extends StatelessWidget {
  const ExpenseAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ExpenseAddBloc(sl<ExpenseAddRepository>()),
      child: const _ExpenseAddContent(),
    );
  }
}

class _ExpenseAddContent extends StatelessWidget {
  const _ExpenseAddContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.expense_add_title.tr(),
          style: AppFonts.b4s26regular,
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                final bloc = context.read<ExpenseAddBloc>();
                bloc.add(ExpenseAddInitial());
                await bloc.stream
                    .where((ExpenseAddState s) => !s.isLoading)
                    .first
                    .timeout(const Duration(seconds: 30));
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight:
                        MediaQuery.of(context).size.height -
                        kToolbarHeight -
                        MediaQuery.of(context).padding.top -
                        80,
                  ),
                  child: BlocConsumer<ExpenseAddBloc, ExpenseAddState>(
                    listenWhen: (previous, current) =>
                        previous.saveStatus != current.saveStatus,
                    listener: (context, state) {
                      if (state.saveStatus == SaveStatus.success) {
                        AlertServices.show(
                          context,
                          title: LocaleKeys.expense_saved.tr(),
                          type: AlertType.success,
                        );
                        context.pop();
                      } else if (state.saveStatus == SaveStatus.failure) {
                        AlertServices.show(
                          context,
                          title: LocaleKeys.expense_save_error.tr(),
                          type: AlertType.error,
                        );
                      }
                    },
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 16),
                            SwitchLimitButtonWidget(
                              selectedPeriod: state.limitPeriod,
                              onPeriodChanged: (period) {
                                context.read<ExpenseAddBloc>().add(
                                  LimitPeriodChanged(period),
                                );
                              },
                            ),
                            const SizedBox(height: 16),
                            CurrentLimitFieldWidget(
                              amount: state.amount,
                              limitPeriod: state.limitPeriod,
                            ),
                            const SizedBox(height: 20),
                            CategoriesOfExpenseWidget(
                              selectedCategory: state.category,
                              onCategorySelected: (category) {
                                context.read<ExpenseAddBloc>().add(
                                  CategoryChanged(category),
                                );
                              },
                            ),
                            const SizedBox(height: 20),
                            AmountFormFieldWidget(
                              currency: context.locale.languageCode == 'ru'
                                  ? 'RUB'
                                  : 'USD',
                              hintText: '0,00',
                              onChanged: (amount) {
                                context.read<ExpenseAddBloc>().add(
                                  AmountChanged(amount),
                                );
                                // debugPrint('amount: $amount');
                              },
                            ),
                            const SizedBox(height: 20),
                            DescriptionFormFieldWidget(
                              hintText: LocaleKeys.description_optional.tr(),
                              onChanged: (description) {
                                context.read<ExpenseAddBloc>().add(
                                  DescriptionChanged(description),
                                );
                              },
                            ),
                            const SizedBox(height: 20),
                            AddExpenseButton(
                              isEnabled: state.isValid && !state.isSubmitting,
                              isSubmitting: state.isSubmitting,
                              onPressed: () {
                                context.read<ExpenseAddBloc>().add(
                                  ExpenseSubmitted(),
                                );
                              },
                              child: state.isSubmitting
                                  ? const SizedBox(
                                      height: 40,
                                      width: 40,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              Colors.white,
                                            ),
                                      ),
                                    )
                                  : Text(
                                      LocaleKeys.add_expense.tr(),
                                      style: AppFonts.b6s22semiBold.copyWith(
                                        color:
                                            (state.isValid &&
                                                !state.isSubmitting)
                                            ? Colors.white
                                            : Theme.of(context)
                                                  .colorScheme
                                                  .onSurface
                                                  .withValues(alpha: 0.5),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const SafeArea(
        top: false,
        left: false,
        right: false,
        bottom: false,
        child: AppNavigationWidget(selectedIndex: -1),
      ),
    );
  }
}
