import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class AlertMiniMap extends StatelessWidget {
  const AlertMiniMap({super.key});

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: resp.hp(2)),
        Text(
          'Mapa de riesgos',
          style: TextStyle(
            fontSize: resp.sp(18),
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        SizedBox(height: resp.hp(1.5)),
        Container(
          height: resp.hp(25),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Container(
                  color: isDark ? Colors.grey[800] : Colors.grey[300],
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.map_rounded, size: resp.iconSize(50), color: Colors.grey[500]),
                        Text('Mapa interactivo', style: TextStyle(color: Colors.grey[500])),
                      ],
                    ),
                  ),
                ),
                // Heatmap simulado
                Positioned(
                  top: resp.hp(5),
                  left: resp.wp(10),
                  child: _buildHeatSpot(Colors.red, resp),
                ),
                Positioned(
                  top: resp.hp(12),
                  right: resp.wp(15),
                  child: _buildHeatSpot(Colors.orange, resp),
                ),
                Positioned(
                  bottom: resp.hp(5),
                  left: resp.wp(25),
                  child: _buildHeatSpot(Colors.yellow, resp),
                ),
                // Marcadores
                Positioned(
                  top: resp.hp(8),
                  left: resp.wp(20),
                  child: _buildMarker(Icons.warning_rounded, Colors.red, resp),
                ),
                Positioned(
                  bottom: resp.hp(8),
                  right: resp.wp(20),
                  child: _buildMarker(Icons.water_drop_rounded, Colors.blue, resp),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeatSpot(Color color, Responsive resp) {
    return Container(
      width: resp.wp(20),
      height: resp.wp(20),
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [color.withOpacity(0.6), color.withOpacity(0)],
        ),
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildMarker(IconData icon, Color color, Responsive resp) {
    return Container(
      padding: EdgeInsets.all(resp.wp(2)),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.5),
            blurRadius: 12,
            spreadRadius: 4,
          ),
        ],
      ),
      child: Icon(icon, size: resp.iconSize(16), color: Colors.white),
    );
  }
}