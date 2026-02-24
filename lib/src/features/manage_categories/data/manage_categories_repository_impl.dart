import 'dart:convert';

import 'package:finance_flow/src/features/manage_categories/domain/entity/manage_categories_entity.dart';
import 'package:finance_flow/src/features/manage_categories/domain/repository/manage_categories_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Реализация репозитория: порядок категорий хранится в SharedPreferences.
/// Данные сохраняются между сессиями: при выходе со страницы и при перезапуске приложения
/// порядок восстанавливается из хранилища.
/// Дефолтный порядок приходит из presentation (bloc) — getDefaultCategoriesOrder().
class ManageCategoriesRepositoryImpl implements ManageCategoriesRepository {
  ManageCategoriesRepositoryImpl(this._prefs);

  static const String _keyCategoriesOrder = 'manage_categories_order';

  final SharedPreferences _prefs;

  @override
  Future<ManageCategoriesEntity> getCategoriesOrder() async {
    final raw = _prefs.getString(_keyCategoriesOrder);
    if (raw == null || raw.isEmpty) {
      return const ManageCategoriesEntity(categories: []);
    }
    try {
      final decoded = jsonDecode(raw) as List<dynamic>?;
      if (decoded == null || decoded.isEmpty) {
        return const ManageCategoriesEntity(categories: []);
      }
      final categories = decoded
          .map((e) {
            final map = Map<String, dynamic>.from(e as Map);
            final id = map['categoryId'] as String?;
            final path = map['iconPath'] as String?;
            if (id == null || path == null) return null;
            return ManagedCategoryEntity(categoryId: id, iconPath: path);
          })
          .whereType<ManagedCategoryEntity>()
          .toList();
      return ManageCategoriesEntity(categories: categories);
    } catch (_) {
      return const ManageCategoriesEntity(categories: []);
    }
  }

  @override
  Future<void> saveCategoriesOrder(ManageCategoriesEntity entity) async {
    final encoded = entity.categories
        .map((e) => {'categoryId': e.categoryId, 'iconPath': e.iconPath})
        .toList();
    await _prefs.setString(_keyCategoriesOrder, jsonEncode(encoded));
  }
}
