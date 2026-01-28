import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'expense_add_event.dart';
part 'espense_add_state.dart';

class ExpenseAddBloc extends Bloc<ExpenseAddEvent, ExpenseAddState> {
  ExpenseAddBloc() : super(const ExpenseAddState()) {
    on<AmountChanged>(_onAmountChanged);
    on<DescriptionChanged>(_onDescriptionChanged);
    on<CategoryChanged>(_onCategoryChanged);
    on<LimitPeriodChanged>(_onLimitPeriodChanged);
    on<ExpenseSubmitted>(_onExpenseSubmitted);
  }

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
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      emit(const ExpenseAddState(saveStatus: SaveStatus.success));
    } catch (e) {
      emit(state.copyWith(isSubmitting: false, saveStatus: SaveStatus.failure));
    }
  }
}
