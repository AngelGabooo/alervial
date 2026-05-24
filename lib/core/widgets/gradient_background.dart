import 'package:flutter/material.dart';

import '../constants/colors.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;
  final bool hasPattern;

  const GradientBackground({
    super.key,
    required this.child,
    this.hasPattern = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.splashGradient,
      ),
      child: Stack(
        children: [
          if (hasPattern) _buildPattern(),
          child,
        ],
      ),
    );
  }

  Widget _buildPattern() {
    return Opacity(
      opacity: 0.05,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://www.transparenttextures.com/patterns/asfalt-light.png'),
            repeat: ImageRepeat.repeat,
          ),
        ),
      ),
    );
  }
}