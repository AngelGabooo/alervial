import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';
import '../../home/widgets/bottom_nav_bar.dart';
import '../widgets/search_header_bar.dart';
import '../widgets/search_filter_chips.dart';
import '../widgets/live_map_card.dart';
import '../widgets/trending_searches.dart';
import '../widgets/search_results_grid.dart';

class IntelligentSearchPage extends StatefulWidget {
  const IntelligentSearchPage({super.key});

  @override
  State<IntelligentSearchPage> createState() => _IntelligentSearchPageState();
}

class _IntelligentSearchPageState extends State<IntelligentSearchPage> {
  final int _currentIndex = 1; // Pestaña de Mapa/Búsqueda activa

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : AppColors.lightBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SearchHeaderBar(),
            const SearchFilterChips(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: resp.padding(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(flex: 4, child: TrendingSearches()),
                        const SizedBox(width: 12),
                        Expanded(flex: 5, child: LiveMapCard()),
                      ],
                    ),
                    resp.sizedBox(height: 24),
                    Text(
                      'Resultados encontrados',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: resp.sp(16)),
                    ),
                    resp.sizedBox(height: 12),
                    const SearchResultsGrid(),
                    resp.sizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 0) Navigator.pop(context);
        },
      ),
    );
  }
}