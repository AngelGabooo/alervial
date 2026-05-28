import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class ActivityCard extends StatelessWidget {
  const ActivityCard({super.key});

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
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: resp.wp(20),
                  height: resp.wp(20),
                  color: isDark ? Colors.grey[800] : Colors.grey[200],
                  child: const Icon(Icons.image_outlined),
                ),
              ),
              SizedBox(width: resp.wp(4)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: resp.wp(2),
                            vertical: resp.hp(0.3),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Bache',
                            style: TextStyle(
                              fontSize: resp.sp(11),
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          'Hace 2 horas',
                          style: TextStyle(
                            fontSize: resp.sp(11),
                            color: isDark ? Colors.grey[500] : Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: resp.hp(0.5)),
                    Text(
                      'Bache profundo en Av. Central',
                      style: TextStyle(
                        fontSize: resp.sp(14),
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: resp.hp(0.5)),
                    Row(
                      children: [
                        Icon(Icons.location_on_rounded, size: resp.iconSize(12), color: Colors.grey),
                        SizedBox(width: resp.wp(1)),
                        Expanded(
                          child: Text(
                            'Tuxtla Gutiérrez, Chiapas',
                            style: TextStyle(fontSize: resp.sp(11), color: Colors.grey),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: resp.hp(1)),
                    Row(
                      children: [
                        _buildActionButton(context, Icons.visibility_rounded, 'Ver'),
                        SizedBox(width: resp.wp(4)),
                        _buildActionButton(context, Icons.share_rounded, 'Compartir'),
                        SizedBox(width: resp.wp(4)),
                        _buildActionButton(context, Icons.bookmark_border_rounded, 'Guardar'),
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

  Widget _buildActionButton(BuildContext context, IconData icon, String label) {
    final resp = context.resp;
    return GestureDetector(
      onTap: () {},
      child: Row(
        children: [
          Icon(icon, size: resp.iconSize(16), color: AppColors.blueBright),
          SizedBox(width: resp.wp(1)),
          Text(label, style: TextStyle(fontSize: resp.sp(11), color: AppColors.blueBright)),
        ],
      ),
    );
  }
}