import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(resp.wp(4)),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Número de folio',
                      style: TextStyle(
                        fontSize: resp.sp(12),
                        color: Colors.white70,
                      ),
                    ),
                    Text(
                      'VIA-2024-001234',
                      style: TextStyle(
                        fontSize: resp.sp(16),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
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
            ],
          ),
          SizedBox(height: resp.hp(2)),
          Divider(color: Colors.white.withOpacity(0.2)),
          SizedBox(height: resp.hp(2)),
          Row(
            children: [
              _buildInfoRow(
                context,
                icon: Icons.category_rounded,
                label: 'Bache',
              ),
              _buildInfoRow(
                context,
                icon: Icons.access_time_rounded,
                label: 'Hoy, 14:30 hrs',
              ),
            ],
          ),
          SizedBox(height: resp.hp(1.5)),
          Row(
            children: [
              _buildInfoRow(
                context,
                icon: Icons.location_on_rounded,
                label: 'Av. Central #123',
              ),
              _buildInfoRow(
                context,
                icon: Icons.warning_rounded,
                label: 'Riesgo Alto',
                valueColor: Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, {
    required IconData icon,
    required String label,
    Color? valueColor,
  }) {
    final resp = context.resp;
    return Expanded(
      child: Row(
        children: [
          Icon(icon, size: resp.iconSize(16), color: Colors.white70),
          SizedBox(width: resp.wp(2)),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: resp.sp(13),
                color: valueColor ?? Colors.white,
                fontWeight: valueColor != null ? FontWeight.w500 : FontWeight.normal,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}