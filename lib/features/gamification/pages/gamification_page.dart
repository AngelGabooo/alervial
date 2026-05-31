import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/services/report_storage_service.dart';
import 'package:viatux/core/utils/responsive.dart';
import 'package:viatux/routes/app_routes.dart';
import '../../home/widgets/bottom_nav_bar.dart';
import '../widgets/level_card.dart';
import '../widgets/badges_section.dart';
import '../widgets/challenges_section.dart';
import '../widgets/leaderboard_section.dart';

class GamificationPage extends StatefulWidget {
  const GamificationPage({super.key});

  @override
  State<GamificationPage> createState() => _GamificationPageState();
}

class _GamificationPageState extends State<GamificationPage> {
  final int _currentIndex = 0;

  int _totalReports = 0;
  int _userLevel = 1;
  int _userXP = 0;
  int _nextLevelXP = 500;

  @override
  void initState() {
    super.initState();
    _loadUserStats();
  }

  void _loadUserStats() {
    final reports = ReportStorageService().reports;
    _totalReports = reports.length;
    _userXP = _totalReports * 100;
    _userLevel = (_userXP ~/ 500) + 1;
    _nextLevelXP = _userLevel * 500;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0A0E27) : const Color(0xFFF0F4F8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: isDark ? Colors.white : AppColors.blueDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Mis Logros',
          style: TextStyle(
            fontSize: resp.sp(20),
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : AppColors.blueDark,
          ),
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: EdgeInsets.only(right: resp.wp(4)),
            decoration: BoxDecoration(
              color: AppColors.blueBright.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.emoji_events_outlined, color: Colors.amber),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _loadUserStats();
          await Future.delayed(const Duration(milliseconds: 500));
        },
        color: AppColors.blueBright,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: resp.wp(5)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: resp.hp(1)),
                    Text(
                      '¡Sigue así, ${_getRankTitle(_userLevel)}!',
                      style: TextStyle(
                        fontSize: resp.sp(14),
                        color: isDark ? Colors.grey[400] : Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: resp.hp(1)),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: LevelCard(
                level: _userLevel,
                currentXP: _userXP,
                nextLevelXP: _nextLevelXP,
                xpProgress: _userXP / _nextLevelXP,
                totalReports: _totalReports,
              ),
            ),
            SliverToBoxAdapter(
              child: BadgesSection(totalReports: _totalReports),
            ),
            SliverToBoxAdapter(
              child: ChallengesSection(totalReports: _totalReports),
            ),
            SliverToBoxAdapter(
              child: LeaderboardSection(
                userXP: _userXP,
                userName: 'Ángel M.',
                userMunicipio: 'Tuxtla Gutiérrez',
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: resp.hp(10))),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false);
          }
        },
      ),
    );
  }

  String _getRankTitle(int level) {
    if (level >= 20) return 'Leyenda Vial';
    if (level >= 15) return 'Guardián de la Ciudad';
    if (level >= 10) return 'Protector Vial';
    if (level >= 5) return 'Ciudadano Activo';
    if (level >= 3) return 'Reportador Inicial';
    return 'Nuevo Recluta';
  }
}