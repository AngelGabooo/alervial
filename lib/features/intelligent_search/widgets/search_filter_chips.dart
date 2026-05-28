import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class SearchFilterChips extends StatelessWidget {
  const SearchFilterChips({super.key});

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final filters = ['Filtros', 'Estado', 'Municipio', 'Categoría', 'Fecha'];

    return SizedBox(
      height: resp.hp(5),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: resp.padding(horizontal: 16),
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final isFirst = index == 0;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(filters[index]),
              selected: isFirst,
              onSelected: (val) {},
              selectedColor: AppColors.blueBright,
              checkmarkColor: Colors.white,
              labelStyle: TextStyle(
                color: isFirst ? Colors.white : Colors.grey[600],
                fontSize: resp.sp(12),
              ),
            ),
          );
        },
      ),
    );
  }
}