import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class HomeHeader extends StatelessWidget {
  final String userName;
  final VoidCallback onNotificationTap;
  final VoidCallback onProfileTap;
  final VoidCallback? onSearchTap; // 👈 NUEVO: Callback para búsqueda

  const HomeHeader({
    super.key,
    required this.userName,
    required this.onNotificationTap,
    required this.onProfileTap,
    this.onSearchTap, // 👈 NUEVO
  });

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
            const Color(0xFF0A2540),
            const Color(0xFF1565C0),
          ]
              : [
            AppColors.blueDark,
            AppColors.blueBright,
          ],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.blueBright.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 5),
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
            resp.hp(3),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  // Avatar
                  GestureDetector(
                    onTap: onProfileTap,
                    child: Hero(
                      tag: 'profile',
                      child: Container(
                        width: resp.wp(13),
                        height: resp.wp(13),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.4),
                              blurRadius: 12,
                              spreadRadius: 2,
                            ),
                          ],
                          gradient: const LinearGradient(
                            colors: [Colors.white, Colors.white70],
                          ),
                        ),
                        child: ClipOval(
                          child: isDark
                              ? Icon(
                            Icons.person_rounded,
                            size: resp.iconSize(30),
                            color: AppColors.blueDark,
                          )
                              : Image.network(
                            'https://randomuser.me/api/portraits/men/32.jpg',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.person_rounded,
                                size: resp.iconSize(30),
                                color: AppColors.blueDark,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  resp.sizedBox(width: 16),
                  // Saludo
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '¡Hola!',
                          style: TextStyle(
                            fontSize: resp.sp(14),
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                        Text(
                          userName,
                          style: TextStyle(
                            fontSize: resp.sp(22),
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 👉 NUEVO: Botón de búsqueda
                  if (onSearchTap != null)
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                        ),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.search_rounded,
                          size: resp.iconSize(22),
                          color: Colors.white,
                        ),
                        onPressed: onSearchTap,
                      ),
                    ),
                  resp.sizedBox(width: 8),
                  // Notificaciones
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                          ),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.notifications_outlined,
                            size: resp.iconSize(22),
                            color: Colors.white,
                          ),
                          onPressed: onNotificationTap,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          padding: EdgeInsets.all(resp.wp(0.8)),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '3',
                            style: TextStyle(
                              fontSize: resp.sp(9),
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              resp.sizedBox(height: 20),
              // Barra de búsqueda moderna (ahora clickeable)
              GestureDetector(
                onTap: onSearchTap,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: resp.wp(4),
                    vertical: resp.hp(0.8),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search_rounded,
                        size: resp.iconSize(20),
                        color: AppColors.blueBright,
                      ),
                      resp.sizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Buscar incidencias, lugares o municipios...',
                          style: TextStyle(
                            fontSize: resp.sp(14),
                            color: Colors.grey[500],
                          ),
                        ),
                      ),
                      Container(
                        width: 1,
                        height: resp.hp(3),
                        color: Colors.grey[300],
                      ),
                      resp.sizedBox(width: 8),
                      Icon(
                        Icons.mic_rounded,
                        size: resp.iconSize(20),
                        color: AppColors.blueBright,
                      ),
                    ],
                  ),
                ),
              ),
              resp.sizedBox(height: 12),
              // Mini tarjeta de estadísticas
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: resp.wp(4),
                  vertical: resp.hp(0.8),
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildMiniStat(
                      context,
                      value: '24',
                      label: 'Reportes',
                      icon: Icons.report_problem_rounded,
                    ),
                    Container(
                      width: 1,
                      height: resp.hp(3),
                      color: Colors.white.withOpacity(0.3),
                    ),
                    _buildMiniStat(
                      context,
                      value: '18',
                      label: 'Resueltos',
                      icon: Icons.check_circle_rounded,
                    ),
                    Container(
                      width: 1,
                      height: resp.hp(3),
                      color: Colors.white.withOpacity(0.3),
                    ),
                    _buildMiniStat(
                      context,
                      value: '75%',
                      label: 'Efectividad',
                      icon: Icons.trending_up_rounded,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMiniStat(
      BuildContext context, {
        required String value,
        required String label,
        required IconData icon,
      }) {
    final resp = context.resp;

    return Row(
      children: [
        Icon(
          icon,
          size: resp.iconSize(16),
          color: Colors.white.withOpacity(0.9),
        ),
        resp.sizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: resp.sp(14),
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: resp.sp(10),
                color: Colors.white.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ],
    );
  }
}