import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key});

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: EdgeInsets.symmetric(horizontal: resp.wp(5), vertical: resp.hp(0.5)),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: resp.wp(5)),
        child: const Icon(Icons.delete_rounded, color: Colors.white),
      ),
      onDismissed: (direction) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Notificación eliminada')),
        );
      },
      child: Padding(
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
                    color: Colors.blue.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.assignment_rounded, color: Colors.blue, size: resp.iconSize(24)),
                ),
                SizedBox(width: resp.wp(3)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Reporte actualizado',
                            style: TextStyle(
                              fontSize: resp.sp(14),
                              fontWeight: FontWeight.w600,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            'Hace 5 min',
                            style: TextStyle(
                              fontSize: resp.sp(11),
                              color: isDark ? Colors.grey[500] : Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: resp.hp(0.5)),
                      Text(
                        'Tu reporte #VIA-001234 ha sido actualizado a "En proceso".',
                        style: TextStyle(
                          fontSize: resp.sp(12),
                          color: isDark ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: resp.hp(0.5)),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: resp.wp(2),
                              vertical: resp.hp(0.3),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'Actualización',
                              style: TextStyle(
                                fontSize: resp.sp(10),
                                color: Colors.blue,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(width: resp.wp(2)),
                          Icon(Icons.circle, size: resp.iconSize(6), color: Colors.blue),
                          SizedBox(width: resp.wp(2)),
                          Text(
                            'Importante',
                            style: TextStyle(
                              fontSize: resp.sp(10),
                              color: isDark ? Colors.grey[500] : Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}