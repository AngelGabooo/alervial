import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';
import 'package:viatux/routes/app_routes.dart';
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
  String _searchQuery = '';
  String _selectedFilter = 'Filtros';

  void _onSearch(String query) {
    setState(() {
      _searchQuery = query;
    });
    // Aquí puedes implementar la búsqueda en tiempo real
    debugPrint('Buscando: $query');
  }

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded,
              color: isDark ? Colors.white : AppColors.blueDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Búsqueda inteligente',
          style: TextStyle(
            fontSize: resp.sp(18),
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : AppColors.blueDark,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchHeaderBar(onSearch: _onSearch),
          SearchFilterChips(
            selectedFilter: _selectedFilter,
            onFilterSelected: (filter) {
              setState(() => _selectedFilter = filter);
            },
          ),
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
                      Expanded(
                        flex: 5,
                        child: LiveMapCard(
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.interactiveMap);
                          },
                        ),
                      ),
                    ],
                  ),
                  resp.sizedBox(height: 24),
                  Text(
                    'Resultados encontrados',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: resp.sp(16),
                    ),
                  ),
                  resp.sizedBox(height: 12),
                  SearchResultsGrid(searchQuery: _searchQuery),
                  resp.sizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}