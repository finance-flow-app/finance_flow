import 'package:equatable/equatable.dart';

/// Один элемент порядка категорий: идентификатор категории и путь к иконке.
/// Порядок в списке задаёт порядок отображения.
class ManagedCategoryEntity extends Equatable {
  const ManagedCategoryEntity({
    required this.categoryId,
    required this.iconPath,
  });

  /// Идентификатор категории (например: food, transport, bills).
  final String categoryId;

  /// Путь к иконке в assets (например: assets/icons/Apple.svg).
  final String iconPath;

  @override
  List<Object?> get props => [categoryId, iconPath];
}

/// Сущность порядка категорий: упорядоченный список категорий с иконками.
class ManageCategoriesEntity extends Equatable {
  const ManageCategoriesEntity({
    required this.categories,
  });

  /// Список категорий в нужном порядке. Порядок элементов = порядок в UI.
  final List<ManagedCategoryEntity> categories;

  @override
  List<Object?> get props => [categories];
}
