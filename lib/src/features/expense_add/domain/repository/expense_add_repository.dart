import 'package:finance_flow/src/features/expense_add/domain/entity/expense_add_entity.dart';
import 'package:finance_flow/src/features/expense_add/domain/entity/expense_add_limits_entity.dart';

abstract interface class ExpenseAddRepository {
  Future<void> saveExpense(ExpenseAddEntity entity);

  /// Лимиты на день, неделю и месяц (из фичи expenses_limits).
  Future<ExpenseAddLimitsEntity?> loadLimits(String languageCode);
}
