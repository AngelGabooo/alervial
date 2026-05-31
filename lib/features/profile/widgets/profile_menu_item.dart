import 'package:flutter/material.dart';
import 'package:viatux/core/utils/responsive.dart';

import '../../../core/constants/colors.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Widget? trailing;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListTile(
      leading: Container(
        width: resp.wp(10),
        height: resp.wp(10),
        decoration: BoxDecoration(
          color: AppColors.blueBright.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: resp.iconSize(20), color: AppColors.blueBright),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: resp.sp(15),
          fontWeight: FontWeight.w600,
          color: isDark ? Colors.white : Colors.black87,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: resp.sp(12),
          color: isDark ? Colors.grey[500] : Colors.grey[600],
        ),
      ),
      trailing: trailing ?? Icon(Icons.chevron_right_rounded, color: Colors.grey),
      onTap: onTap,
    );
  }
}