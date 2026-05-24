// lib/features/map/presentation/screens/map_interactive_screen.dart (COMPLETAMENTE CORREGIDO)
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class MapInteractiveScreen extends StatefulWidget {
  const MapInteractiveScreen({super.key});

  @override
  State<MapInteractiveScreen> createState() => _MapInteractiveScreenState();
}

class _MapInteractiveScreenState extends State<MapInteractiveScreen> {
  bool _showHeatmap = false;
  String _selectedMunicipio = "Tuxtla Gutiérrez";
  final List<String> _municipios = [
    "Tuxtla Gutiérrez",
    "San Cristóbal",
    "Tapachula",
    "Comitán",
    "Chiapa de Corzo",
  ];

  // Simular marcadores en el mapa
  final List<Map<String, dynamic>> _markers = [
    {"type": "Bache", "lat": 16.753, "lng": -93.116, "status": "Pendiente", "risk": "Alto"},
    {"type": "Derrumbe", "lat": 16.745, "lng": -93.108, "status": "En proceso", "risk": "Crítico"},
    {"type": "Inundación", "lat": 16.760, "lng": -93.125, "status": "Resuelto", "risk": "Medio"},
    {"type": "Señalización", "lat": 16.770, "lng": -93.105, "status": "Pendiente", "risk": "Moderado"},
    {"type": "Bache", "lat": 16.740, "lng": -93.115, "status": "En proceso", "risk": "Alto"},
  ];

  int? _selectedMarkerIndex;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          // Simulación de mapa (en producción usar Google Maps)
          Container(
            color: isDark ? AppColors.darkBackground : Colors.grey[200],
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.map,
                    size: 80,
                    color: isDark ? Colors.grey[700] : Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Mapa interactivo de Google Maps",
                    style: TextStyle(
                      color: isDark ? Colors.grey[600] : Colors.grey[500],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Marcadores: ${_markers.length} incidencias",
                    style: TextStyle(
                      color: isDark ? Colors.grey[600] : Colors.grey[500],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Marcadores simulados (en posiciones relativas)
          ..._markers.asMap().entries.map((entry) {
            final index = entry.key;
            final marker = entry.value;
            final isSelected = _selectedMarkerIndex == index;

            return Positioned(
              left: 50 + (index * 60),
              top: 100 + (index * 80),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedMarkerIndex = isSelected ? null : index;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  // CORREGIDO: Usar Transform.scale en lugar de Matrix4 con cascade
                  child: Transform.scale(
                    scale: isSelected ? 1.2 : 1.0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _getMarkerColor(marker["type"]),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: _getMarkerColor(marker["type"]).withOpacity(0.5),
                            blurRadius: 10,
                            spreadRadius: isSelected ? 5 : 2,
                          ),
                        ],
                      ),
                      child: Icon(
                        _getMarkerIcon(marker["type"]),
                        size: isSelected ? 28 : 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),

          // Header flotante
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Barra de búsqueda
                    Container(
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.darkSurface : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Buscar dirección o lugar...",
                          prefixIcon: const Icon(Icons.search, color: AppColors.primaryBlue),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.tune, color: AppColors.primaryBlue),
                            onPressed: () {},
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: isDark ? AppColors.darkSurface : Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Selector de municipio y GPS
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: isDark ? AppColors.darkSurface : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _selectedMunicipio,
                                isExpanded: true,
                                icon: const Icon(Icons.arrow_drop_down, color: AppColors.primaryBlue),
                                items: _municipios.map((municipio) {
                                  return DropdownMenuItem(
                                    value: municipio,
                                    child: Text(municipio),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedMunicipio = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isDark ? AppColors.darkSurface : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.my_location, color: AppColors.primaryBlue),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bottom Sheet al seleccionar marcador
          if (_selectedMarkerIndex != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildBottomSheet(_markers[_selectedMarkerIndex!], isDark),
            ),

          // Botones flotantes
          Positioned(
            bottom: 80,
            right: 16,
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: "center",
                  mini: true,
                  onPressed: () {},
                  backgroundColor: isDark ? AppColors.darkSurface : Colors.white,
                  foregroundColor: AppColors.primaryBlue,
                  child: const Icon(Icons.my_location),
                ),
                const SizedBox(height: 12),
                FloatingActionButton(
                  heroTag: "heatmap",
                  mini: true,
                  onPressed: () {
                    setState(() {
                      _showHeatmap = !_showHeatmap;
                    });
                  },
                  backgroundColor: _showHeatmap ? AppColors.primaryBlue : (isDark ? AppColors.darkSurface : Colors.white),
                  foregroundColor: _showHeatmap ? Colors.white : AppColors.primaryBlue,
                  child: const Icon(Icons.heat_pump),
                ),
                const SizedBox(height: 12),
                FloatingActionButton(
                  heroTag: "report",
                  mini: true,
                  onPressed: () {},
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSheet(Map<String, dynamic> marker, bool isDark) {
    final statusColor = marker["status"] == "Resuelto"
        ? AppColors.accentGreen
        : marker["status"] == "En proceso"
        ? Colors.orange
        : Colors.red;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _getMarkerColor(marker["type"]).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    _getMarkerIcon(marker["type"]),
                    color: _getMarkerColor(marker["type"]),
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        marker["type"],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: statusColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              marker["status"],
                              style: TextStyle(
                                fontSize: 12,
                                color: statusColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              "⚠️ ${marker["risk"]} riesgo",
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  "A ${200 + (marker["risk"] == "Crítico" ? 100 : 50)} metros • Hace ${marker["status"] == "Resuelto" ? "2 días" : "3 horas"}",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _selectedMarkerIndex = null;
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primaryBlue,
                      side: const BorderSide(color: AppColors.primaryBlue),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Cerrar"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Ver detalle"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getMarkerColor(String type) {
    switch (type) {
      case "Bache":
        return Colors.orange;
      case "Derrumbe":
        return Colors.red;
      case "Inundación":
        return AppColors.primaryBlue;
      case "Señalización":
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  IconData _getMarkerIcon(String type) {
    switch (type) {
      case "Bache":
        return Icons.circle;
      case "Derrumbe":
        return Icons.landslide;
      case "Inundación":
        return Icons.water;
      case "Señalización":
        return Icons.signpost;
      default:
        return Icons.warning;
    }
  }
}