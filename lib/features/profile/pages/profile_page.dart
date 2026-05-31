import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';
import 'package:viatux/routes/app_routes.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_section.dart';
import '../widgets/profile_stat_card.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _notificationsEnabled = true;
  bool _locationEnabled = true;

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0A0E27) : const Color(0xFFF0F4F8),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Header con gradiente y datos del usuario
          const SliverToBoxAdapter(child: ProfileHeader()),

          // Tarjetas de estadísticas
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: resp.wp(5), vertical: resp.hp(1.5)),
              child: Row(
                children: [
                  Expanded(child: ProfileStatCard(value: '24', label: 'Reportes', icon: Icons.report_problem_rounded, color: Colors.orange)),
                  SizedBox(width: resp.wp(3)),
                  Expanded(child: ProfileStatCard(value: '18', label: 'Resueltos', icon: Icons.check_circle_rounded, color: AppColors.softGreen)),
                  SizedBox(width: resp.wp(3)),
                  Expanded(child: ProfileStatCard(value: 'Nv. 5', label: 'Nivel', icon: Icons.emoji_events_rounded, color: Colors.amber)),
                ],
              ),
            ),
          ),

          // Sección: Configuración de cuenta
          SliverToBoxAdapter(
            child: ProfileSection(
              title: 'Configuración de cuenta',
              icon: Icons.settings_rounded,
              children: [
                _buildMenuItem(
                  context,
                  icon: Icons.edit_rounded,
                  title: 'Editar nombre',
                  subtitle: 'Actualiza tu información personal',
                  onTap: () => _showMessage(context, 'Editar nombre'),
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.lock_outline_rounded,
                  title: 'Cambiar contraseña',
                  subtitle: 'Actualiza tu contraseña de acceso',
                  onTap: () => _showMessage(context, 'Cambiar contraseña'),
                ),
                _buildSwitchItem(
                  context,
                  icon: Icons.notifications_none_rounded,
                  title: 'Notificaciones',
                  subtitle: 'Recibe alertas de tus reportes',
                  value: _notificationsEnabled,
                  onChanged: (val) => setState(() => _notificationsEnabled = val),
                ),
                _buildSwitchItem(
                  context,
                  icon: Icons.location_on_outlined,
                  title: 'Ubicación',
                  subtitle: 'Permitir acceso a tu ubicación',
                  value: _locationEnabled,
                  onChanged: (val) => setState(() => _locationEnabled = val),
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.help_outline_rounded,
                  title: 'Ayuda',
                  subtitle: 'Preguntas frecuentes y soporte',
                  onTap: () => _showMessage(context, 'Ayuda'),
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.privacy_tip_outlined,
                  title: 'Centro de privacidad',
                  subtitle: 'Gestiona tus datos y privacidad',
                  onTap: () => _showMessage(context, 'Centro de privacidad'),
                ),
              ],
            ),
          ),

          // Sección: Tu actividad
          SliverToBoxAdapter(
            child: ProfileSection(
              title: 'Tu actividad',
              icon: Icons.trending_up_rounded,
              children: [
                _buildMenuItem(
                  context,
                  icon: Icons.bar_chart_rounded,
                  title: 'Mis estadísticas',
                  subtitle: 'Reportes, nivel y logros',
                  onTap: () => Navigator.pushNamed(context, AppRoutes.personalStats),
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.emoji_events_rounded,
                  title: 'Gamificación',
                  subtitle: 'Logros y clasificaciones',
                  onTap: () => Navigator.pushNamed(context, AppRoutes.gamification),
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.favorite_border_rounded,
                  title: 'Mis favoritos',
                  subtitle: 'Reportes guardados',
                  onTap: () => Navigator.pushNamed(context, AppRoutes.favorites),
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.history_rounded,
                  title: 'Historial completo',
                  subtitle: 'Toda tu actividad',
                  onTap: () => Navigator.pushNamed(context, AppRoutes.history),
                ),
              ],
            ),
          ),

          // Botón cerrar sesión
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: resp.wp(5), vertical: resp.hp(3)),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: OutlinedButton.icon(
                  onPressed: () => _showLogoutDialog(context),
                  icon: const Icon(Icons.logout_rounded, color: Colors.red),
                  label: const Text('Cerrar sesión', style: TextStyle(color: Colors.red)),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.red, width: 1.5),
                    padding: EdgeInsets.symmetric(vertical: resp.hp(1.5)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: resp.hp(4))),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListTile(
      leading: Container(
        width: resp.wp(10),
        height: resp.wp(10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.blueBright, AppColors.blueDark],
          ),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: resp.iconSize(20), color: Colors.white),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: resp.sp(15),
          fontWeight: FontWeight.w600,
          color: isDark ? Colors.white : Colors.black87,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: resp.sp(12),
          color: isDark ? Colors.grey[500] : Colors.grey[600],
        ),
      ),
      trailing: Icon(Icons.chevron_right_rounded, color: Colors.grey),
      onTap: onTap,
    );
  }

  Widget _buildSwitchItem(BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListTile(
      leading: Container(
        width: resp.wp(10),
        height: resp.wp(10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.blueBright, AppColors.blueDark],
          ),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: resp.iconSize(20), color: Colors.white),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: resp.sp(15),
          fontWeight: FontWeight.w600,
          color: isDark ? Colors.white : Colors.black87,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: resp.sp(12),
          color: isDark ? Colors.grey[500] : Colors.grey[600],
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.blueBright,
      ),
      onTap: () => onChanged(!value),
    );
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$message - Próximamente'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.blueBright,
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        title: const Text('Cerrar sesión'),
        content: const Text('¿Estás seguro de que deseas cerrar sesión?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Cerrar sesión'),
          ),
        ],
      ),
    );
  }
}