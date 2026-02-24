import 'package:easy_localization/easy_localization.dart';
import 'package:finance_flow/core/assets/app_fonts.dart';
import 'package:finance_flow/core/generated/assets/assets.gen.dart';
import 'package:finance_flow/core/generated/localization/locale_keys.g.dart';
import 'package:finance_flow/src/features/manage_categories/domain/entity/manage_categories_entity.dart';
import 'package:flutter/material.dart';

/// Категория в списке управления (локальный enum, без зависимости от других фич).
enum CategoryItemKind {
  food,
  restaurant,
  taxi,
  transport,
  shopping,
  bills,
  education,
  health,
  entertainment,
  internet,
  other,
}

extension CategoryItemKindExtension on CategoryItemKind {
  Widget icon({double size = 20, Color? color}) {
    final svg = switch (this) {
      CategoryItemKind.food => Assets.icons.apple,
      CategoryItemKind.restaurant => Assets.icons.restaurant,
      CategoryItemKind.taxi => Assets.icons.taxi,
      CategoryItemKind.transport => Assets.icons.train,
      CategoryItemKind.shopping => Assets.icons.shoppingCart,
      CategoryItemKind.bills => Assets.icons.catalog,
      CategoryItemKind.education => Assets.icons.education,
      CategoryItemKind.health => Assets.icons.healthCross,
      CategoryItemKind.entertainment => Assets.icons.faceSatisfied,
      CategoryItemKind.internet => Assets.icons.wifi,
      CategoryItemKind.other => Assets.icons.filter,
    };
    return svg.svg(
      width: size,
      height: size,
      colorFilter: color != null
          ? ColorFilter.mode(color, BlendMode.srcIn)
          : null,
    );
  }

  String get localeKey => switch (this) {
    CategoryItemKind.food => LocaleKeys.categories_food,
    CategoryItemKind.restaurant => LocaleKeys.categories_restaurants,
    CategoryItemKind.taxi => LocaleKeys.categories_taxi,
    CategoryItemKind.transport => LocaleKeys.categories_transport,
    CategoryItemKind.shopping => LocaleKeys.categories_shopping,
    CategoryItemKind.bills => LocaleKeys.categories_bills,
    CategoryItemKind.education => LocaleKeys.categories_education,
    CategoryItemKind.health => LocaleKeys.categories_health,
    CategoryItemKind.entertainment => LocaleKeys.categories_entertainment,
    CategoryItemKind.internet => LocaleKeys.categories_internet,
    CategoryItemKind.other => LocaleKeys.categories_other_category,
  };

  /// Путь к иконке в assets (flutter_gen). Для передачи в entity/репозиторий.
  String get iconPath => switch (this) {
    CategoryItemKind.food => Assets.icons.apple.path,
    CategoryItemKind.restaurant => Assets.icons.restaurant.path,
    CategoryItemKind.taxi => Assets.icons.taxi.path,
    CategoryItemKind.transport => Assets.icons.train.path,
    CategoryItemKind.shopping => Assets.icons.shoppingCart.path,
    CategoryItemKind.bills => Assets.icons.catalog.path,
    CategoryItemKind.education => Assets.icons.education.path,
    CategoryItemKind.health => Assets.icons.healthCross.path,
    CategoryItemKind.entertainment => Assets.icons.faceSatisfied.path,
    CategoryItemKind.internet => Assets.icons.wifi.path,
    CategoryItemKind.other => Assets.icons.filter.path,
  };
}

/// Дефолтный порядок категорий для передачи в bloc → entity → repository.
/// Единственный источник правды: CategoryItemKind + flutter_gen (iconPath) + локали (localeKey).
ManageCategoriesEntity getDefaultCategoriesOrder() {
  return ManageCategoriesEntity(
    categories: CategoryItemKind.values
        .map(
          (c) =>
              ManagedCategoryEntity(categoryId: c.name, iconPath: c.iconPath),
        )
        .toList(),
  );
}

/// Элемент списка категорий для экрана управления.
class ManageCategoryItem {
  const ManageCategoryItem({
    required this.category,
    required this.amount,
    required this.transactionCount,
    this.isAuto = false,
  });

  final CategoryItemKind category;
  final double amount;
  final int transactionCount;
  final bool isAuto;
}

/// Цвета круглого токена по категориям (для визуального отличия).
const Map<CategoryItemKind, Color> _kCategoryTokenColors = {
  CategoryItemKind.food: Color(0xFF4CAF50),
  CategoryItemKind.restaurant: Color(0xFF8BC34A),
  CategoryItemKind.taxi: Color(0xFF9C27B0),
  CategoryItemKind.transport: Color(0xFF673AB7),
  CategoryItemKind.shopping: Color(0xFF607D8B),
  CategoryItemKind.bills: Color(0xFF2196F3),
  CategoryItemKind.education: Color(0xFFFF9800),
  CategoryItemKind.health: Color(0xFFE91E63),
  CategoryItemKind.entertainment: Color(0xFF00BCD4),
  CategoryItemKind.internet: Color(0xFF3F51B5),
  CategoryItemKind.other: Color(0xFF795548),
};

/// Список категорий: круглый токен с иконкой, название, метрика, Auto pill, иконка reorder.
/// Порядок можно менять перетаскиванием за иконку reorder (удержание + перетаскивание).
/// [categoriesOrder] из bloc → entity; при изменении порядка вызывается [onOrderChanged].
class CategoryListWidget extends StatefulWidget {
  const CategoryListWidget({
    super.key,
    this.items,
    this.currencySymbol,
    this.categoriesOrder,
    this.onOrderChanged,
  });

  /// Список категорий. Если null — показываются все категории с нулевыми метриками.
  final List<ManageCategoryItem>? items;

  /// Символ валюты (например \$ или ₽). Если null — по локали: RUB / USD.
  final String? currencySymbol;

  /// Сохранённый порядок из bloc (entity). Используется для начальной отрисовки.
  final ManageCategoriesEntity? categoriesOrder;

  /// Вызывается при изменении порядка (перетаскивание). Передаёт entity в bloc для сохранения.
  final void Function(ManageCategoriesEntity)? onOrderChanged;

  @override
  State<CategoryListWidget> createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends State<CategoryListWidget> {
  static const List<CategoryItemKind> _allCategories = CategoryItemKind.values;

  late List<ManageCategoryItem> _orderedItems;
  bool _hasAppliedOrderFromBloc = false;

  List<ManageCategoryItem> _fromEntity(ManageCategoriesEntity entity) {
    return entity.categories
        .map((e) {
          try {
            final kind = CategoryItemKind.values.firstWhere(
              (c) => c.name == e.categoryId,
            );
            return ManageCategoryItem(
              category: kind,
              amount: 0,
              transactionCount: 0,
              isAuto:
                  kind == CategoryItemKind.transport ||
                  kind == CategoryItemKind.bills,
            );
          } catch (_) {
            return null;
          }
        })
        .whereType<ManageCategoryItem>()
        .toList();
  }

  List<ManageCategoryItem> _resolveInitialItems(BuildContext context) {
    if (widget.items != null && widget.items!.isNotEmpty) {
      return List<ManageCategoryItem>.from(widget.items!);
    }
    return _allCategories
        .map(
          (c) => ManageCategoryItem(
            category: c,
            amount: 0,
            transactionCount: 0,
            isAuto:
                c == CategoryItemKind.transport || c == CategoryItemKind.bills,
          ),
        )
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _orderedItems = [];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _applyCategoriesOrderFromBloc();
  }

  @override
  void didUpdateWidget(covariant CategoryListWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.categoriesOrder != oldWidget.categoriesOrder &&
        widget.categoriesOrder != null &&
        widget.categoriesOrder!.categories.isNotEmpty) {
      _orderedItems = _fromEntity(widget.categoriesOrder!);
    }
    _applyCategoriesOrderFromBloc();
  }

  void _applyCategoriesOrderFromBloc() {
    if (widget.categoriesOrder != null &&
        widget.categoriesOrder!.categories.isNotEmpty &&
        !_hasAppliedOrderFromBloc) {
      _orderedItems = _fromEntity(widget.categoriesOrder!);
      _hasAppliedOrderFromBloc = true;
    } else if (_orderedItems.isEmpty) {
      _orderedItems = _resolveInitialItems(context);
    }
  }

  String _currency(BuildContext context) {
    return widget.currencySymbol ??
        (context.locale.languageCode == 'ru' ? 'RUB' : 'USD');
  }

  /// Единый формат подзаголовка: "$348 • 24 tx".
  String _subtitle(ManageCategoryItem item, String currency) {
    final amountStr = item.amount == item.amount.roundToDouble()
        ? item.amount.toInt().toString()
        : item.amount.toStringAsFixed(2);
    return '$amountStr $currency • ${item.transactionCount} tx';
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (oldIndex < newIndex) newIndex -= 1;
      final item = _orderedItems.removeAt(oldIndex);
      _orderedItems.insert(newIndex, item);
    });
    widget.onOrderChanged?.call(
      ManageCategoriesEntity(
        categories: _orderedItems
            .map(
              (item) => ManagedCategoryEntity(
                categoryId: item.category.name,
                iconPath: item.category.iconPath,
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currency = _currency(context);
    final colorScheme = Theme.of(context).colorScheme;

    return ReorderableListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      buildDefaultDragHandles: false,
      itemCount: _orderedItems.length,
      onReorder: _onReorder,
      itemBuilder: (context, index) {
        final item = _orderedItems[index];
        return _CategoryListTile(
          key: ValueKey(item.category),
          index: index,
          item: item,
          subtitle: _subtitle(item, currency),
          colorScheme: colorScheme,
        );
      },
    );
  }
}

class _CategoryListTile extends StatelessWidget {
  const _CategoryListTile({
    super.key,
    required this.index,
    required this.item,
    required this.subtitle,
    required this.colorScheme,
  });

  final int index;
  final ManageCategoryItem item;
  final String subtitle;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    final tokenColor =
        _kCategoryTokenColors[item.category] ?? colorScheme.primaryContainer;
    final onTokenColor = _kCategoryTokenColors.containsKey(item.category)
        ? Colors.white
        : colorScheme.onPrimaryContainer;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Круглый цветной токен с иконкой
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: tokenColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: item.category.icon(size: 20, color: onTokenColor),
            ),
          ),
          const SizedBox(width: 12),
          // Название и подзаголовок
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item.category.localeKey.tr(),
                  style: AppFonts.b5s14medium.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: AppFonts.b4s12regular.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Auto pill (если есть)
          if (item.isAuto) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: colorScheme.outline.withValues(alpha: 0.3),
                ),
              ),
              child: Text(
                LocaleKeys.manage_categories_tabs_auto.tr(),
                style: AppFonts.b4s12regular.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
          // Ручка перетаскивания: удержание на иконке reorder позволяет менять порядок
          ReorderableDragStartListener(
            index: index,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Assets.icons.menu.svg(
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  colorScheme.onSurfaceVariant,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
