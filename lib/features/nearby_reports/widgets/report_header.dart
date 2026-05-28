import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class ReportHeader extends StatelessWidget {
  const ReportHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [const Color(0xFF0A2540), const Color(0xFF1565C0)]
              : [AppColors.blueDark, AppColors.blueBright],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(resp.wp(5), resp.hp(1.5), resp.wp(5), resp.hp(3)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_rounded, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(Icons.filter_list_rounded, color: Colors.white),
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox(height: resp.hp(1)),
              Text(
                'Incidencias cercanas',
                style: TextStyle(
                  fontSize: resp.sp(28),
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: resp.hp(0.5)),
              Row(
                children: [
                  Icon(Icons.gps_fixed_rounded, size: resp.iconSize(16), color: Colors.white70),
                  SizedBox(width: resp.wp(2)),
                  Text(
                    'Problemas viales reportados cerca de tu ubicación.',
                    style: TextStyle(
                      fontSize: resp.sp(13),
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}