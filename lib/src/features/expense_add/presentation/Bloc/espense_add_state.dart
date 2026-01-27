part of 'expense_add_bloc.dart';

const _unchanged = Object();

enum SaveStatus { initial, success, failure }

enum LimitPeriod { day, week, month }

class ExpenseAddState extends Equatable {
  const ExpenseAddState({
    this.isLoading = false,
    this.saveStatus = SaveStatus.initial,
    this.amount = 0.0,
    this.description,
    this.category,
    this.limitPeriod = LimitPeriod.day,
  });

  final bool isLoading;
  final SaveStatus saveStatus;
  final double amount;
  final String? description;
  final String? category;
  final LimitPeriod limitPeriod;

  bool get isValid => amount > 0;

  ExpenseAddState copyWith({
    bool? isLoading,
    SaveStatus? saveStatus,
    double? amount,
    String? description,
    Object? category = _unchanged,
    LimitPeriod? limitPeriod,
  }) {
    return ExpenseAddState(
      isLoading: isLoading ?? this.isLoading,
      saveStatus: saveStatus ?? this.saveStatus,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      category: category == _unchanged ? this.category : category as String?,
      limitPeriod: limitPeriod ?? this.limitPeriod,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    saveStatus,
    amount,
    description,
    category,
    limitPeriod,
  ];
}
