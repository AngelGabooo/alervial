import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';
import '../../home/widgets/bottom_nav_bar.dart';
import '../widgets/favorites_tabs.dart';
import '../widgets/saved_report_card.dart';
import '../widgets/favorite_zones_view.dart';
import '../widgets/followed_municipalities_view.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final int _currentIndex = 3; // Alertas / Favoritos activo en el BottomBar

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.darkSurface : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Favoritos',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: resp.sp(18)),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.ios_share_rounded), onPressed: () {}),
          IconButton(icon: const Icon(Icons.tune_rounded), onPressed: () {}),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: resp.padding(horizontal: 20, vertical: 12),
            child: Text(
              'Accede rápidamente a tus incidencias y zonas guardadas.',
              style: TextStyle(
                fontSize: resp.sp(14),
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
          ),
          FavoritesTabs(tabController: _tabController),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // TAB 1: Reportes Guardados
                GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 0.72,
                  padding: resp.padding(all: 16),
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  physics: const BouncingScrollPhysics(),
                  children: const [
                    SavedReportCard(
                      imageUrl: 'https://images.unsplash.com/photo-1515162305285-0293e4767cc2',
                      status: 'Pendiente',
                      risk: 'Alto Riesgo',
                      title: 'Derrumbe en Carretera',
                      time: 'Guardado ayer',
                      location: 'Tuxtla Gutiérrez • 2.4 km',
                      isPending: true,
                    ),
                    SavedReportCard(
                      imageUrl: 'https://images.unsplash.com/photo-1547683905-f686c993aae5',
                      status: 'En Proceso',
                      risk: 'Riesgo Medio',
                      title: 'Inundación por Lluvias',
                      time: 'Hace 3 días',
                      location: 'San Cristóbal • 12 km',
                      isPending: false,
                    ),
                  ],
                ),
                // TAB 2: Zonas Favoritas
                const FavoriteZonesView(),
                // TAB 3: Municipios Seguidos
                const FollowedMunicipalitiesView(),
              ],
            ),
          ),
        ],
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