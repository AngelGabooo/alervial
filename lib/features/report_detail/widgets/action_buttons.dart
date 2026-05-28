import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                context,
                icon: Icons.add_photo_alternate_rounded,
                label: 'Agregar evidencia',
                onPressed: () {},
              ),
            ),
            SizedBox(width: resp.wp(3)),
            Expanded(
              child: _buildActionButton(
                context,
                icon: Icons.share_rounded,
                label: 'Compartir',
                onPressed: () {},
              ),
            ),
          ],
        ),
        SizedBox(height: resp.hp(1.5)),
        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                context,
                icon: Icons.bookmark_add_rounded,
                label: 'Guardar',
                onPressed: () {},
              ),
            ),
            SizedBox(width: resp.wp(3)),
            Expanded(
              child: _buildActionButton(
                context,
                icon: Icons.update_rounded,
                label: 'Reportar actualización',
                onPressed: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: resp.iconSize(18)),
      label: Text(label, style: TextStyle(fontSize: resp.sp(12))),
      style: OutlinedButton.styleFrom(
        foregroundColor: isDark ? Colors.white : AppColors.blueDark,
        padding: EdgeInsets.symmetric(vertical: resp.hp(1.2)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        side: BorderSide(color: isDark ? Colors.grey[600]! : Colors.grey[300]!),
      ),
    );
  }
}