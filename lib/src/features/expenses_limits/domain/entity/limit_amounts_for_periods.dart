import 'package:equatable/equatable.dart';

/// Лимиты на день, неделю и месяц (суммы по всем категориям × множитель периода)
/// и по категориям за день (ключи — имена категорий: food, taxi, …).
/// Отдаётся из data-слоя expenses_limits для использования в других фичах.
class LimitAmountsForPeriods extends Equatable {
  const LimitAmountsForPeriods({
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
