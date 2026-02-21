import 'package:finance_flow/src/features/expenses_limits/domain/entity/limit_amounts_for_periods.dart';
import 'package:finance_flow/src/features/expenses_limits/domain/entity/saved_limits.dart';

abstract class ExpensesLimitsRepository {
  Future<SavedLimits?> load();

  Future<void> save(SavedLimits data);

  /// Суммарный лимит за день (из сохранённых или дефолтов по [languageCode]).
  Future<double> getTotalLimitPerDay(String languageCode);

  /// Лимиты для дня, недели и месяца (из сохранённых или дефолтов по [languageCode]).
  Future<LimitAmountsForPeriods> getLimitAmountsForPeriods(String languageCode);
}
