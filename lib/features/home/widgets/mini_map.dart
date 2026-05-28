import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class MiniMap extends StatelessWidget {
  final VoidCallback onViewMap;

  const MiniMap({
    super.key,
    required this.onViewMap,
  });

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;

    return Padding(
      padding: resp.padding(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          resp.sizedBox(height: 24),
          Text(
            'Mapa rápido',
            style: TextStyle(
              fontSize: resp.sp(18),
              fontWeight: FontWeight.bold,
            ),
          ),
          resp.sizedBox(height: 12),
          GestureDetector(
            onTap: onViewMap,
            child: Container(
              height: resp.hp(24),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: resp.radius(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: resp.radius(20),
                child: Stack(
                  children: [
                    // Simulación de mapa
                    Container(
                      color: Colors.grey[300],
                      child: Center(
                        child: Icon(
                          Icons.map_rounded,
                          size: resp.iconSize(80),
                          color: Colors.grey[400],
                        ),
                      ),
                    ),
                    // Marcadores simulados
                    Positioned(
                      top: resp.hp(8),
                      left: resp.wp(20),
                      child: Container(
                        padding: resp.padding(all: 6),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.red.withOpacity(0.5),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: const Icon(Icons.warning_rounded, size: 12, color: Colors.white),
                      ),
                    ),
                    Positioned(
                      top: resp.hp(12),
                      right: resp.wp(15),
                      child: Container(
                        padding: resp.padding(all: 6),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.5),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: const Icon(Icons.water_drop_rounded, size: 12, color: Colors.white),
                      ),
                    ),
                    Positioned(
                      bottom: resp.hp(4),
                      left: resp.wp(30),
                      child: Container(
                        padding: resp.padding(all: 6),
                        decoration: BoxDecoration(
                          color: AppColors.softGreen,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.softGreen.withOpacity(0.5),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: const Icon(Icons.check_rounded, size: 12, color: Colors.white),
                      ),
                    ),
                    // Botón ver mapa completo
                    Positioned(
                      bottom: resp.hp(2),
                      right: resp.wp(4),
                      child: Container(
                        padding: resp.padding(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: resp.radius(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.fullscreen_rounded, size: resp.iconSize(14), color: AppColors.blueBright),
                            resp.sizedBox(width: 4),
                            Text(
                              'Ver mapa',
                              style: TextStyle(
                                fontSize: resp.sp(11),
                                color: AppColors.blueBright,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
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
}