import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../core/utils/responsive.dart';

class WelcomeIllustration extends StatelessWidget {
  const WelcomeIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Tamaños responsivos basados en altura de pantalla
    final illustrationHeight = resp.hp(28); // 28% de la altura
    final phoneWidth = resp.wp(28); // 28% del ancho
    final phoneHeight = resp.hp(18); // 18% de la altura

    return Container(
      height: illustrationHeight.clamp(180.0, 280.0),
      margin: resp.padding(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: resp.radius(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.blueBright.withOpacity(0.1),
            AppColors.blueBright.withOpacity(0.05),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Mapa de fondo
          Center(
            child: Icon(
              Icons.map_rounded,
              size: resp.iconSize(140),
              color: AppColors.blueBright.withOpacity(0.3),
            ),
          ),
          // Marcadores de ubicación
          Positioned(
            top: resp.hp(5),
            left: resp.wp(8),
            child: _buildMarker(context, Icons.location_on_rounded, AppColors.softGreen),
          ),
          Positioned(
            top: resp.hp(12),
            right: resp.wp(10),
            child: _buildMarker(context, Icons.warning_rounded, Colors.orange),
          ),
          Positioned(
            bottom: resp.hp(6),
            left: resp.wp(10),
            child: _buildMarker(context, Icons.construction_rounded, Colors.red),
          ),
          // Smartphone con mapa
          Center(
            child: Container(
              width: phoneWidth.clamp(100.0, 140.0),
              height: phoneHeight.clamp(150.0, 200.0),
              decoration: BoxDecoration(
                color: isDark ? Colors.black87 : Colors.white,
                borderRadius: resp.radius(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: resp.radius(20),
                child: Column(
                  children: [
                    Container(
                      height: resp.hp(4),
                      color: AppColors.blueBright,
                      child: Center(
                        child: Text(
                          'Mapa',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: resp.sp(10),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: AppColors.blueBright.withOpacity(0.2),
                        child: Icon(
                          Icons.gps_fixed_rounded,
                          size: resp.iconSize(35),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarker(BuildContext context, IconData icon, Color color) {
    final resp = context.resp;
    return Container(
      padding: resp.padding(all: 6),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Icon(
        icon,
        size: resp.iconSize(16),
        color: Colors.white,
      ),
    );
  }
}