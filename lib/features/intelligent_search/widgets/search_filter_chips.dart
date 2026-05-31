import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class SearchFilterChips extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterSelected;

  const SearchFilterChips({
    super.key,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  // ✅ CORREGIDO: Agregar 'static const' para que sea constante
  static const List<String> _filters = ['Filtros', 'Estado', 'Municipio', 'Categoría', 'Fecha'];

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: resp.hp(5),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: resp.padding(horizontal: 16),
        itemCount: _filters.length,
        itemBuilder: (context, index) {
          final filter = _filters[index];
          final isSelected = selectedFilter == filter;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(filter),
              selected: isSelected,
              onSelected: (_) => onFilterSelected(filter),
              selectedColor: AppColors.blueBright,
              checkmarkColor: Colors.white,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : (isDark ? Colors.grey[400] : Colors.grey[600]),
                fontSize: resp.sp(12),
              ),
            ),
          );
        },
      ),
    );
  }
}