import 'dart:convert';

import 'package:finance_flow/src/features/expenses_limits/domain/default_limits.dart';
import 'package:finance_flow/src/features/expenses_limits/domain/entity/limit_amounts_for_periods.dart';
import 'package:finance_flow/src/features/expenses_limits/domain/entity/saved_limits.dart';
import 'package:finance_flow/src/features/expenses_limits/domain/repository/expenses_limits_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _key = 'expenses_limits_saved';

/// Хранит один объект [SavedLimits] по ключу (как в expense_add — один ключ, одно значение).
class ExpensesLimitsRepositoryImpl implements ExpensesLimitsRepository {
  ExpensesLimitsRepositoryImpl({required SharedPreferences prefs})
    : _prefs = prefs;

  final SharedPreferences _prefs;

  @override
  Future<SavedLimits?> load() async {
    final raw = _prefs.getString(_key);
    if (raw == null || raw.isEmpty) return null;
    try {
      final map = jsonDecode(raw) as Map<String, dynamic>;
      return SavedLimits.fromJson(map);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> save(SavedLimits data) async {
    await _prefs.setString(_key, jsonEncode(data.toJson()));
  }

  @override
  Future<double> getTotalLimitPerDay(String languageCode) async {
    final totalPerDay = await _totalPerDay(languageCode);
    return totalPerDay;
  }

  @override
  Future<LimitAmountsForPeriods> getLimitAmountsForPeriods(
    String languageCode,
  ) async {
    final saved = await load();
    final Map<String, double> categoryPerDay;
    if (saved != null && saved.categoryLimits.isNotEmpty) {
      categoryPerDay = Map<String, double>.from(saved.categoryLimits);
    } else {
      categoryPerDay = defaultCategoryLimitsMap(languageCode);
    }
    final totalPerDay = categoryPerDay.values.fold<double>(
      0.0,
      (a, b) => a + b,
    );
    return LimitAmountsForPeriods(
      limitForDay: totalPerDay * 1,
      limitForWeek: totalPerDay * 7,
      limitForMonth: totalPerDay * 30,
      categoryLimitsPerDay: categoryPerDay,
    );
  }

  Future<double> _totalPerDay(String languageCode) async {
    final saved = await load();
    if (saved != null && saved.categoryLimits.isNotEmpty) {
      return saved.categoryLimits.values.fold<double>(0.0, (a, b) => a + b);
    }
    final def = defaultCategoryLimitsMap(languageCode);
    return def.values.fold<double>(0.0, (a, b) => a + b);
  }
}
