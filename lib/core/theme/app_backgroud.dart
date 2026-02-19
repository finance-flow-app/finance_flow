import 'dart:ui';
import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  final Widget child;
  const AppBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      fit: StackFit.expand,
      children: [
        // Base gradient
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: isDark
                  ? const [
                      Color(0xFF05020A), // almost black
                      Color(0xFF12061E), // deep purple
                      Color(0xFF2A0B52), // rich purple
                      Color(0xFF5A1AAE), // purple glow bottom
                    ]
                  : const [
                      Color(0xFFFBF7FF), // off-white lavender
                      Color(0xFFF2ECFF), // lavender
                      Color(0xFFE6F2FF), // pale blue
                      Color(0xFFDCE1FF), // periwinkle
                    ],
              stops: const [0.0, 0.40, 0.72, 1.0],
            ),
          ),
        ),

        // Glow blobs
        _Glow(
          color: isDark ? const Color(0xFFB26DFF) : const Color(0xFF7B3DFF),
          alignment: const Alignment(-0.85, -0.75),
          radius: isDark ? 260 : 240,
          opacity: isDark ? 0.42 : 0.22,
        ),
        _Glow(
          color: isDark ? const Color(0xFFFF4FD8) : const Color(0xFFFF4FBF),
          alignment: const Alignment(0.90, -0.20),
          radius: isDark ? 240 : 220,
          opacity: isDark ? 0.30 : 0.18,
        ),
        _Glow(
          color: isDark ? const Color(0xFF44D7FF) : const Color(0xFF2EC5E8),
          alignment: const Alignment(-0.20, 0.85),
          radius: isDark ? 280 : 260,
          opacity: isDark ? 0.22 : 0.16,
        ),

        // Slight blur layer (makes "glass" feel richer)
        BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: isDark ? 18 : 16,
            sigmaY: isDark ? 18 : 16,
          ),
          child: const SizedBox.shrink(),
        ),

        child,
      ],
    );
  }
}

class _Glow extends StatelessWidget {
  final Color color;
  final Alignment alignment;
  final double radius;
  final double opacity;

  const _Glow({
    required this.color,
    required this.alignment,
    required this.radius,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        width: radius * 2,
        height: radius * 2,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              color.withValues(alpha: opacity),
              color.withValues(alpha: 0),
            ],
          ),
        ),
      ),
    );
  }
}
