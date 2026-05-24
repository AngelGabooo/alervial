import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../core/widgets/gradient_background.dart';
import '../widgets/role_card.dart';
import '../widgets/role_header.dart';

class RoleSelectionPage extends StatefulWidget {
  const RoleSelectionPage({super.key});

  @override
  State<RoleSelectionPage> createState() => _RoleSelectionPageState();
}

class _RoleSelectionPageState extends State<RoleSelectionPage> {
  String? _selectedRole;

  final List<RoleData> _roles = [
    RoleData(
      id: 'citizen',
      title: 'Ciudadano',
      description: 'Reporta incidencias viales y da seguimiento a tus reportes.',
      icon: Icons.smartphone_rounded,
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF2196F3), Color(0xFF1565C0)],
      ),
    ),
    RoleData(
      id: 'authority',
      title: 'Autoridad',
      description: 'Administra reportes y supervisa incidencias en tiempo real.',
      icon: Icons.dashboard_rounded,
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF4CAF50), Color(0xFF2E7D32)],
      ),
    ),
    RoleData(
      id: 'visitor',
      title: 'Visitante',
      description: 'Consulta incidencias activas sin necesidad de registrarte.',
      icon: Icons.map_rounded,
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF9E9E9E), Color(0xFF616161)],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GradientBackground(
      hasPattern: true,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              const RoleHeader(),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  itemCount: _roles.length,
                  itemBuilder: (context, index) {
                    final role = _roles[index];
                    return RoleCard(
                      role: role,
                      isSelected: _selectedRole == role.id,
                      onTap: () {
                        setState(() {
                          _selectedRole = role.id;
                        });
                        _onRoleSelected(role);
                      },
                    );
                  },
                ),
              ),
              if (_selectedRole != null)
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/welcome');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blueBright,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Continuar',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  'Puedes cambiar este acceso más adelante',
                  style: TextStyle(
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onRoleSelected(RoleData role) {
    debugPrint('Rol seleccionado: ${role.title}');
    // Aquí guardarías el rol seleccionado en Provider o SharedPreferences
  }
}

class RoleData {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final LinearGradient gradient;

  RoleData({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.gradient,
  });
}