import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';
import '../widgets/risk_header.dart';
import '../widgets/risk_map.dart';
import '../widgets/risk_bottom_sheet.dart';
import '../widgets/alert_card.dart';

class RiskZonesPage extends StatefulWidget {
  const RiskZonesPage({super.key});

  @override
  State<RiskZonesPage> createState() => _RiskZonesPageState();
}

class _RiskZonesPageState extends State<RiskZonesPage> {
  bool _showHeatmap = true;
  String _selectedPeriod = 'Hoy';

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.grey[100],
      body: Column(
        children: [
          RiskHeader(
            onHeatmapToggle: () {
              setState(() => _showHeatmap = !_showHeatmap);
            },
            onPeriodSelected: (period) {
              setState(() => _selectedPeriod = period);
            },
            selectedPeriod: _selectedPeriod,
            showHeatmap: _showHeatmap,
          ),
          Expanded(
            child: Stack(
              children: [
                RiskMap(showHeatmap: _showHeatmap),
                // Alertas importantes flotantes
                Positioned(
                  bottom: resp.hp(2),
                  left: resp.wp(4),
                  right: resp.wp(4),
                  child: const AlertCard(),
                ),
              ],
            ),
          ),
          const RiskBottomSheet(),
        ],
      ),
    );
  }
}