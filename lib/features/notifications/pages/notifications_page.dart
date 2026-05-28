import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';
import '../widgets/notification_header.dart';
import '../widgets/notification_filters.dart';
import '../widgets/notification_card.dart';
import '../widgets/empty_notifications.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();
  String _selectedFilter = 'Todas';
  bool _hasNotifications = true;

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {});
  }

  void _markAllAsRead() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Todas las notificaciones marcadas como leídas'),
        backgroundColor: AppColors.softGreen,
        behavior: SnackBarBehavior.floating,
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _onRefresh,
        color: AppColors.blueBright,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: NotificationHeader(
                onMarkAllRead: _markAllAsRead,
              ),
            ),
            SliverToBoxAdapter(
              child: NotificationFilters(
                selectedFilter: _selectedFilter,
                onFilterSelected: (filter) {
                  setState(() => _selectedFilter = filter);
                },
              ),
            ),
            if (_hasNotifications)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) => const NotificationCard(),
                  childCount: 8,
                ),
              )
            else
              SliverToBoxAdapter(
                child: EmptyNotifications(
                  onRefresh: _onRefresh,
                ),
              ),
            SliverToBoxAdapter(child: SizedBox(height: resp.hp(10))),
          ],
        ),
      ),
    );
  }
}