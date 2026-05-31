import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class SearchHeaderBar extends StatelessWidget {
  final Function(String)? onSearch;

  const SearchHeaderBar({super.key, this.onSearch});

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: resp.padding(all: 16),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E293B) : Colors.white,
          borderRadius: resp.radius(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          onChanged: onSearch,
          decoration: InputDecoration(
            hintText: 'Buscar incidencias, municipios o calles...',
            hintStyle: TextStyle(fontSize: resp.sp(13), color: Colors.grey),
            prefixIcon: const Icon(Icons.search_rounded, color: Colors.grey),
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.mic_none_rounded, color: Colors.grey),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.gps_fixed_rounded, color: Colors.grey),
                  onPressed: () {},
                ),
              ],
            ),
            border: InputBorder.none,
            contentPadding: resp.padding(vertical: 14),
          ),
        ),
      ),
    );
  }
}