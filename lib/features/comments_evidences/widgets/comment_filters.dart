import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class CommentFilters extends StatelessWidget {
  final String selectedFilter;
  final String selectedDateFilter;
  final Function(String) onFilterSelected;
  final Function(String) onDateFilterSelected;

  const CommentFilters({
    super.key,
    required this.selectedFilter,
    required this.selectedDateFilter,
    required this.onFilterSelected,
    required this.onDateFilterSelected,
  });

  static const List<String> _filters = ['Todos', 'Ciudadanos', 'Autoridades', 'Actualizaciones'];
  static const List<String> _dateFilters = ['Hoy', 'Semana', 'Mes'];

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
            height: resp.hp(4),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: _dateFilters.length,
              itemBuilder: (context, index) {
                final dateFilter = _dateFilters[index];
                final isSelected = selectedDateFilter == dateFilter;
                return Padding(
                  padding: EdgeInsets.only(right: resp.wp(3)),
                  child: OutlinedButton(
                    onPressed: () => onDateFilterSelected(dateFilter),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: isSelected ? AppColors.blueBright : Colors.transparent,
                      foregroundColor: isSelected ? Colors.white : (isDark ? Colors.grey[400] : Colors.grey[700]),
                      side: BorderSide(color: isDark ? Colors.grey[600]! : Colors.grey[300]!),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    child: Text(dateFilter, style: TextStyle(fontSize: resp.sp(12))),
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