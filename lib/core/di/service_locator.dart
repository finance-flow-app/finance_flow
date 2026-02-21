import 'package:finance_flow/src/features/analytics/presentation/bloc/analytics_bloc.dart';
import 'package:finance_flow/src/features/expense_add/data/repository/expense_add_repository_impl.dart';
import 'package:finance_flow/src/features/expense_add/domain/repository/expense_add_repository.dart';
import 'package:finance_flow/src/features/expense_add/presentation/Bloc/expense_add_bloc.dart';
import 'package:finance_flow/src/features/expenses_limits/data/repository/expenses_limits_repository_impl.dart';
import 'package:finance_flow/src/features/expenses_limits/domain/repository/expenses_limits_repository.dart';
import 'package:finance_flow/src/features/expenses_limits/presentation/bloc/expenses_limits_bloc.dart';
import 'package:finance_flow/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:finance_flow/src/features/theme/data/repository/theme_repository_impl.dart';
import 'package:finance_flow/src/features/theme/domain/repository/theme_repository.dart';
import 'package:finance_flow/src/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt sl = GetIt.instance;

Future<void> setupServiceLocator(SharedPreferences sharedPreferences) async {
  sl.registerSingleton<SharedPreferences>(sharedPreferences);

  sl.registerFactory<ExpenseAddBloc>(
    () => ExpenseAddBloc(sl<ExpenseAddRepository>(), sl<SharedPreferences>()),
  );

  sl.registerFactory<HomeBloc>(() => HomeBloc());

  sl.registerFactory<AnalyticsBloc>(() => AnalyticsBloc());

  sl.registerLazySingleton<ThemeRepository>(() => ThemeRepositoryImpl(sl()));
  sl.registerLazySingleton<ThemeBloc>(() => ThemeBloc(sl()));

  sl.registerFactory<ExpenseAddRepository>(
    () => ExpenseAddRepositoryImpl(
      sl<SharedPreferences>(),
      limitsRepository: sl<ExpensesLimitsRepository>(),
    ),
  );

  sl.registerFactory<ExpensesLimitsRepository>(
    () => ExpensesLimitsRepositoryImpl(prefs: sl<SharedPreferences>()),
  );

  sl.registerFactory<ExpensesLimitsBloc>(
    () => ExpensesLimitsBloc(
      languageCode: sl<SharedPreferences>().getString('language_code') ?? 'en',
      repo: sl<ExpensesLimitsRepository>(),
    ),
  );
}
