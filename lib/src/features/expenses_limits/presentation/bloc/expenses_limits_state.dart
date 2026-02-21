part of 'expenses_limits_bloc.dart';

class ExpensesLimitsState extends Equatable {
  const ExpensesLimitsState({
    this.selectedPeriod = TotalLimitPeriod.day,
    this.categoryLimits = const {},
    this.baselineSelectedPeriod,
    this.baselineCategoryLimits,
  });

  factory ExpensesLimitsState.initial(String languageCode) {
    final defaults = defaultCategoryLimitsFor(languageCode);
    return ExpensesLimitsState(
      selectedPeriod: TotalLimitPeriod.day,
      categoryLimits: defaults,
      baselineSelectedPeriod: TotalLimitPeriod.day,
      baselineCategoryLimits: defaults,
    );
  }

  final TotalLimitPeriod selectedPeriod;
  final Map<CategoryForLimit, double> categoryLimits;

  /// «Эталон» после загрузки / отмены / сохранения; кнопки активны только при отличии от эталона.
  final TotalLimitPeriod? baselineSelectedPeriod;
  final Map<CategoryForLimit, double>? baselineCategoryLimits;

  /// Суммарный лимит за день = сумма лимитов по категориям (все хранятся «за день»).
  double get totalLimitAmount =>
      categoryLimits.values.fold(0.0, (a, b) => a + b);

  /// Есть несохранённые изменения относительно последней загрузки/отмены/сохранения.
  bool get hasUnsavedChanges {
    if (baselineCategoryLimits == null || baselineSelectedPeriod == null) {
      return false;
    }
    if (selectedPeriod != baselineSelectedPeriod) return true;
    if (categoryLimits.length != baselineCategoryLimits!.length) return true;
    for (final e in categoryLimits.entries) {
      if ((baselineCategoryLimits![e.key] ?? 0) != e.value) return true;
    }
    return false;
  }

  ExpensesLimitsState copyWith({
    TotalLimitPeriod? selectedPeriod,
    Map<CategoryForLimit, double>? categoryLimits,
    TotalLimitPeriod? baselineSelectedPeriod,
    Map<CategoryForLimit, double>? baselineCategoryLimits,
  }) {
    return ExpensesLimitsState(
      selectedPeriod: selectedPeriod ?? this.selectedPeriod,
      categoryLimits: categoryLimits ?? this.categoryLimits,
      baselineSelectedPeriod:
          baselineSelectedPeriod ?? this.baselineSelectedPeriod,
      baselineCategoryLimits:
          baselineCategoryLimits ?? this.baselineCategoryLimits,
    );
  }

  @override
  List<Object?> get props => [
    selectedPeriod,
    categoryLimits,
    totalLimitAmount,
    baselineSelectedPeriod,
    baselineCategoryLimits,
  ];
}
