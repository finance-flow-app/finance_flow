part of 'expense_add_bloc.dart';

abstract class ExpenseAddEvent {}

class ExpenseAddInitial extends ExpenseAddEvent {}

/// Событие для pull-to-refresh: завершает Future в UI тогда,
/// когда в bloc закончилась загрузка.
class ExpenseAddRefreshRequested extends ExpenseAddEvent {
  ExpenseAddRefreshRequested(this.completer);

  final Completer<void> completer;
}

class ExpenseAddisLoading extends ExpenseAddEvent {}

class ExpenseAddisNotLoading extends ExpenseAddEvent {}

class ExpenseAddisError extends ExpenseAddEvent {
  final String error;

  ExpenseAddisError(this.error);
}

class AmountChanged extends ExpenseAddEvent {
  final double amount;
  AmountChanged(this.amount);
}

class DescriptionChanged extends ExpenseAddEvent {
  final String description;
  DescriptionChanged(this.description);
}

class CategoryChanged extends ExpenseAddEvent {
  final String? category;
  CategoryChanged(this.category);
}

class LimitPeriodChanged extends ExpenseAddEvent {
  final LimitPeriod limitPeriod;
  LimitPeriodChanged(this.limitPeriod);
}

class ExpenseSubmitted extends ExpenseAddEvent {}
