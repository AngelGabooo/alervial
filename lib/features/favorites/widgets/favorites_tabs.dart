import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class FavoritesTabs extends StatelessWidget {
  final TabController tabController;

  const FavoritesTabs({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      color: isDark ? AppColors.darkSurface : Colors.white,
      child: TabBar(
        controller: tabController,
        indicatorColor: AppColors.blueBright,
        indicatorWeight: 3,
        labelColor: AppColors.blueBright,
        unselectedLabelColor: isDark ? Colors.grey[500] : Colors.grey[600],
        labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: resp.sp(13)),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: resp.sp(13)),
        tabs: const [
          Tab(text: 'Reportes'),
          Tab(text: 'Zonas'),
          Tab(text: 'Municipios'),
        ],
      ),
    );
  }
}