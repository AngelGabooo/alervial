import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class AlertListCard extends StatelessWidget {
  const AlertListCard({super.key});

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: resp.wp(5), vertical: resp.hp(0.5)),
      child: Card(
        elevation: 0,
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: EdgeInsets.all(resp.wp(3)),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(resp.wp(2.5)),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.water_drop_rounded, color: Colors.orange, size: resp.iconSize(24)),
              ),
              SizedBox(width: resp.wp(3)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Inundación en Calle 5',
                          style: TextStyle(
                            fontSize: resp.sp(14),
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          'Hace 15 min',
                          style: TextStyle(
                            fontSize: resp.sp(11),
                            color: isDark ? Colors.grey[500] : Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: resp.hp(0.5)),
                    Row(
                      children: [
                        Icon(Icons.location_on_rounded, size: resp.iconSize(12), color: Colors.grey),
                        SizedBox(width: resp.wp(1)),
                        Expanded(
                          child: Text(
                            'Tuxtla Gutiérrez',
                            style: TextStyle(fontSize: resp.sp(11), color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: resp.hp(1)),
                    Row(
                      children: [
                        _buildActionButton(context, 'Evitar', AppColors.blueBright),
                        SizedBox(width: resp.wp(3)),
                        _buildActionButton(context, 'Ver ruta', Colors.grey),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, String label, Color color) {
    final resp = context.resp;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: resp.wp(3), vertical: resp.hp(0.5)),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: resp.sp(11), color: color, fontWeight: FontWeight.w500),
      ),
    );
  }
}