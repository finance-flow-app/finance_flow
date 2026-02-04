import 'package:finance_flow/src/features/expense_add/data/repository/expense_add_repository_impl.dart';
import 'package:finance_flow/src/features/expense_add/domain/repository/expense_add_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt sl = GetIt.instance;

Future<void> setupServiceLocator(SharedPreferences sharedPreferences) async {
  sl.registerSingleton<SharedPreferences>(sharedPreferences);

  sl.registerFactory<ExpenseAddRepository>(
    () => ExpenseAddRepositoryImpl(sl<SharedPreferences>()),
  );
}
