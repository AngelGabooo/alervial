import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class AlertHeader extends StatelessWidget {
  const AlertHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.black : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            resp.wp(5),
            resp.hp(1.5),
            resp.wp(5),
            resp.hp(2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_rounded,
                        color: isDark ? Colors.white : AppColors.blueDark),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  Container(
                    padding: EdgeInsets.all(resp.wp(2)),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.auto_awesome_rounded,
                        size: resp.iconSize(20), color: Colors.red),
                  ),
                ],
              ),
              SizedBox(height: resp.hp(1)),
              Text(
                'Alertas inteligentes',
                style: TextStyle(
                  fontSize: resp.sp(28),
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : AppColors.blueDark,
                ),
              ),
              SizedBox(height: resp.hp(0.5)),
              Text(
                'Riesgos detectados en tiempo real cerca de ti.',
                style: TextStyle(
                  fontSize: resp.sp(14),
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                ),
              ),
              SizedBox(height: resp.hp(2)),
            ],
          ),
        ),
      ),
    );
  }
}