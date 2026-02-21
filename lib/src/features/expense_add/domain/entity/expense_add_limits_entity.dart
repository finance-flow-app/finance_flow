import 'package:equatable/equatable.dart';

/// Лимиты на день, неделю и месяц и по категориям за день для экрана добавления расхода.
class ExpenseAddLimitsEntity extends Equatable {
  const ExpenseAddLimitsEntity({
    required this.limitForDay,
    required this.limitForWeek,
    required this.limitForMonth,
    required this.categoryLimitsPerDay,
  });

  final double limitForDay;
  final double limitForWeek;
  final double limitForMonth;
  final Map<String, double> categoryLimitsPerDay;

  @override
  List<Object?> get props => [
    limitForDay,
    limitForWeek,
    limitForMonth,
    categoryLimitsPerDay,
  ];
}
