import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';
import '../widgets/map_header.dart';
import '../widgets/bottom_sheet_detail.dart';
import '../widgets/floating_buttons.dart';

class InteractiveMapPage extends StatefulWidget {
  const InteractiveMapPage({super.key});

  @override
  State<InteractiveMapPage> createState() => _InteractiveMapPageState();
}

class _InteractiveMapPageState extends State<InteractiveMapPage> {
  bool _showHeatmap = false;
  int? _selectedMarkerId;

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: isDark ? Colors.white : AppColors.blueDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Mapa interactivo',
          style: TextStyle(
            fontSize: resp.sp(18),
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : AppColors.blueDark,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Mapa de fondo simulado
          Container(
            width: double.infinity,
            height: double.infinity,
            color: isDark ? Colors.grey[800] : Colors.grey[200],
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.map_rounded, size: resp.iconSize(80), color: Colors.grey[400]),
                  Text('Google Maps View', style: TextStyle(color: Colors.grey[500])),
                ],
              ),
            ),
          ),
          // Marcadores simulados
          Positioned(
            top: resp.hp(25),
            left: resp.wp(15),
            child: _buildMarker(context, Icons.warning_rounded, Colors.red, id: 1),
          ),
          Positioned(
            top: resp.hp(35),
            right: resp.wp(20),
            child: _buildMarker(context, Icons.water_drop_rounded, Colors.blue, id: 2),
          ),
          Positioned(
            bottom: resp.hp(20),
            left: resp.wp(25),
            child: _buildMarker(context, Icons.landslide_rounded, Colors.orange, id: 3),
          ),
          // Header flotante
          const MapHeader(),
          // Bottom sheet al seleccionar marcador
          if (_selectedMarkerId != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: BottomSheetDetail(
                onClose: () => setState(() => _selectedMarkerId = null),
              ),
            ),
          // Botones flotantes
          FloatingButtons(
            onCenter: () {},
            onHeatmap: () {
              setState(() => _showHeatmap = !_showHeatmap);
            },
            onReport: () {},
            showHeatmap: _showHeatmap,
          ),
        ],
      ),
    );
  }

  Widget _buildMarker(BuildContext context, IconData icon, Color color, {required int id}) {
    final resp = context.resp;
    return GestureDetector(
      onTap: () => setState(() => _selectedMarkerId = id),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(resp.wp(2)),
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.5),
              blurRadius: 12,
              spreadRadius: 4,
            ),
          ],
        ),
        child: Icon(icon, size: resp.iconSize(20), color: Colors.white),
      ),
    );
  }
}