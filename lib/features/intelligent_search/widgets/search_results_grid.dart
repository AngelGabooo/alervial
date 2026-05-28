import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class SearchResultsGrid extends StatelessWidget {
  const SearchResultsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 0.82,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      children: [
        _buildResultCard(
          context,
          'https://images.unsplash.com/photo-115162305285-0293e4767cc2',
          'Riesgo Alto',
          '1.2 km',
          'Socavón en Pavimento',
          'Libramiento Sur, Tuxtla',
          ['Bacheo', 'Crítico'],
          Colors.red,
        ),
        _buildResultCard(
          context,
          'https://images.unsplash.com/photo-1547683905-f686c993aae5',
          'En Proceso',
          '4.5 km',
          'Mantenimiento Puentes',
          'Carretera Panamericana',
          ['Obra', 'Programado'],
          AppColors.blueBright,
        ),
      ],
    );
  }

  Widget _buildResultCard(
      BuildContext context,
      String img,
      String badge,
      String dist,
      String title,
      String loc,
      List<String> tags,
      Color badgeColor,
      ) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : Colors.white,
        borderRadius: resp.radius(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(img, width: double.infinity, fit: BoxFit.cover),
                ),
                Positioned(
                  top: 6,
                  left: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: badgeColor, borderRadius: BorderRadius.circular(4)),
                    child: Text(badge, style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
                  ),
                ),
                Positioned(
                  top: 6,
                  right: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(4)),
                    child: Text(dist, style: const TextStyle(color: Colors.white, fontSize: 8)),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: resp.sp(12)), maxLines: 1, overflow: TextOverflow.ellipsis),
                Text(loc, style: TextStyle(color: Colors.grey, fontSize: resp.sp(10)), maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Row(
                  children: tags.map((t) => Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2), borderRadius: BorderRadius.circular(4)),
                      child: Text(t, style: TextStyle(fontSize: resp.sp(8))),
                    ),
                  )).toList(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}