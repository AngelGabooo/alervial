import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class FloatingButtons extends StatelessWidget {
  final VoidCallback onCenter;
  final VoidCallback onHeatmap;
  final VoidCallback onReport;
  final bool showHeatmap;

  const FloatingButtons({
    super.key,
    required this.onCenter,
    required this.onHeatmap,
    required this.onReport,
    required this.showHeatmap,
  });

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;

    return Positioned(
      bottom: resp.hp(8),
      right: resp.wp(4),
      child: Column(
        children: [
          _buildFloatingButton(
            context,
            icon: showHeatmap ? Icons.heat_pump_rounded : Icons.heat_pump_outlined,
            color: showHeatmap ? Colors.green : Colors.white,
            onPressed: onHeatmap,
          ),
          SizedBox(height: resp.hp(1.5)),
          _buildFloatingButton(
            context,
            icon: Icons.my_location_rounded,
            color: Colors.white,
            onPressed: onCenter,
          ),
          SizedBox(height: resp.hp(1.5)),
          _buildFloatingButton(
            context,
            icon: Icons.add_alert_rounded,
            color: Colors.orange,
            onPressed: onReport,
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingButton(BuildContext context, {
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    final resp = context.resp;
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: FloatingActionButton(
        onPressed: onPressed,
        backgroundColor: color,
        mini: true,
        elevation: 0,
        child: Icon(icon, color: color == Colors.white ? AppColors.blueDark : Colors.white),
      ),
    );
  }
}