import 'package:flutter/material.dart';

/// Контейнер для StatefulShellRoute: при переключении между ветками
/// уходящая страница уезжает вниз, новая появляется сверху (iOS-like),
/// при этом старая НЕ просвечивает сквозь новую.
class BranchTransitionContainer extends StatefulWidget {
  const BranchTransitionContainer({
    super.key,
    required this.currentIndex,
    required this.children,
    this.duration = const Duration(milliseconds: 200),
  });

  final int currentIndex;
  final List<Widget> children;
  final Duration duration;

  @override
  State<BranchTransitionContainer> createState() =>
      _BranchTransitionContainerState();
}

class _BranchTransitionContainerState extends State<BranchTransitionContainer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  int _previousIndex = 0;
  int _currentIndex = 0;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
    _previousIndex = _currentIndex;
    _controller = AnimationController(vsync: this, duration: widget.duration);
  }

  @override
  void didUpdateWidget(covariant BranchTransitionContainer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.currentIndex != widget.currentIndex && !_isAnimating) {
      setState(() {
        _previousIndex = _currentIndex;
        _currentIndex = widget.currentIndex;
        _isAnimating = true;
      });

      _controller.forward(from: 0).whenComplete(() {
        if (!mounted) return;
        setState(() {
          _isAnimating = false;
          _previousIndex = _currentIndex;
        });
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final activeIndex = widget.currentIndex;

    // Текущую (входящую) рисуем поверх.
    final indices = [for (int i = 0; i < widget.children.length; i++) i]
      ..sort((a, b) {
        if (a == activeIndex) return 1;
        if (b == activeIndex) return -1;
        return a.compareTo(b);
      });

    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;

        return AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            final t = Curves.easeInOutCubic.transform(_controller.value);

            return Stack(
              clipBehavior: Clip.hardEdge, // важно: ничего “вне экрана”
              children: [
                for (final index in indices)
                  Positioned.fill(
                    child: Offstage(
                      // Держим живыми все навигаторы, но рисуем только:
                      // текущий и (во время анимации) уходящий.
                      offstage:
                          !(index == _currentIndex ||
                              (_isAnimating && index == _previousIndex)),
                      child: _BranchLayer(
                        index: index,
                        previousIndex: _previousIndex,
                        currentIndex: _currentIndex,
                        isAnimating: _isAnimating,
                        t: t,
                        layoutHeight: height,
                        child: _branchNavigatorWrapper(
                          index == activeIndex,
                          widget.children[index],
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _branchNavigatorWrapper(bool isActive, Widget navigator) {
    // Важно: только активная ветка интерактивна и "тикает".
    return IgnorePointer(
      ignoring: !isActive,
      child: TickerMode(
        enabled: isActive,
        child: RepaintBoundary(child: navigator),
      ),
    );
  }
}

class _BranchLayer extends StatelessWidget {
  const _BranchLayer({
    required this.index,
    required this.previousIndex,
    required this.currentIndex,
    required this.isAnimating,
    required this.t,
    required this.layoutHeight,
    required this.child,
  });

  final int index;
  final int previousIndex;
  final int currentIndex;
  final bool isAnimating;
  final double t;
  final double layoutHeight;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isLeaving = isAnimating && index == previousIndex;
    final isEntering = isAnimating && index == currentIndex;

    double offsetYPx = 0;

    // Входящая ветка: чуть сверху вниз.
    // Уходящая: вниз до конца.
    if (isLeaving) {
      offsetYPx = t * layoutHeight;
    } else if (isEntering) {
      offsetYPx = -0.10 * layoutHeight * (1 - t);
    }

    // Уходящую ветку делаем полностью невидимой с первого кадра,
    // чтобы текст/контент предыдущей страницы не давал артефактов у навбара.
    final leavingOpacity = 0.0;
    final enteringContentOpacity = (0.0 + 1.0 * t).clamp(0.0, 1.0);

    final bgColor = Theme.of(context).scaffoldBackgroundColor;

    Widget composed;
    if (isEntering) {
      // Опаковый фон перекрывает всё под собой, поверх — контент входящей ветки.
      composed = Stack(
        fit: StackFit.expand,
        children: [
          ColoredBox(color: bgColor),
          Opacity(opacity: enteringContentOpacity, child: child),
        ],
      );
    } else if (isLeaving) {
      composed = Opacity(opacity: leavingOpacity, child: child);
    } else {
      composed = child;
    }

    return Transform.translate(offset: Offset(0, offsetYPx), child: composed);
  }
}
