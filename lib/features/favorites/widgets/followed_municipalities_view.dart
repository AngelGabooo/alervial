import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class FollowedMunicipalitiesView extends StatelessWidget {
  const FollowedMunicipalitiesView({super.key});

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListView.builder(
      padding: resp.padding(all: 16),
      physics: const BouncingScrollPhysics(),
      itemCount: 2,
      itemBuilder: (context, index) {
        return Container(
          margin: resp.padding(bottom: 12),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkSurface : Colors.white,
            borderRadius: resp.radius(12),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.blueBright.withOpacity(0.1),
              child: const Icon(Icons.location_city_rounded, color: AppColors.blueBright),
            ),
            title: Text(index == 0 ? 'Tuxtla Gutiérrez' : 'San Cristóbal de las Casas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: resp.sp(14))),
            subtitle: Text('Alertas activas: ${index == 0 ? "Altas" : "Moderadas"}', style: TextStyle(fontSize: resp.sp(12))),
            trailing: Switch.adaptive(
              value: true,
              activeColor: AppColors.blueBright,
              onChanged: (val) {},
            ),
          ),
        );
      },
    );
  }
}