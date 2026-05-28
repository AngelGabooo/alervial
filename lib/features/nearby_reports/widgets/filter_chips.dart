import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class FilterChips extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterSelected;

  const FilterChips({
    super.key,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  final List<String> _filters = const [
    'Todos',
    'Baches',
    'Derrumbes',
    'Inundaciones',
    'Señalización'
  ];

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;

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
                backgroundColor: Colors.grey[200],
                selectedColor: AppColors.blueBright,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey[700],
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
                shape: const StadiumBorder(),
                elevation: 0,
              ),
            );
          },
        ),
      ),
    );
  }
}