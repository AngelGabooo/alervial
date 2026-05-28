import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';
import 'package:viatux/routes/app_routes.dart';
import '../widgets/report_header.dart';
import '../widgets/location_card.dart';
import '../widgets/filter_chips.dart';
import '../widgets/report_card.dart';
import 'package:viatux/features/interactive_map/pages/interactive_map_page.dart';
class NearbyReportsPage extends StatefulWidget {
  const NearbyReportsPage({super.key});

  @override
  State<NearbyReportsPage> createState() => _NearbyReportsPageState();
}

class _NearbyReportsPageState extends State<NearbyReportsPage> {
  String _selectedFilter = 'Todos';

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded,
              color: isDark ? Colors.white : AppColors.blueDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Incidencias cercanas',
          style: TextStyle(
            fontSize: resp.sp(18),
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : AppColors.blueDark,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const LocationCard(),
                  FilterChips(
                    selectedFilter: _selectedFilter,
                    onFilterSelected: (filter) {
                      setState(() {
                        _selectedFilter = filter;
                      });
                    },
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: resp.wp(5)),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return const ReportCard();
                    },
                  ),
                  SizedBox(height: resp.hp(10)),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const InteractiveMapPage(),
            ),
          );
        },
        icon: const Icon(Icons.map_rounded),
        label: const Text('Ver en mapa'),
        backgroundColor: AppColors.blueBright,
        elevation: 4,
        heroTag: null, // ✅ Evitar conflicto de Hero
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

// Import necesario para InteractiveMapPage
