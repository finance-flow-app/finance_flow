part of 'expense_add_bloc.dart';

const _unchanged = Object();

enum SaveStatus { initial, success, failure }

enum LimitPeriod { day, week, month }

/// Множитель периода: день = 1, неделя = 7, месяц = 30.
int limitPeriodMultiplier(LimitPeriod period) {
  return switch (period) {
    LimitPeriod.day => 1,
    LimitPeriod.week => 7,
    LimitPeriod.month => 30,
  };
}

class ExpenseAddState extends Equatable {
  const ExpenseAddState({
    this.isLoading = false,
    this.isSubmitting = false,
    this.saveStatus = SaveStatus.initial,
    this.amount = 0.0,
    this.description,
    this.category,
    this.limitPeriod = LimitPeriod.day,
    this.limits,
  });

  final bool isLoading;
  final bool isSubmitting;
  final SaveStatus saveStatus;
  final double amount;
  final String? description;
  final String? category;
  final LimitPeriod limitPeriod;
  final ExpenseAddLimitsEntity? limits;

  bool get isValid => amount > 0;

  ExpenseAddState copyWith({
    bool? isLoading,
    bool? isSubmitting,
    SaveStatus? saveStatus,
    double? amount,
    String? description,
    Object? category = _unchanged,
    LimitPeriod? limitPeriod,
    ExpenseAddLimitsEntity? limits,
  }) {
    return ExpenseAddState(
      isLoading: isLoading ?? this.isLoading,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      saveStatus: saveStatus ?? this.saveStatus,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      category: category == _unchanged ? this.category : category as String?,
      limitPeriod: limitPeriod ?? this.limitPeriod,
      limits: limits ?? this.limits,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isSubmitting,
    saveStatus,
    amount,
    description,
    category,
    limitPeriod,
    limits,
  ];
}
