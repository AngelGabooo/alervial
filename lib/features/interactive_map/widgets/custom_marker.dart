import 'package:flutter/material.dart';
import 'package:viatux/core/utils/responsive.dart';

class CustomMarker extends StatelessWidget {
  final IconData icon;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;
  final String? label;

  const CustomMarker({
    super.key,
    required this.icon,
    required this.color,
    required this.onTap,
    this.isSelected = false,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),

        // Animación de escala
        transform: isSelected
            ? (Matrix4.identity()..scale(1.2))
            : Matrix4.identity(),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(
                resp.wp(isSelected ? 3 : 2.5),
              ),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,

                border: isSelected
                    ? Border.all(
                  color: Colors.white,
                  width: 2,
                )
                    : null,

                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.5),
                    blurRadius: isSelected ? 16 : 12,
                    spreadRadius: isSelected ? 4 : 2,
                  ),
                ],
              ),

              child: Icon(
                icon,
                size: resp.iconSize(
                  isSelected ? 22 : 18,
                ),
                color: Colors.white,
              ),
            ),

            if (label != null) ...[
              SizedBox(
                height: resp.hp(0.5),
              ),

              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: resp.wp(2),
                  vertical: resp.hp(0.3),
                ),

                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(12),
                ),

                child: Text(
                  label!,
                  style: TextStyle(
                    fontSize: resp.sp(10),
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ==========================
// TIPOS DE MARCADORES
// ==========================

class MarkerType {
  static const bache = MarkerData(
    icon: Icons.circle_outlined,
    color: Colors.red,
    label: 'Bache',
  );

  static const derrumbe = MarkerData(
    icon: Icons.landslide_rounded,
    color: Colors.orange,
    label: 'Derrumbe',
  );

  static const inundacion = MarkerData(
    icon: Icons.water_drop_rounded,
    color: Colors.blue,
    label: 'Inundación',
  );

  static const senalizacion = MarkerData(
    icon: Icons.signpost_rounded,
    color: Colors.purple,
    label: 'Señalización',
  );

  static const accidente = MarkerData(
    icon: Icons.car_crash_rounded,
    color: Colors.red,
    label: 'Accidente',
  );
}

// ==========================
// MODELO DE DATOS
// ==========================

class MarkerData {
  final IconData icon;
  final Color color;
  final String label;

  const MarkerData({
    required this.icon,
    required this.color,
    required this.label,
  });
}