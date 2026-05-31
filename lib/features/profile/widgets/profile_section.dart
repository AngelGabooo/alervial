import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class ProfileSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const ProfileSection({
    super.key,
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: resp.wp(5), vertical: resp.hp(1)),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E293B) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(resp.wp(4), resp.hp(2), resp.wp(4), resp.hp(1)),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(resp.wp(1.5)),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.blueBright, AppColors.blueDark],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, size: resp.iconSize(16), color: Colors.white),
                  ),
                  SizedBox(width: resp.wp(2)),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: resp.sp(16),
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 0, indent: 20),
            ...children,
          ],
        ),
      ),
    );
  }
}