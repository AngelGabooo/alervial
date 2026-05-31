import 'package:flutter/material.dart';
import 'package:viatux/core/utils/responsive.dart';

class LoadingMessage extends StatelessWidget {
  final String message;
  final bool isDark;

  const LoadingMessage({
    super.key,
    required this.message,
    this.isDark = true,
  });

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;

    return Column(
      children: [
        Text(
          message,
          style: TextStyle(
            fontSize: resp.sp(16),
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Por favor espera un momento',
          style: TextStyle(
            fontSize: resp.sp(12),
            color: isDark ? Colors.white70 : Colors.grey[600],
          ),
        ),
      ],
    );
  }
}