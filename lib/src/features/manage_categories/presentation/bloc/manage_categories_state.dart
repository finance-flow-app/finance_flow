part of 'manage_categories_bloc.dart';

enum CategoryTab { active, archived, auto }

enum CategoryGroup {
  all,
  essentials,
  lifestyle,
  work,
  subscriptions,
  custom,
}

class ManageCategoriesState extends Equatable {
  const ManageCategoriesState({
    this.selectedTab = CategoryTab.active,
    this.selectedGroup = CategoryGroup.all,
    this.categoriesOrder,
    this.initialCategoriesOrder,
  });

  final CategoryTab selectedTab;
  final CategoryGroup selectedGroup;

  /// Текущий порядок (черновик при перетаскивании).
  final ManageCategoriesEntity? categoriesOrder;

  /// Исходный порядок при открытии страницы (из репозитория). Для «Отмена».
  final ManageCategoriesEntity? initialCategoriesOrder;

  ManageCategoriesState copyWith({
    CategoryTab? selectedTab,
    CategoryGroup? selectedGroup,
    ManageCategoriesEntity? categoriesOrder,
    Object? initialCategoriesOrder = _unchanged,
  }) {
    return ManageCategoriesState(
      selectedTab: selectedTab ?? this.selectedTab,
      selectedGroup: selectedGroup ?? this.selectedGroup,
      categoriesOrder: categoriesOrder ?? this.categoriesOrder,
      initialCategoriesOrder:
          initialCategoriesOrder == _unchanged
              ? this.initialCategoriesOrder
              : initialCategoriesOrder as ManageCategoriesEntity?,
    );
  }

  @override
  List<Object?> get props =>
      [selectedTab, selectedGroup, categoriesOrder, initialCategoriesOrder];
}
