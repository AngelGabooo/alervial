import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class CategorySelector extends StatelessWidget {
  final String? selectedCategory;
  final Function(String) onCategorySelected;

  const CategorySelector({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  final List<Map<String, dynamic>> _categories = const [
    {'name': 'Bache', 'icon': Icons.circle_outlined, 'color': Colors.orange},
    {'name': 'Derrumbe', 'icon': Icons.landslide_rounded, 'color': Colors.brown},
    {'name': 'Inundación', 'icon': Icons.water_drop_rounded, 'color': Colors.blue},
    {'name': 'Señalización', 'icon': Icons.signpost_rounded, 'color': Colors.purple},
    {'name': 'Accidente', 'icon': Icons.car_crash_rounded, 'color': Colors.red},
    {'name': 'Otro', 'icon': Icons.help_outline_rounded, 'color': Colors.grey},
  ];

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Categoría',
          style: TextStyle(
            fontSize: resp.sp(16),
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : AppColors.blueDark,
          ),
        ),
        SizedBox(height: resp.hp(1.5)),
        Wrap(
          spacing: resp.wp(3),
          runSpacing: resp.hp(1.5),
          children: _categories.map((category) {
            final isSelected = selectedCategory == category['name'];
            return GestureDetector(
              onTap: () => onCategorySelected(category['name']),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: resp.wp(4),
                  vertical: resp.hp(1.2),
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? (category['color'] as Color)
                      : (isDark ? Colors.grey[800] : Colors.grey[100]),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: isSelected ? Colors.transparent : Colors.grey.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      category['icon'],
                      size: resp.iconSize(18),
                      color: isSelected ? Colors.white : category['color'],
                    ),
                    SizedBox(width: resp.wp(2)),
                    Text(
                      category['name'],
                      style: TextStyle(
                        fontSize: resp.sp(13),
                        color: isSelected ? Colors.white : category['color'],
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}