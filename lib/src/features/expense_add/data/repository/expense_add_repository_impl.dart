import 'dart:convert';
import 'package:finance_flow/src/features/expense_add/domain/entity/expense_add_entity.dart';
import 'package:finance_flow/src/features/expense_add/domain/entity/expense_add_limits_entity.dart';
import 'package:finance_flow/src/features/expense_add/domain/repository/expense_add_repository.dart';
import 'package:finance_flow/src/features/expenses_limits/domain/repository/expenses_limits_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseAddRepositoryImpl implements ExpenseAddRepository {
  static const _saveEntityKey = 'expense_entities';

  ExpenseAddRepositoryImpl(
    this._sharedPreferences, {
    required ExpensesLimitsRepository limitsRepository,
  }) : _limitsRepository = limitsRepository;

  final SharedPreferences _sharedPreferences;
  final ExpensesLimitsRepository _limitsRepository;

  @override
  Future<void> saveExpense(ExpenseAddEntity entity) async {
    final list = _loadEntities();
    list.add(entity);
    await _saveEntities(list);
  }

  List<ExpenseAddEntity> _loadEntities() {
    final raw = _sharedPreferences.getString(_saveEntityKey);
    if (raw == null || raw.isEmpty) return [];
    final decoded = jsonDecode(raw);
    if (decoded is! List) return [];
    return decoded
        .map<ExpenseAddEntity>(
          (e) => ExpenseAddEntity.fromJson(Map<String, dynamic>.from(e as Map)),
        )
        .toList();
  }

  Future<void> _saveEntities(List<ExpenseAddEntity> list) async {
    final encoded = list.map((e) => e.toJson()).toList();
    await _sharedPreferences.setString(_saveEntityKey, jsonEncode(encoded));
  }

  @override
  Future<ExpenseAddLimitsEntity?> loadLimits(String languageCode) async {
    final amounts = await _limitsRepository.getLimitAmountsForPeriods(
      languageCode,
    );
    return ExpenseAddLimitsEntity(
      limitForDay: amounts.limitForDay,
      limitForWeek: amounts.limitForWeek,
      limitForMonth: amounts.limitForMonth,
      categoryLimitsPerDay: Map<String, double>.from(
        amounts.categoryLimitsPerDay,
      ),
    );
  }
}
