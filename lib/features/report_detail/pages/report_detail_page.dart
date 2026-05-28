import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';
import '../widgets/report_image.dart';
import '../widgets/info_section.dart';
import '../widgets/progress_timeline.dart';
import '../widgets/mini_map_detail.dart';
import '../widgets/comments_section.dart';
import '../widgets/action_buttons.dart';

class ReportDetailPage extends StatelessWidget {
  const ReportDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: CustomScrollView(
        slivers: [
          // Header con imagen
          const SliverToBoxAdapter(
            child: ReportImage(),
          ),
          // Contenido
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(resp.wp(5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const InfoSection(),
                  SizedBox(height: resp.hp(3)),
                  const ProgressTimeline(),
                  SizedBox(height: resp.hp(3)),
                  const MiniMapDetail(),
                  SizedBox(height: resp.hp(3)),
                  const CommentsSection(),
                  SizedBox(height: resp.hp(3)),
                  const ActionButtons(),
                  SizedBox(height: resp.hp(3)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}