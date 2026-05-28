import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class StatsCharts extends StatelessWidget {
  const StatsCharts({super.key});

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Estadísticas',
          style: TextStyle(
            fontSize: resp.sp(18),
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        SizedBox(height: resp.hp(1.5)),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                context,
                title: 'Reportes por mes',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildBar(context, value: 8, color: AppColors.blueBright),
                    _buildBar(context, value: 12, color: AppColors.blueBright),
                    _buildBar(context, value: 4, color: AppColors.blueBright),
                    _buildBar(context, value: 6, color: AppColors.blueBright),
                  ],
                ),
              ),
            ),
            SizedBox(width: resp.wp(3)),
            Expanded(
              child: _buildStatCard(
                context,
                title: 'Categorías',
                child: Column(
                  children: [
                    _buildCategoryRow(context, 'Baches', 12, Colors.orange),
                    _buildCategoryRow(context, 'Derrumbes', 5, Colors.brown),
                    _buildCategoryRow(context, 'Inundaciones', 4, Colors.blue),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: resp.hp(1.5)),
        _buildStatCard(
          context,
          title: 'Actividad semanal',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:
            ['L', 'M', 'M', 'J', 'V', 'S', 'D'].map((day) {
              return _buildDayBar(context, day: day, value: [2, 5, 3, 7, 4, 6, 3][day == 'L' ? 0 : day == 'M' ? 1 : day == 'M' ? 2 : day == 'J' ? 3 : day == 'V' ? 4 : day == 'S' ? 5 : 6]);
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(BuildContext context, {required String title, required Widget child}) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(resp.wp(3)),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: resp.sp(14),
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          SizedBox(height: resp.hp(1)),
          child,
        ],
      ),
    );
  }

  Widget _buildBar(BuildContext context, {required double value, required Color color}) {
    final resp = context.resp;
    return Column(
      children: [
        Container(
          width: resp.wp(5),
          height: resp.hp(value * 2),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        SizedBox(height: resp.hp(0.5)),
        Text('${value.toInt()}', style: TextStyle(fontSize: resp.sp(10), color: Colors.grey)),
      ],
    );
  }

  Widget _buildDayBar(BuildContext context, {required String day, required int value}) {
    final resp = context.resp;
    return Column(
      children: [
        Container(
          width: resp.wp(5),
          height: resp.hp(value.toDouble()),
          decoration: BoxDecoration(
            color: AppColors.blueBright,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        SizedBox(height: resp.hp(0.5)),
        Text(day, style: TextStyle(fontSize: resp.sp(10), color: Colors.grey)),
      ],
    );
  }

  Widget _buildCategoryRow(BuildContext context, String label, int count, Color color) {
    final resp = context.resp;
    return Padding(
      padding: EdgeInsets.only(bottom: resp.hp(0.5)),
      child: Row(
        children: [
          Container(
            width: resp.wp(3),
            height: resp.wp(3),
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          SizedBox(width: resp.wp(2)),
          Expanded(
            child: Text(label, style: TextStyle(fontSize: resp.sp(12))),
          ),
          Text('$count', style: TextStyle(fontSize: resp.sp(12), fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}