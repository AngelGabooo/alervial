import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class LocationCard extends StatelessWidget {
  const LocationCard({super.key});

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.all(resp.wp(5)),
      child: Container(
        padding: EdgeInsets.all(resp.wp(4)),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.blueBright.withOpacity(0.9),
              AppColors.blueDark.withOpacity(0.9),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.blueBright.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(resp.wp(2.5)),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.location_on_rounded, color: Colors.white, size: resp.iconSize(24)),
            ),
            SizedBox(width: resp.wp(4)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tu ubicación actual',
                    style: TextStyle(fontSize: resp.sp(12), color: Colors.white70),
                  ),
                  Text(
                    'Tuxtla Gutiérrez, Chiapas',
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
              padding: EdgeInsets.symmetric(horizontal: resp.wp(3), vertical: resp.hp(0.8)),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Text(
                    '12',
                    style: TextStyle(fontSize: resp.sp(20), fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text('cercanas', style: TextStyle(fontSize: resp.sp(10), color: Colors.white70)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}