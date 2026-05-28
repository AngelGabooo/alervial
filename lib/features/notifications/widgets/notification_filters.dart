import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class NotificationFilters extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterSelected;

  const NotificationFilters({
    super.key,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  static const List<String> _filters = [
    'Todas',
    'Importantes',
    'Reportes',
    'Riesgos',
    'Soluciones',
  ];

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: resp.wp(5), vertical: resp.hp(1)),
      child: SizedBox(
        height: resp.hp(5),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: _filters.length,
          itemBuilder: (context, index) {
            final filter = _filters[index];
            final isSelected = selectedFilter == filter;
            return Padding(
              padding: EdgeInsets.only(right: resp.wp(3)),
              child: FilterChip(
                label: Text(filter),
                selected: isSelected,
                onSelected: (_) => onFilterSelected(filter),
                backgroundColor: isDark ? Colors.grey[800] : Colors.grey[200],
                selectedColor: AppColors.blueBright,
                labelStyle: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : (isDark ? Colors.grey[400] : Colors.grey[700]),
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}