import 'package:collection/collection.dart';
import 'package:finance_flow/src/features/expense_add/data/repository/expense_add_repository_impl.dart';
import 'package:finance_flow/src/features/expense_add/presentation/Bloc/expense_add_bloc.dart';
import 'package:finance_flow/src/features/expense_add/presentation/pages/expense_add.dart';
import 'package:finance_flow/src/features/expenses_history/presentation/bloc/expenses_history_bloc.dart';
import 'package:finance_flow/src/features/expenses_history/presentation/pages/date_range_picker_page.dart';
import 'package:finance_flow/src/features/expenses_history/presentation/pages/expenses_history_page.dart';
import 'package:finance_flow/src/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DateRangePickerParams {
  const DateRangePickerParams({this.initialDateRange, this.initialPeriodType});

  final DateTimeRange? initialDateRange;
  final LimitPeriodType? initialPeriodType;
}

class AppRouter {
  AppRouter({required SharedPreferences sharedPreferences})
    : _router = GoRouter(
        initialLocation: MobilePages.homePage.path,
        routes: [
          GoRoute(
            path: MobilePages.homePage.path,
            name: MobilePages.homePage.name,
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: MobilePages.expenseAddPage.path,
            name: MobilePages.expenseAddPage.name,
            builder: (context, state) => BlocProvider(
              create: (_) => ExpenseAddBloc(
                ExpenseAddRepositoryImpl(sharedPreferences: sharedPreferences),
              ),
              child: const ExpenseAddScreen(),
            ),
          ),
          GoRoute(
            path: MobilePages.expensesHistoryPage.path,
            name: MobilePages.expensesHistoryPage.name,
            builder: (context, state) => const ExpensesHistoryPage(),
          ),
          GoRoute(
            path: MobilePages.dateRangePickerPage.path,
            name: MobilePages.dateRangePickerPage.name,
            builder: (context, state) {
              final params = state.extra as DateRangePickerParams?;
              return DateRangePickerPage(
                initialDateRange: params?.initialDateRange,
                initialPeriodType: params?.initialPeriodType,
              );
            },
          ),
        ],
      );

  final GoRouter _router;
  GoRouter get router => _router;
}

enum MobilePages {
  homePage,
  expenseAddPage,
  expensesHistoryPage,
  dateRangePickerPage;

  static MobilePages? fromName(String? name) {
    return MobilePages.values.firstWhereOrNull(
      (MobilePages element) => element.name == name,
    );
  }
}

extension MobilePagesExt on MobilePages {
  String get path => '/$name';
}
