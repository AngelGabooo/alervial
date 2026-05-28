import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class FilterChipsReports extends StatelessWidget {
  final String selectedFilter;
  final String selectedCategory;
  final Function(String) onFilterSelected;
  final Function(String) onCategorySelected;

  const FilterChipsReports({
    super.key,
    required this.selectedFilter,
    required this.selectedCategory,
    required this.onFilterSelected,
    required this.onCategorySelected,
  });

  static const List<String> _filters = ['Todos', 'Pendientes', 'En proceso', 'Resueltos'];
  static const List<String> _categories = ['Todas', 'Baches', 'Derrumbes', 'Inundaciones', 'Señalización'];

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: resp.wp(5), vertical: resp.hp(1)),
      child: Column(
        children: [
          SizedBox(
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
                      color: isSelected ? Colors.white : (isDark ? Colors.grey[400] : Colors.grey[700]),
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: resp.hp(1)),
          SizedBox(
            height: resp.hp(5),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = selectedCategory == category;
                return Padding(
                  padding: EdgeInsets.only(right: resp.wp(3)),
                  child: OutlinedButton(
                    onPressed: () => onCategorySelected(category),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: isSelected ? AppColors.blueBright : Colors.transparent,
                      foregroundColor: isSelected ? Colors.white : (isDark ? Colors.grey[400] : Colors.grey[700]),
                      side: BorderSide(color: isDark ? Colors.grey[600]! : Colors.grey[300]!),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    child: Text(category, style: TextStyle(fontSize: resp.sp(12))),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}