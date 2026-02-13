import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Creates a page with iOS-style transition:
/// - Push: slides up from bottom
/// - Pop: slides out to the right
CustomTransitionPage<T> bottomUpPage<T>({
  required LocalKey key,
  required Widget child,
  Duration transitionDuration = const Duration(milliseconds: 300),
  Duration reverseTransitionDuration = const Duration(milliseconds: 300),
}) => CustomTransitionPage<T>(
  key: key,
  child: child,
  transitionDuration: transitionDuration,
  reverseTransitionDuration: reverseTransitionDuration,
  transitionsBuilder: (context, animation, secondaryAnimation, child) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final isReverse = animation.status == AnimationStatus.reverse;
        final offsetTween = Tween<Offset>(
          begin: isReverse ? const Offset(1, 0) : const Offset(0, 1),
          end: Offset.zero,
        );
        return SlideTransition(
          position: offsetTween.animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
              reverseCurve: Curves.easeInCubic,
            ),
          ),
          child: child,
        );
      },
      child: child,
    );
  },
);
