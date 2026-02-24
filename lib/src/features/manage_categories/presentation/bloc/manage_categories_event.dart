part of 'manage_categories_bloc.dart';

abstract class ManageCategoriesEvent {}

class ManageCategoriesInitial extends ManageCategoriesEvent {}

class ManageCategoriesTabChanged extends ManageCategoriesEvent {
  final CategoryTab tab;
  ManageCategoriesTabChanged(this.tab);
}

class ManageCategoriesGroupChanged extends ManageCategoriesEvent {
  final CategoryGroup group;
  ManageCategoriesGroupChanged(this.group);
}

/// Загрузить порядок категорий из репозитория; если пусто — подставить дефолт из presentation.
class LoadCategoriesOrder extends ManageCategoriesEvent {}

/// Обновить черновик порядка (только state, без сохранения в репозиторий).
class CategoriesOrderDraftChanged extends ManageCategoriesEvent {
  final ManageCategoriesEntity entity;
  CategoriesOrderDraftChanged(this.entity);
}

/// Вернуть список к исходному порядку (кнопка «Отмена»).
class RevertCategoriesOrder extends ManageCategoriesEvent {}

/// Сохранить текущий порядок из state в репозиторий (кнопка «Save changes»).
class SaveCategoriesOrder extends ManageCategoriesEvent {}
