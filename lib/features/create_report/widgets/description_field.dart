import 'package:flutter/material.dart';
import 'package:viatux/core/utils/responsive.dart';

class DescriptionField extends StatelessWidget {
  final Function(String) onChanged;

  const DescriptionField({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Descripción',
          style: TextStyle(
            fontSize: resp.sp(16),
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        SizedBox(height: resp.hp(1.5)),
        TextFormField(
          maxLines: 4,
          maxLength: 200,
          onChanged: onChanged,
          style: TextStyle(color: isDark ? Colors.white : Colors.black87),
          decoration: InputDecoration(
            hintText: 'Describe la incidencia...',
            hintStyle: TextStyle(color: isDark ? Colors.grey[500] : Colors.grey[400]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: isDark ? Colors.grey[800] : Colors.grey[100],
            contentPadding: EdgeInsets.all(resp.wp(4)),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor describe la incidencia';
            }
            return null;
          },
        ),
      ],
    );
  }
}