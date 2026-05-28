import 'package:flutter/material.dart';
import 'package:viatux/core/utils/responsive.dart';

class ReportPreview extends StatelessWidget {
  final String? photoPath;
  final String? category;
  final String description;

  const ReportPreview({
    super.key,
    required this.photoPath,
    required this.category,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (photoPath == null && category == null && description.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Vista previa',
          style: TextStyle(
            fontSize: resp.sp(16),
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        SizedBox(height: resp.hp(1.5)),
        Container(
          padding: EdgeInsets.all(resp.wp(3)),
          decoration: BoxDecoration(
            color: isDark ? Colors.grey[800] : Colors.grey[100],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              if (photoPath != null)
                Container(
                  width: resp.wp(15),
                  height: resp.wp(15),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.image_outlined),
                ),
              if (photoPath != null) SizedBox(width: resp.wp(3)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (category != null)
                      Text(
                        category!,
                        style: TextStyle(
                          fontSize: resp.sp(14),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    if (description.isNotEmpty)
                      Text(
                        description.length > 50
                            ? '${description.substring(0, 50)}...'
                            : description,
                        style: TextStyle(fontSize: resp.sp(12), color: Colors.grey),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}