import 'package:finance_flow/src/features/expense_add/domain/entity/expense_add_entity.dart';

abstract interface class ExpenseAddRepository {
  Future<void> saveExpense(ExpenseAddEntity entity);
}
