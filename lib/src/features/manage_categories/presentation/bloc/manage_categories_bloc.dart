import 'package:equatable/equatable.dart';
import 'package:finance_flow/src/features/manage_categories/domain/entity/manage_categories_entity.dart';
import 'package:finance_flow/src/features/manage_categories/domain/repository/manage_categories_repository.dart';
import 'package:finance_flow/src/features/manage_categories/presentation/widgets/category_list_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'manage_categories_event.dart';
part 'manage_categories_state.dart';

const _unchanged = Object();

class ManageCategoriesBloc
    extends Bloc<ManageCategoriesEvent, ManageCategoriesState> {
  ManageCategoriesBloc(this._repository)
    : super(const ManageCategoriesState()) {
    on<ManageCategoriesTabChanged>(_onTabChanged);
    on<ManageCategoriesGroupChanged>(_onGroupChanged);
    on<LoadCategoriesOrder>(_onLoadCategoriesOrder);
    on<CategoriesOrderDraftChanged>(_onCategoriesOrderDraftChanged);
    on<RevertCategoriesOrder>(_onRevertCategoriesOrder);
    on<SaveCategoriesOrder>(_onSaveCategoriesOrder);
  }

  final ManageCategoriesRepository _repository;

  void _onTabChanged(
    ManageCategoriesTabChanged event,
    Emitter<ManageCategoriesState> emit,
  ) {
    emit(state.copyWith(selectedTab: event.tab));
  }

  void _onGroupChanged(
    ManageCategoriesGroupChanged event,
    Emitter<ManageCategoriesState> emit,
  ) {
    emit(state.copyWith(selectedGroup: event.group));
  }

  Future<void> _onLoadCategoriesOrder(
    LoadCategoriesOrder event,
    Emitter<ManageCategoriesState> emit,
  ) async {
    final entity = await _repository.getCategoriesOrder();
    final order = entity.categories.isEmpty
        ? getDefaultCategoriesOrder()
        : entity;
    emit(state.copyWith(
      categoriesOrder: order,
      initialCategoriesOrder: order,
    ));
  }

  void _onCategoriesOrderDraftChanged(
    CategoriesOrderDraftChanged event,
    Emitter<ManageCategoriesState> emit,
  ) {
    emit(state.copyWith(categoriesOrder: event.entity));
  }

  void _onRevertCategoriesOrder(
    RevertCategoriesOrder event,
    Emitter<ManageCategoriesState> emit,
  ) {
    final initial = state.initialCategoriesOrder;
    if (initial != null) {
      emit(state.copyWith(categoriesOrder: initial));
    }
  }

  Future<void> _onSaveCategoriesOrder(
    SaveCategoriesOrder event,
    Emitter<ManageCategoriesState> emit,
  ) async {
    final order = state.categoriesOrder;
    if (order != null && order.categories.isNotEmpty) {
      await _repository.saveCategoriesOrder(order);
      emit(state.copyWith(initialCategoriesOrder: order));
    }
  }
}
