// lib/features/risk/presentation/screens/risk_zones_screen.dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class RiskZonesScreen extends StatefulWidget {
  const RiskZonesScreen({super.key});

  @override
  State<RiskZonesScreen> createState() => _RiskZonesScreenState();
}

class _RiskZonesScreenState extends State<RiskZonesScreen> with SingleTickerProviderStateMixin {
  String _selectedPeriod = "Hoy";
  final List<String> _periods = ["Hoy", "Semana", "Mes"];
  bool _showHeatmap = true;
  String _selectedMunicipio = "Tuxtla Gutiérrez";
  final List<String> _municipios = [
    "Tuxtla Gutiérrez",
    "San Cristóbal",
    "Tapachula",
    "Comitán",
    "Chiapa de Corzo",
  ];

  late AnimationController _animationController;
  int? _selectedZone;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          // Mapa de calor simulado
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF1A1A2E),
                  const Color(0xFF16213E),
                  const Color(0xFF0F3460),
                ],
              ),
            ),
            child: Stack(
              children: [
                // Simulación de heatmap
                ..._buildHeatmapZones(),

                // Centro del mapa
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 50,
                        color: Colors.red.withOpacity(0.8),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Tu ubicación actual",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Header flotante
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Título y selector
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Zonas de Riesgo",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Identifica las áreas con mayor incidencia vial.",
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.warning_amber_rounded,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Controles
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            // Selector de municipio y periodo
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: _selectedMunicipio,
                                        isExpanded: true,
                                        icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                                        dropdownColor: const Color(0xFF1A1A2E),
                                        items: _municipios.map((municipio) {
                                          return DropdownMenuItem(
                                            value: municipio,
                                            child: Text(
                                              municipio,
                                              style: const TextStyle(color: Colors.white),
                                            ),
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
                                    color: Colors.white.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: IconButton(
                                    icon: Icon(
                                      _showHeatmap ? Icons.heat_pump : Icons.map,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _showHeatmap = !_showHeatmap;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            // Selector de periodo
                            Row(
                              children: _periods.map((period) {
                                final isSelected = _selectedPeriod == period;
                                return Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedPeriod = period;
                                      });
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 4),
                                      padding: const EdgeInsets.symmetric(vertical: 8),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? AppColors.primaryBlue
                                            : Colors.white.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Center(
                                        child: Text(
                                          period,
                                          style: TextStyle(
                                            color: isSelected ? Colors.white : Colors.white70,
                                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Botones de zoom
          Positioned(
            right: 16,
            bottom: 200,
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: "zoomIn",
                  mini: true,
                  onPressed: () {},
                  backgroundColor: Colors.white.withOpacity(0.9),
                  foregroundColor: AppColors.primaryDark,
                  child: const Icon(Icons.add),
                ),
                const SizedBox(height: 8),
                FloatingActionButton(
                  heroTag: "zoomOut",
                  mini: true,
                  onPressed: () {},
                  backgroundColor: Colors.white.withOpacity(0.9),
                  foregroundColor: AppColors.primaryDark,
                  child: const Icon(Icons.remove),
                ),
              ],
            ),
          ),

          // Bottom Sheet con estadísticas
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, (1 - _animationController.value) * 100),
                  child: Opacity(
                    opacity: _animationController.value,
                    child: _buildStatsBottomSheet(isDark),
                  ),
                );
              },
            ),
          ),

          // Alertas importantes flotantes
          Positioned(
            bottom: 320,
            left: 16,
            right: 16,
            child: AnimatedOpacity(
              opacity: _selectedZone == null ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: _buildAlertCards(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildHeatmapZones() {
    final zones = [
      {"left": 0.2, "top": 0.3, "size": 120, "color": Colors.red, "opacity": 0.4},
      {"left": 0.5, "top": 0.5, "size": 150, "color": Colors.orange, "opacity": 0.3},
      {"left": 0.7, "top": 0.2, "size": 100, "color": Colors.red, "opacity": 0.35},
      {"left": 0.3, "top": 0.7, "size": 130, "color": Colors.orange, "opacity": 0.3},
      {"left": 0.6, "top": 0.8, "size": 90, "color": Colors.green, "opacity": 0.2},
    ];

    return zones.map((zone) {
      return Positioned(
        left: MediaQuery.of(context).size.width * (zone["left"] as double) - (zone["size"] as double) / 2,
        top: MediaQuery.of(context).size.height * (zone["top"] as double) - (zone["size"] as double) / 2,
        child: GestureDetector(
          onTap: () {
            setState(() {
              _selectedZone = zones.indexOf(zone);
            });
            _animationController.reset();
            _animationController.forward();
          },
          child: Container(
            width: zone["size"] as double,
            height: zone["size"] as double,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  (zone["color"] as Color).withOpacity(0.6),
                  (zone["color"] as Color).withOpacity(0.0),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: (zone["color"] as Color).withOpacity(0.8),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: (zone["color"] as Color).withOpacity(0.5),
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.warning,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
      );
    }).toList();
  }

  Widget _buildStatsBottomSheet(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Indicador de arrastre
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),

            // Estadísticas
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatCard("24", "Incidencias", Icons.report, Colors.red),
                _buildStatCard("Zona Norte", "Más afectada", Icons.location_on, Colors.orange),
                _buildStatCard("Baches", "Más frecuente", Icons.circle, AppColors.primaryBlue),
              ],
            ),
            const SizedBox(height: 20),

            // Nivel de riesgo general
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.red.withOpacity(0.2),
                    Colors.orange.withOpacity(0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Riesgo general",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "ALTO",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Botón ver más
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primaryBlue,
                  side: const BorderSide(color: AppColors.primaryBlue),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("Ver estadísticas detalladas"),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildAlertCards() {
    final alerts = [
      {"title": "⚠️ Derrumbe reciente", "location": "Carretera Panamericana Km 15", "time": "Hace 30 min"},
      {"title": "🚧 Calle cerrada", "location": "Av. Central", "time": "Desde hace 2 horas"},
      {"title": "💧 Inundación detectada", "location": "Col. Centro", "time": "Hace 1 hora"},
    ];

    return Column(
      children: alerts.map((alert) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.warning, color: Colors.red, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      alert["title"]!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      alert["location"]!,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                alert["time"]!,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}