import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class EmptyNotifications extends StatelessWidget {
  final VoidCallback onRefresh;

  const EmptyNotifications({super.key, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.all(resp.wp(10)),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(resp.wp(8)),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[800] : Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.notifications_none_rounded,
              size: resp.iconSize(60),
              color: isDark ? Colors.grey[600] : Colors.grey[400],
            ),
          ),
          SizedBox(height: resp.hp(3)),
          Text(
            'No tienes notificaciones nuevas',
            style: TextStyle(
              fontSize: resp.sp(20),
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          SizedBox(height: resp.hp(1)),
          Text(
            'Las notificaciones de tus reportes aparecerán aquí.',
            style: TextStyle(
              fontSize: resp.sp(14),
              color: isDark ? Colors.grey[400] : Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: resp.hp(4)),
          ElevatedButton.icon(
            onPressed: onRefresh,
            icon: const Icon(Icons.refresh_rounded),
            label: const Text('Actualizar'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.blueBright,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: resp.wp(8),
                vertical: resp.hp(1.5),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}