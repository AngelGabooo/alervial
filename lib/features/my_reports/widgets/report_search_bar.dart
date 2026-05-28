import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class ReportSearchBar extends StatelessWidget {
  final Function(String) onSearch;

  const ReportSearchBar({super.key, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.only(bottom: resp.hp(2)),
      padding: EdgeInsets.symmetric(horizontal: resp.wp(3)),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : Colors.grey[100],
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        onChanged: onSearch,
        decoration: InputDecoration(
          hintText: 'Buscar por folio, ubicación...',
          hintStyle: TextStyle(color: isDark ? Colors.grey[500] : Colors.grey[400]),
          prefixIcon: Icon(Icons.search_rounded, color: isDark ? Colors.grey[500] : Colors.grey[400]),
          suffixIcon: Icon(Icons.filter_list_rounded, color: isDark ? Colors.grey[500] : Colors.grey[400]),
          border: InputBorder.none,
        ),
      ),
    );
  }
}