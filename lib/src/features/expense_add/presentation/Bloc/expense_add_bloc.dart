import 'package:equatable/equatable.dart';
import 'package:finance_flow/core/generated/localization/locale_keys.g.dart';
import 'package:finance_flow/src/features/expense_add/domain/entity/expense_add_entity.dart';
import 'package:finance_flow/src/features/expense_add/domain/repository/expense_add_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'expense_add_event.dart';
part 'espense_add_state.dart';

class ExpenseAddBloc extends Bloc<ExpenseAddEvent, ExpenseAddState> {
  ExpenseAddBloc(this._repository) : super(const ExpenseAddState()) {
    on<AmountChanged>(_onAmountChanged);
    on<DescriptionChanged>(_onDescriptionChanged);
    on<CategoryChanged>(_onCategoryChanged);
    on<LimitPeriodChanged>(_onLimitPeriodChanged);
    on<ExpenseSubmitted>(_onExpenseSubmitted);
    on<ExpenseAddInitial>(_onExpenseAddInitial);
  }

  final ExpenseAddRepository _repository;

  void _onAmountChanged(AmountChanged event, Emitter<ExpenseAddState> emit) {
    emit(state.copyWith(amount: event.amount));
  }

  void _onDescriptionChanged(
    DescriptionChanged event,
    Emitter<ExpenseAddState> emit,
  ) {
    emit(state.copyWith(description: event.description));
  }

  void _onCategoryChanged(
    CategoryChanged event,
    Emitter<ExpenseAddState> emit,
  ) {
    emit(state.copyWith(category: event.category));
  }

  void _onLimitPeriodChanged(
    LimitPeriodChanged event,
    Emitter<ExpenseAddState> emit,
  ) {
    emit(state.copyWith(limitPeriod: event.limitPeriod));
  }

  Future<void> _onExpenseSubmitted(
    ExpenseSubmitted event,
    Emitter<ExpenseAddState> emit,
  ) async {
    if (!state.isValid || state.isSubmitting) return;
    emit(state.copyWith(isSubmitting: true, saveStatus: SaveStatus.initial));
    await Future.delayed(const Duration(milliseconds: 1000));
    try {
      final entity = ExpenseAddEntity(
        amount: state.amount,
        category: state.category ?? LocaleKeys.categories_other_category,
        description: state.description?.isNotEmpty == true
            ? state.description
            : null,
        createdAt: DateTime.now(),
      );
      await _repository.saveExpense(entity);
      emit(state.copyWith(isSubmitting: false, saveStatus: SaveStatus.success));
    } catch (_) {
      emit(state.copyWith(isSubmitting: false, saveStatus: SaveStatus.failure));
    }
  }

  Future<void> _onExpenseAddInitial(
    ExpenseAddInitial event,
    Emitter<ExpenseAddState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(milliseconds: 1)); // имитация загрузки
    try {
      // загрузка данных (лимиты, категории и т.п.)
      emit(state.copyWith(isLoading: false));
    } catch (_) {
      emit(state.copyWith(isLoading: false));
    }
  }
}
