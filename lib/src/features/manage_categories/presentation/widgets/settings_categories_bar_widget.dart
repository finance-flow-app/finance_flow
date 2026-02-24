import 'package:finance_flow/core/generated/assets/assets.gen.dart';
import 'package:flutter/material.dart';

/// Бар с иконками в шапке экрана «Управление категориями»:
/// поиск, добавление категории, меню (троеточие).
/// Размещается в [AppBar.actions] справа от заголовка.
class SettingsCategoriesBarWidget extends StatelessWidget {
  const SettingsCategoriesBarWidget({super.key});

  static const double _iconSize = 22.0;
  static const double _gap = 0.0;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onPrimary;

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _BarIcon(
          onTap: () {},
          icon: Assets.icons.search.svg(
            width: _iconSize,
            height: _iconSize,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          ),
        ),
        SizedBox(width: _gap),
        _BarIcon(
          onTap: () {},
          icon: Assets.icons.add.svg(
            width: _iconSize,
            height: _iconSize,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          ),
        ),
        SizedBox(width: _gap),
        _BarIcon(
          onTap: () {},
          icon: Assets.icons.overflowMenuHorizontal.svg(
            width: _iconSize,
            height: _iconSize,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          ),
        ),
      ],
    );
  }
}

/// Анимация нажатия — только через InkWell (splash/highlight), как в [StickyFooterButtonWidget].
class _BarIcon extends StatelessWidget {
  const _BarIcon({required this.onTap, required this.icon});

  final VoidCallback onTap;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        splashColor: Colors.white.withValues(alpha: 0.25),
        highlightColor: Colors.white.withValues(alpha: 0.12),
        child: Padding(padding: const EdgeInsets.all(12), child: icon),
      ),
    );
  }
}
