import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';

class PremiumCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final bool isSelected;
  final double elevation;
  final EdgeInsets padding;

  const PremiumCard({
    super.key,
    required this.child,
    this.onTap,
    this.isSelected = false,
    this.elevation = 4,
    this.padding = const EdgeInsets.all(24),
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: _getTransform(),
        child: Card(
          elevation: isSelected ? elevation + 4 : elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: isSelected
                ? BorderSide(color: AppColors.blueBright, width: 2)
                : BorderSide.none,
          ),
          color: isDark ? AppColors.darkSurface : Colors.white,
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: isSelected
                  ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.blueBright.withOpacity(0.1),
                  Colors.transparent,
                ],
              )
                  : null,
            ),
            child: child,
          ),
        ),
      ),
    );
  }

  Matrix4 _getTransform() {
    if (onTap == null) return Matrix4.identity();

    if (isSelected) {
      final Matrix4 matrix = Matrix4.identity();
      matrix.scale(1.02);
      return matrix;
    }

    return Matrix4.identity();
  }
}