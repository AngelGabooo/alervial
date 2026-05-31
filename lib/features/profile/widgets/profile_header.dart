import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        resp.wp(5),
        resp.hp(4),
        resp.wp(5),
        resp.hp(4),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.blueDark,
            AppColors.blueBright,
            const Color(0xFF1565C0),
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // Botones superiores
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.edit_rounded, color: Colors.white),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Editar perfil - Próximamente')),
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: resp.hp(2)),
            // Avatar con glow
            Container(
              width: resp.wp(25),
              height: resp.wp(25),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.4),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
                image: const DecorationImage(
                  image: NetworkImage('https://randomuser.me/api/portraits/men/32.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: resp.hp(1.5)),
            Text(
              'Ángel López',
              style: TextStyle(
                fontSize: resp.sp(24),
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(height: resp.hp(0.5)),
            Container(
              padding: EdgeInsets.symmetric(horizontal: resp.wp(3), vertical: resp.hp(0.3)),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.email_outlined, size: resp.iconSize(14), color: Colors.white70),
                  SizedBox(width: resp.wp(1)),
                  Text(
                    'angel.lopez@email.com',
                    style: TextStyle(fontSize: resp.sp(12), color: Colors.white70),
                  ),
                ],
              ),
            ),
            SizedBox(height: resp.hp(1)),
            Container(
              padding: EdgeInsets.symmetric(horizontal: resp.wp(3), vertical: resp.hp(0.3)),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.verified_rounded, size: resp.iconSize(14), color: Colors.green),
                  SizedBox(width: resp.wp(1)),
                  Text(
                    'Cuenta verificada',
                    style: TextStyle(fontSize: resp.sp(12), color: Colors.green),
                  ),
                ],
              ),
            ),
            SizedBox(height: resp.hp(2)),
            // Badge de nivel
            Container(
              padding: EdgeInsets.symmetric(horizontal: resp.wp(4), vertical: resp.hp(0.5)),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.2),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star_rounded, size: resp.iconSize(16), color: Colors.amber),
                  SizedBox(width: resp.wp(1)),
                  Text(
                    'Miembro desde 2024',
                    style: TextStyle(fontSize: resp.sp(12), color: Colors.amber),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}