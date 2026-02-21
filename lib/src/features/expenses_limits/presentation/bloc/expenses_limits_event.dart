part of 'expenses_limits_bloc.dart';

abstract class ExpensesLimitsEvent {}

class LoadLimits extends ExpensesLimitsEvent {}

class PeriodChanged extends ExpensesLimitsEvent {
  PeriodChanged(this.period);
  final TotalLimitPeriod period;
}

class CategoryLimitChanged extends ExpensesLimitsEvent {
  CategoryLimitChanged(this.category, this.value);
  final CategoryForLimit category;
  final double value;
}

/// Откат к сохранённым значениям (при нажатии «Отмена»).
class RevertLimits extends ExpensesLimitsEvent {
  RevertLimits({this.categoryLimits, this.selectedPeriod});

  final Map<CategoryForLimit, double>? categoryLimits;
  final TotalLimitPeriod? selectedPeriod;
}

/// Успешное сохранение — сбрасываем «есть изменения», кнопки деактивируются.
class LimitsSaved extends ExpensesLimitsEvent {}
