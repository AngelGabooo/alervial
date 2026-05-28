import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class FavoriteZonesView extends StatelessWidget {
  const FavoriteZonesView({super.key});

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
            leading: Icon(Icons.map_rounded, color: AppColors.blueBright, size: resp.sp(28)),
            title: Text('Zona Residencial Poniente', style: TextStyle(fontWeight: FontWeight.bold, fontSize: resp.sp(14))),
            subtitle: Text('Tuxtla Gutiérrez • 3 incidencias activas', style: TextStyle(fontSize: resp.sp(12))),
            trailing: IconButton(
              icon: const Icon(Icons.delete_outline_rounded, color: Colors.grey),
              onPressed: () {},
            ),
          ),
        );
      },
    );
  }
}