import 'package:equatable/equatable.dart';

/// Сохранённые лимиты по категориям и выбранный период.
/// Ключи категорий — имена enum CategoryForLimit (food, restaurant, …).
/// Период — day | week | month.
class SavedLimits extends Equatable {
  const SavedLimits({
    required this.categoryLimits,
    required this.selectedPeriod,
  });

  final Map<String, double> categoryLimits;
  final String selectedPeriod;

  @override
  List<Object?> get props => [categoryLimits, selectedPeriod];

  Map<String, dynamic> toJson() => {
    'categoryLimits': categoryLimits,
    'selectedPeriod': selectedPeriod,
  };

  factory SavedLimits.fromJson(Map<String, dynamic> json) {
    final limitsRaw = json['categoryLimits'];
    final period = json['selectedPeriod'] as String?;
    if (limitsRaw is! Map<String, dynamic> || period == null) {
      throw FormatException('Invalid SavedLimits JSON');
    }
    final categoryLimits = limitsRaw.map<String, double>(
      (k, v) => MapEntry(k, (v is num) ? v.toDouble() : 0.0),
    );
    return SavedLimits(categoryLimits: categoryLimits, selectedPeriod: period);
  }
}
