import 'package:finance_flow/src/features/analytics/presentation/bloc/analytics_bloc.dart';
import 'package:finance_flow/src/features/expense_add/data/repository/expense_add_repository_impl.dart';
import 'package:finance_flow/src/features/expense_add/domain/repository/expense_add_repository.dart';
import 'package:finance_flow/src/features/expense_add/presentation/Bloc/expense_add_bloc.dart';
import 'package:finance_flow/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:finance_flow/src/features/theme/data/repository/theme_repository_impl.dart';
import 'package:finance_flow/src/features/theme/domain/repository/theme_repository.dart';
import 'package:finance_flow/src/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt sl = GetIt.instance;

Future<void> setupServiceLocator(SharedPreferences sharedPreferences) async {
  sl.registerSingleton<SharedPreferences>(sharedPreferences);

  sl.registerLazySingleton<ExpenseAddRepository>(
    () => ExpenseAddRepositoryImpl(sl()),
  );

  sl.registerFactory<ExpenseAddBloc>(() => ExpenseAddBloc(sl()));

  sl.registerFactory<HomeBloc>(() => HomeBloc());

  sl.registerFactory<AnalyticsBloc>(() => AnalyticsBloc());

  sl.registerLazySingleton<ThemeRepository>(() => ThemeRepositoryImpl(sl()));
  sl.registerLazySingleton<ThemeBloc>(() => ThemeBloc(sl()));
}
