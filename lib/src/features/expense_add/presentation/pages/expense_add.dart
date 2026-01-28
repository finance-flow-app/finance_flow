import 'package:easy_localization/easy_localization.dart';
import 'package:finance_flow/core/assets/app_fonts.dart';
import 'package:finance_flow/core/generated/assets/assets.gen.dart';
import 'package:finance_flow/core/generated/localization/locale_keys.g.dart';
import 'package:finance_flow/core/presentation/widgets/alert_servies.dart';
import 'package:finance_flow/src/features/expense_add/presentation/Bloc/expense_add_bloc.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.expense_add_title.tr(),
          style: AppFonts.b4s26regular,
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: BlocConsumer<ExpenseAddBloc, ExpenseAddState>(
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
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                Text(
                  LocaleKeys.current_limit.tr(),
                  style: AppFonts.b5s26medium,
                ),
                const SizedBox(height: 20),
                CurrentLimitFieldWidget(
                  style: AppFonts.b4s30regular,
                  amount: state.amount,
                  limitPeriod: state.limitPeriod,
                ),
                const SizedBox(height: 20),
                SwitchLimitButtonWidget(
                  selectedPeriod: state.limitPeriod,
                  onPeriodChanged: (period) {
                    context.read<ExpenseAddBloc>().add(
                      LimitPeriodChanged(period),
                    );
                  },
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
                  suffixIcon: context.locale.languageCode == 'ru'
                      ? Assets.icons.currencyRuble.svg(width: 24, height: 24)
                      : Assets.icons.currencyDollar.svg(width: 24, height: 24),
                  hintText: '0,00',
                  onChanged: (amount) {
                    context.read<ExpenseAddBloc>().add(AmountChanged(amount));
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
                ElevatedButton(
                  onPressed: state.isValid && !state.isSubmitting
                      ? () {
                          context.read<ExpenseAddBloc>().add(
                            ExpenseSubmitted(),
                          );
                        }
                      : null,
                  child: state.isSubmitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : Text(LocaleKeys.add.tr(), style: AppFonts.b4s18regular),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
