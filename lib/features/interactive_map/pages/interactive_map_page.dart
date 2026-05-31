import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/services/location_service.dart';
import 'package:viatux/core/utils/responsive.dart';
import 'package:viatux/core/widgets/fake_location_dialog.dart';
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
  final MapController _mapController = MapController();
  late LatLng _currentLocation;
  bool _isCheckingLocation = true;
  bool _hasShownFakeDialog = false;

  // Centro de Tuxtla Gutiérrez, Chiapas
  final LatLng _tuxtlaCenter = const LatLng(16.7569, -93.1293);

  // Marcadores de incidencias reales en Tuxtla
  final List<Map<String, dynamic>> _markers = [
    {
      'id': 1,
      'lat': 16.7569,
      'lng': -93.1293,
      'title': 'Bache profundo',
      'address': 'Av. Central #123, Tuxtla Gtz',
      'type': 'Bache',
      'risk': 'Alto',
      'status': 'Pendiente',
      'icon': Icons.circle_outlined,
      'color': Colors.red,
      'time': 'Hace 2 horas',
    },
    {
      'id': 2,
      'lat': 16.7669,
      'lng': -93.1393,
      'title': 'Inundación',
      'address': 'Calle 5 de Mayo, Tuxtla Gtz',
      'type': 'Inundación',
      'risk': 'Crítico',
      'status': 'En proceso',
      'icon': Icons.water_drop_rounded,
      'color': Colors.blue,
      'time': 'Hace 5 horas',
    },
    {
      'id': 3,
      'lat': 16.7469,
      'lng': -93.1193,
      'title': 'Derrumbe',
      'address': 'Carretera a San Cristóbal',
      'type': 'Derrumbe',
      'risk': 'Moderado',
      'status': 'Pendiente',
      'icon': Icons.landslide_rounded,
      'color': Colors.orange,
      'time': 'Hace 1 día',
    },
    {
      'id': 4,
      'lat': 16.7869,
      'lng': -93.1093,
      'title': 'Señalización dañada',
      'address': 'Blvd. Belisario Domínguez',
      'type': 'Señalización',
      'risk': 'Bajo',
      'status': 'Resuelto',
      'icon': Icons.signpost_rounded,
      'color': Colors.purple,
      'time': 'Hace 3 días',
    },
  ];

  @override
  void initState() {
    super.initState();
    _currentLocation = _tuxtlaCenter;
    _checkLocationAndMock();
  }

  Future<void> _checkLocationAndMock() async {
    setState(() => _isCheckingLocation = true);

    // Solicitar permisos de ubicación
    final permissionGranted = await LocationService.requestPermissions();

    if (!permissionGranted && mounted) {
      setState(() => _isCheckingLocation = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Se necesitan permisos de ubicación para usar el mapa'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // Verificar si hay ubicación falsa
    final isMock = await LocationService.checkMockLocation();

    if (isMock && !_hasShownFakeDialog && mounted) {
      _hasShownFakeDialog = true;
      FakeLocationDialog.show(context, onClose: () {
        // Reintentar después de cerrar el diálogo
        _checkLocationAndMock();
      });
    } else if (!isMock && mounted) {
      // Iniciar monitoreo de ubicación en tiempo real
      LocationService.startListening(() {
        if (mounted && !_hasShownFakeDialog) {
          _hasShownFakeDialog = true;
          FakeLocationDialog.show(context, onClose: () {
            _hasShownFakeDialog = false;
            _checkLocationAndMock();
          });
        }
      });
    }

    setState(() => _isCheckingLocation = false);
  }

  void _centerToLocation() async {
    if (_isCheckingLocation) return;

    final isMock = await LocationService.checkMockLocation();
    if (isMock) {
      if (!_hasShownFakeDialog) {
        _hasShownFakeDialog = true;
        FakeLocationDialog.show(context, onClose: () {
          _hasShownFakeDialog = false;
          _centerToLocation();
        });
      }
      return;
    }

    _mapController.move(_currentLocation, 14);
    setState(() {});
  }

  @override
  void dispose() {
    LocationService.stopListening();
    super.dispose();
  }

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
          // Mapa funcional con OpenStreetMap
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _tuxtlaCenter,
              initialZoom: 13,
              minZoom: 10,
              maxZoom: 18,
              onTap: (tapPosition, point) {
                setState(() => _selectedMarkerId = null);
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
                userAgentPackageName: 'com.example.viatux',
              ),
              // Heatmap layer (simulado con círculos)
              if (_showHeatmap)
                CircleLayer(
                  circles: _markers.map((marker) {
                    return CircleMarker(
                      point: LatLng(marker['lat'], marker['lng']),
                      radius: 50,
                      color: (marker['color'] as Color).withOpacity(0.3),
                      borderStrokeWidth: 0,
                      useRadiusInMeter: false,
                    );
                  }).toList(),
                ),
              // Marcadores personalizados
              MarkerLayer(
                markers: _markers.map((marker) {
                  final isSelected = _selectedMarkerId == marker['id'];
                  return Marker(
                    width: resp.wp(8),
                    height: resp.wp(8),
                    point: LatLng(marker['lat'], marker['lng']),
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        setState(() => _selectedMarkerId = marker['id']);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: EdgeInsets.all(resp.wp(isSelected ? 3 : 2)),
                        decoration: BoxDecoration(
                          color: marker['color'],
                          shape: BoxShape.circle,
                          border: isSelected
                              ? Border.all(color: Colors.white, width: 2)
                              : null,
                          boxShadow: [
                            BoxShadow(
                              color: (marker['color'] as Color).withOpacity(0.5),
                              blurRadius: isSelected ? 16 : 12,
                              spreadRadius: isSelected ? 4 : 2,
                            ),
                          ],
                        ),
                        child: Icon(
                          marker['icon'],
                          size: resp.iconSize(isSelected ? 18 : 14),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          // Indicador de carga mientras verifica ubicación
          if (_isCheckingLocation)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(
                      color: AppColors.blueBright,
                    ),
                    SizedBox(height: resp.hp(2)),
                    Text(
                      'Verificando ubicación...',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: resp.sp(14),
                      ),
                    ),
                  ],
                ),
              ),
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
                marker: _markers.firstWhere((m) => m['id'] == _selectedMarkerId),
                onClose: () => setState(() => _selectedMarkerId = null),
              ),
            ),
          // Botones flotantes
          FloatingButtons(
            onCenter: _centerToLocation,
            onHeatmap: () {
              setState(() => _showHeatmap = !_showHeatmap);
            },
            onReport: () {
              Navigator.pop(context);
            },
            showHeatmap: _showHeatmap,
          ),
        ],
      ),
    );
  }
}