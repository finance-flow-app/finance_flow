import 'package:finance_flow/core/theme/app_backgroud.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum DismissStyle { down, right }

final ValueNotifier<DismissStyle> dismissStyle = ValueNotifier<DismissStyle>(
  DismissStyle.down,
);

void setDismissDown() => dismissStyle.value = DismissStyle.down;
void setDismissRight() => dismissStyle.value = DismissStyle.right;

// “iOS-похожие” кривые (без зависимости от версии Flutter)
const Curve _pushCurve = Cubic(0.18, 0.90, 0.22, 1.00); // мягко, долго в конце
const Curve _popDownCurve = Cubic(0.30, 0.00, 0.20, 1.00); // аккуратно вниз
const Curve _popRightCurve = Cubic(0.25, 0.10, 0.25, 1.00); // iOS back-ish

CustomTransitionPage<T> bottomUpPage<T>({
  required LocalKey key,
  required Widget child,
  Duration transitionDuration = const Duration(milliseconds: 250),
  Duration reverseTransitionDuration = const Duration(milliseconds: 200),
}) => CustomTransitionPage<T>(
  key: key,
  child: child,
  transitionDuration: transitionDuration,
  reverseTransitionDuration: reverseTransitionDuration,
  transitionsBuilder: (context, animation, secondaryAnimation, child) {
    final isReverse = animation.status == AnimationStatus.reverse;
    final style = dismissStyle.value;

    final isRightPop = isReverse && style == DismissStyle.right;

    final beginOffset = isReverse
        ? (isRightPop ? const Offset(1, 0) : const Offset(0, 1))
        : const Offset(0, 1);

    // Делаем ощущение “больше кадров внизу”:
    // движение (slide) заканчивается чуть раньше, а последние 6% — “дотяжка/успокоение”.
    final slideAnim = Tween<Offset>(begin: beginOffset, end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: animation,
            curve: const Interval(0.0, 0.94, curve: _pushCurve),
            reverseCurve: Interval(
              0.0,
              0.94,
              curve: isRightPop ? _popRightCurve : _popDownCurve,
            ),
          ),
        );

    // Fade:
    // - при push: лёгкий, быстро заканчивается (не мешает “считать” движение)
    // - при pop down: можно чуть приглушить
    // - при pop right: без fade
    // При push новая страница сразу непрозрачная (1.0), чтобы предыдущая не просвечивала.
    final double fadeBegin = isReverse ? (isRightPop ? 1.0 : 0.94) : 1.0;
    final opacityAnim = Tween<double>(begin: fadeBegin, end: 1.0).animate(
      CurvedAnimation(
        parent: animation,
        curve: isReverse
            ? Interval(
                0.0,
                0.55,
                curve: isRightPop ? Curves.linear : Curves.easeIn,
              )
            : Curves.linear,
        reverseCurve: Interval(
          0.0,
          0.55,
          curve: isRightPop ? Curves.linear : Curves.easeIn,
        ),
      ),
    );

    // Микро-scale очень помогает сгладить визуальный “рывок” на старте.
    final scaleAnim = Tween<double>(begin: 0.995, end: 1.0).animate(
      CurvedAnimation(
        parent: animation,
        curve: const Interval(0.0, 0.70, curve: Curves.easeOutCubic),
        reverseCurve: const Interval(0.0, 0.70, curve: Curves.easeInCubic),
      ),
    );

    // Под новой страницей — тот же фон, что и в приложении (градиент + glow).
    // Так: (1) с первого кадра перекрывается homepage, (2) после анимации
    // фон новой страницы совпадает с главной — без «другой темы».
    return Stack(
      fit: StackFit.expand,
      children: [
        const AppBackground(child: SizedBox.shrink()),
        SlideTransition(
          position: slideAnim,
          child: FadeTransition(
            opacity: opacityAnim,
            child: ScaleTransition(scale: scaleAnim, child: child),
          ),
        ),
      ],
    );
  },
);
