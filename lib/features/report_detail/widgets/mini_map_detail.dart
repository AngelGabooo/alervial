import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class MiniMapDetail extends StatelessWidget {
  const MiniMapDetail({super.key});

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
                        Text('Google Maps View', style: TextStyle(color: Colors.grey[500])),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: resp.hp(2),
                  right: resp.wp(4),
                  child: Container(
                    padding: EdgeInsets.all(resp.wp(2)),
                    decoration: BoxDecoration(
                      color: AppColors.blueBright,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.blueBright.withOpacity(0.3),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Icon(Icons.my_location_rounded, color: Colors.white, size: resp.iconSize(18)),
                  ),
                ),
                Positioned(
                  top: resp.hp(10),
                  left: resp.wp(30),
                  child: Container(
                    padding: EdgeInsets.all(resp.wp(1.5)),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: Colors.red.withOpacity(0.5), blurRadius: 8),
                      ],
                    ),
                    child: Icon(Icons.warning_rounded, size: resp.iconSize(14), color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}