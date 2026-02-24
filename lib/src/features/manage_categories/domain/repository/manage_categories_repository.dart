import 'package:finance_flow/src/features/manage_categories/domain/entity/manage_categories_entity.dart';

/// Абстрактный репозиторий для сохранения и загрузки порядка категорий.
abstract class ManageCategoriesRepository {
  /// Загрузить сохранённый порядок категорий (и их иконки).
  /// Если порядок ещё не сохранялся — вернуть пустой список или дефолтный порядок.
  Future<ManageCategoriesEntity> getCategoriesOrder();

  /// Сохранить порядок категорий для последующего восстановления после перезапуска приложения.
  Future<void> saveCategoriesOrder(ManageCategoriesEntity entity);
}
