import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';
import 'package:viatux/core/widgets/gradient_background.dart';
import 'package:viatux/routes/app_routes.dart';
import '../widgets/success_animation.dart';
import '../widgets/info_card.dart';
import '../widgets/timeline_steps.dart';

class ReportSuccessPage extends StatelessWidget {
  const ReportSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GradientBackground(
      hasPattern: true,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.close_rounded, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(resp.wp(5)),
              child: Column(
                children: [
                  const SuccessAnimation(),
                  SizedBox(height: resp.hp(2)),
                  Text(
                    '¡Reporte enviado exitosamente!',
                    style: TextStyle(
                      fontSize: resp.sp(24),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: resp.hp(1)),
                  Text(
                    'Tu incidencia fue registrada correctamente y será revisada por las autoridades.',
                    style: TextStyle(
                      fontSize: resp.sp(14),
                      color: Colors.white.withOpacity(0.9),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: resp.hp(3)),
                  const InfoCard(),
                  SizedBox(height: resp.hp(3)),
                  const TimelineSteps(),
                  SizedBox(height: resp.hp(3)),
                  Container(
                    padding: EdgeInsets.all(resp.wp(3)),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.notifications_active_rounded,
                            size: resp.iconSize(20), color: Colors.white70),
                        SizedBox(width: resp.wp(3)),
                        Expanded(
                          child: Text(
                            'Recibirás notificaciones sobre el avance de tu reporte.',
                            style: TextStyle(
                              fontSize: resp.sp(13),
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: resp.hp(4)),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, AppRoutes.home);
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: resp.hp(1.5)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            side: BorderSide(color: Colors.white.withOpacity(0.5)),
                          ),
                          child: Text(
                            'Volver al inicio',
                            style: TextStyle(fontSize: resp.sp(14)),
                          ),
                        ),
                      ),
                      SizedBox(width: resp.wp(3)),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, AppRoutes.reportDetail);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.blueBright,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: resp.hp(1.5)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            'Ver reporte',
                            style: TextStyle(fontSize: resp.sp(14)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: resp.hp(2)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}