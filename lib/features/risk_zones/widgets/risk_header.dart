import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class RiskHeader extends StatelessWidget {
  final VoidCallback onHeatmapToggle;
  final Function(String) onPeriodSelected;
  final String selectedPeriod;
  final bool showHeatmap;

  const RiskHeader({
    super.key,
    required this.onHeatmapToggle,
    required this.onPeriodSelected,
    required this.selectedPeriod,
    required this.showHeatmap,
  });

  // ✅ CORREGIDO: Agregar static const
  static const List<String> _periods = ['Hoy', 'Semana', 'Mes'];

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.black : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            resp.wp(5),
            resp.hp(1.5),
            resp.wp(5),
            resp.hp(2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_rounded,
                        color: isDark ? Colors.white : AppColors.blueDark),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: resp.wp(3),
                      vertical: resp.hp(0.5),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.blueBright.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.gps_fixed_rounded,
                            size: resp.iconSize(16), color: AppColors.blueBright),
                        SizedBox(width: resp.wp(1)),
                        Text(
                          'Tuxtla Gtz',
                          style: TextStyle(
                            fontSize: resp.sp(12),
                            color: AppColors.blueBright,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: resp.hp(1)),
              Text(
                'Zonas de Riesgo',
                style: TextStyle(
                  fontSize: resp.sp(28),
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : AppColors.blueDark,
                ),
              ),
              SizedBox(height: resp.hp(0.5)),
              Text(
                'Identifica las áreas con mayor incidencia vial.',
                style: TextStyle(
                  fontSize: resp.sp(14),
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                ),
              ),
              SizedBox(height: resp.hp(2)),
              Row(
                children: [
                  // Selector de período
                  Container(
                    padding: EdgeInsets.all(resp.wp(0.5)),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.grey[800] : Colors.grey[100],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: _periods.map((period) {
                        final isSelected = selectedPeriod == period;
                        return GestureDetector(
                          onTap: () => onPeriodSelected(period),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: resp.wp(4),
                              vertical: resp.hp(0.8),
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.blueBright
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              period,
                              style: TextStyle(
                                fontSize: resp.sp(13),
                                color: isSelected
                                    ? Colors.white
                                    : (isDark ? Colors.grey[400] : Colors.grey[600]),
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const Spacer(),
                  // Botón heatmap
                  GestureDetector(
                    onTap: onHeatmapToggle,
                    child: Container(
                      padding: EdgeInsets.all(resp.wp(2.5)),
                      decoration: BoxDecoration(
                        color: showHeatmap
                            ? AppColors.blueBright.withOpacity(0.2)
                            : (isDark ? Colors.grey[800] : Colors.grey[100]),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.heat_pump_rounded,
                        size: resp.iconSize(22),
                        color: showHeatmap ? AppColors.blueBright : Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}