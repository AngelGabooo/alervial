import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class InfoSection extends StatelessWidget {
  const InfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: resp.wp(3),
                vertical: resp.hp(0.5),
              ),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Pendiente',
                style: TextStyle(
                  fontSize: resp.sp(12),
                  color: Colors.orange,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(width: resp.wp(2)),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: resp.wp(3),
                vertical: resp.hp(0.5),
              ),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Riesgo Alto',
                style: TextStyle(
                  fontSize: resp.sp(12),
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: resp.hp(2)),
        _buildInfoRow(context, 'Folio', 'VIA-2024-001234'),
        SizedBox(height: resp.hp(1.5)),
        _buildInfoRow(context, 'Fecha', '15 de mayo, 2024 - 14:30 hrs'),
        SizedBox(height: resp.hp(1.5)),
        _buildInfoRow(context, 'Dirección', 'Av. Central #123, Tuxtla Gutiérrez'),
        SizedBox(height: resp.hp(1.5)),
        _buildInfoRow(context, 'Municipio', 'Tuxtla Gutiérrez'),
        SizedBox(height: resp.hp(1.5)),
        _buildInfoRow(context, 'Prioridad', 'Alta', valueColor: Colors.red),
      ],
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value, {Color? valueColor}) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: resp.wp(25),
          child: Text(
            label,
            style: TextStyle(
              fontSize: resp.sp(14),
              color: isDark ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: resp.sp(14),
              fontWeight: FontWeight.w500,
              color: valueColor ?? (isDark ? Colors.white : Colors.black87),
            ),
          ),
        ),
      ],
    );
  }
}