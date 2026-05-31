import 'package:flutter/material.dart';
import 'package:viatux/core/utils/responsive.dart';

class RiskMap extends StatelessWidget {
  final bool showHeatmap;

  const RiskMap({super.key, required this.showHeatmap});

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: isDark ? Colors.grey[900] : Colors.grey[300],
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.map_rounded, size: resp.iconSize(80), color: Colors.grey[500]),
                Text('Mapa interactivo', style: TextStyle(color: Colors.grey[500])),
              ],
            ),
          ),
          if (showHeatmap) ...[
            _buildHeatSpot(context, 0.3, 0.2, Colors.red, 80),
            _buildHeatSpot(context, 0.5, 0.5, Colors.orange, 60),
            _buildHeatSpot(context, 0.7, 0.3, Colors.red, 70),
            _buildHeatSpot(context, 0.2, 0.7, Colors.orange, 50),
            _buildHeatSpot(context, 0.8, 0.7, Colors.green, 40),
          ],
          Positioned(
            top: resp.hp(25),
            left: resp.wp(20),
            child: _buildMarker(Icons.warning_rounded, Colors.red),
          ),
          Positioned(
            top: resp.hp(45),
            right: resp.wp(15),
            child: _buildMarker(Icons.warning_rounded, Colors.orange),
          ),
        ],
      ),
    );
  }

  Widget _buildHeatSpot(BuildContext context, double x, double y, Color color, double size) {
    final resp = context.resp;
    return Positioned(
      top: resp.hp(y * 80),
      left: resp.wp(x * 80),
      child: Container(
        width: resp.wp(size),
        height: resp.wp(size),
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [color.withOpacity(0.6), color.withOpacity(0)],
          ),
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _buildMarker(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: color.withOpacity(0.5), blurRadius: 12, spreadRadius: 4),
        ],
      ),
      child: Icon(icon, size: 20, color: Colors.white),
    );
  }
}