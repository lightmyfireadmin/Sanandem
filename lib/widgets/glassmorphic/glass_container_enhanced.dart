import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/ui_preferences.dart';

class GlassContainerEnhanced extends ConsumerWidget {
  final double? width;
  final double? height;
  final BorderRadiusGeometry borderRadius;
  final BoxBorder? border;
  final Color color;
  final Widget child;

  const GlassContainerEnhanced({
    Key? key,
    this.width,
    this.height,
    this.borderRadius = BorderRadius.zero,
    this.border,
    required this.color,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLowPerf = ref.watch(uiPreferencesProvider).isLowPerformanceMode;

    if (isLowPerf) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color.withOpacity(0.95), // Fallback for glass
          borderRadius: borderRadius,
          border: border,
        ),
        child: child,
      );
    }

    // Existing heavy glass implementation
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: border,
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
          child: Container(
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: borderRadius,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
