import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class SearchResultsGrid extends StatelessWidget {
  final String searchQuery;

  const SearchResultsGrid({super.key, required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Filtrar resultados según la búsqueda
    final filteredResults = _getFilteredResults(searchQuery);

    if (filteredResults.isEmpty) {
      return Container(
        padding: resp.padding(all: 32),
        alignment: Alignment.center,
        child: Column(
          children: [
            Icon(Icons.search_off_rounded, size: resp.iconSize(48), color: Colors.grey),
            SizedBox(height: resp.hp(2)),
            Text(
              'No se encontraron resultados',
              style: TextStyle(
                fontSize: resp.sp(14),
                color: Colors.grey,
              ),
            ),
            Text(
              'Intenta con otros términos de búsqueda',
              style: TextStyle(
                fontSize: resp.sp(12),
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 0.82,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      children: filteredResults.map((item) {
        return _buildResultCard(context, item);
      }).toList(),
    );
  }

  List<Map<String, dynamic>> _getFilteredResults(String query) {
    final List<Map<String, dynamic>> allResults = [
      {
        'image': 'https://images.unsplash.com/photo-115162305285-0293e4767cc2',
        'badge': 'Riesgo Alto',
        'badgeColor': Colors.red,
        'distance': '1.2 km',
        'title': 'Socavón en Pavimento',
        'location': 'Libramiento Sur, Tuxtla',
        'tags': ['Bacheo', 'Crítico'],
      },
      {
        'image': 'https://images.unsplash.com/photo-1547683905-f686c993aae5',
        'badge': 'En Proceso',
        'badgeColor': AppColors.blueBright,
        'distance': '4.5 km',
        'title': 'Mantenimiento Puentes',
        'location': 'Carretera Panamericana',
        'tags': ['Obra', 'Programado'],
      },
      {
        'image': 'https://images.unsplash.com/photo-1580674285054-bed31e145f59',
        'badge': 'Crítico',
        'badgeColor': Colors.red,
        'distance': '2.3 km',
        'title': 'Inundación en Calle 5',
        'location': 'Colonia Centro, Tuxtla',
        'tags': ['Inundación', 'Urgente'],
      },
      {
        'image': 'https://images.unsplash.com/photo-1580674285054-bed31e145f59',
        'badge': 'Moderado',
        'badgeColor': Colors.orange,
        'distance': '3.8 km',
        'title': 'Derrumbe en Carretera',
        'location': 'Carretera a San Cristóbal',
        'tags': ['Derrumbe', 'Precaución'],
      },
    ];

    if (query.isEmpty) return allResults;

    return allResults.where((item) {
      return item['title'].toLowerCase().contains(query.toLowerCase()) ||
          item['location'].toLowerCase().contains(query.toLowerCase()) ||
          item['tags'].any((tag) => tag.toLowerCase().contains(query.toLowerCase()));
    }).toList();
  }

  Widget _buildResultCard(BuildContext context, Map<String, dynamic> item) {
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
                  child: Image.network(
                    item['image'],
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.image_not_supported),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 6,
                  left: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: item['badgeColor'],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      item['badge'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 6,
                  right: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      item['distance'],
                      style: const TextStyle(color: Colors.white, fontSize: 8),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: resp.sp(12),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  item['location'],
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: resp.sp(10),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: item['tags'].map<Widget>((tag) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          tag,
                          style: TextStyle(fontSize: resp.sp(8)),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}