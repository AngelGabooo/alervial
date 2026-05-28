import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class LocationPicker extends StatelessWidget {
  const LocationPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ubicación',
          style: TextStyle(
            fontSize: resp.sp(16),
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        SizedBox(height: resp.hp(1.5)),
        Container(
          height: resp.hp(20),
          width: double.infinity,
          decoration: BoxDecoration(
            color: isDark ? Colors.grey[800] : Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.map_rounded, size: resp.iconSize(50), color: Colors.grey[500]),
                    Text('Mapa interactivo', style: TextStyle(color: Colors.grey[500])),
                  ],
                ),
              ),
              Positioned(
                bottom: resp.hp(2),
                right: resp.wp(4),
                child: Container(
                  padding: EdgeInsets.all(resp.wp(2)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8),
                    ],
                  ),
                  child: Icon(Icons.my_location_rounded, color: AppColors.blueBright),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: resp.hp(1)),
        Container(
          padding: EdgeInsets.all(resp.wp(3)),
          decoration: BoxDecoration(
            color: AppColors.blueBright.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Icon(Icons.gps_fixed_rounded, size: resp.iconSize(18), color: AppColors.blueBright),
              SizedBox(width: resp.wp(3)),
              Expanded(
                child: Text(
                  'Av. Central #123, Tuxtla Gutiérrez',
                  style: TextStyle(fontSize: resp.sp(13), color: AppColors.blueBright),
                ),
              ),
              Icon(Icons.edit_rounded, size: resp.iconSize(18), color: AppColors.blueBright),
            ],
          ),
        ),
      ],
    );
  }
}