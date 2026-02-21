import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:finance_flow/src/features/expenses_limits/domain/repository/expenses_limits_repository.dart';
import 'package:finance_flow/src/features/expenses_limits/presentation/widgets/category_limit_list.dart';
import 'package:finance_flow/src/features/expenses_limits/presentation/widgets/total_limit_card_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'expenses_limits_event.dart';
part 'expenses_limits_state.dart';

class ExpensesLimitsBloc
    extends Bloc<ExpensesLimitsEvent, ExpensesLimitsState> {
  ExpensesLimitsBloc({
    required String languageCode,
    required ExpensesLimitsRepository repo,
  }) : _repo = repo,
       super(ExpensesLimitsState.initial(languageCode)) {
    on<LoadLimits>(_onLoadLimits);
    on<PeriodChanged>(_onPeriodChanged);
    on<CategoryLimitChanged>(_onCategoryLimitChanged);
    on<RevertLimits>(_onRevertLimits);
    on<LimitsSaved>(_onLimitsSaved);
    add(LoadLimits());
  }

  final ExpensesLimitsRepository _repo;

  Future<void> _onLoadLimits(
    LoadLimits event,
    Emitter<ExpensesLimitsState> emit,
  ) async {
    final saved = await _repo.load();
    if (saved == null) return;
    final categoryLimits = _savedToCategoryLimits(saved.categoryLimits);
    final selectedPeriod = _stringToPeriod(saved.selectedPeriod);
    if (categoryLimits != null && selectedPeriod != null) {
      emit(
        state.copyWith(
          categoryLimits: categoryLimits,
          selectedPeriod: selectedPeriod,
          baselineCategoryLimits: categoryLimits,
          baselineSelectedPeriod: selectedPeriod,
        ),
      );
    }
  }

  void _onPeriodChanged(
    PeriodChanged event,
    Emitter<ExpensesLimitsState> emit,
  ) {
    emit(state.copyWith(selectedPeriod: event.period));
  }

  void _onCategoryLimitChanged(
    CategoryLimitChanged event,
    Emitter<ExpensesLimitsState> emit,
  ) {
    final next = Map<CategoryForLimit, double>.from(state.categoryLimits)
      ..[event.category] = event.value;
    emit(state.copyWith(categoryLimits: next));
  }

  void _onRevertLimits(RevertLimits event, Emitter<ExpensesLimitsState> emit) {
    final next = state.copyWith(
      categoryLimits: event.categoryLimits,
      selectedPeriod: event.selectedPeriod,
      baselineCategoryLimits: event.categoryLimits,
      baselineSelectedPeriod: event.selectedPeriod,
    );
    emit(next);
  }

  void _onLimitsSaved(LimitsSaved event, Emitter<ExpensesLimitsState> emit) {
    emit(
      state.copyWith(
        baselineCategoryLimits: state.categoryLimits,
        baselineSelectedPeriod: state.selectedPeriod,
      ),
    );
  }

  static Map<CategoryForLimit, double>? _savedToCategoryLimits(
    Map<String, double> saved,
  ) {
    final result = <CategoryForLimit, double>{};
    for (final e in CategoryForLimit.values) {
      final v = saved[e.name];
      if (v != null) result[e] = v;
    }
    return result.isEmpty ? null : result;
  }

  static TotalLimitPeriod? _stringToPeriod(String s) {
    return TotalLimitPeriod.values.firstWhereOrNull((p) => p.name == s);
  }
}
