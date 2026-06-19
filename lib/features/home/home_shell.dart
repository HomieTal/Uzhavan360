import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/localization/app_localizations.dart';
import '../../core/state/app_state_controller.dart';
import '../../core/widgets/app_scaffold.dart';
import '../dashboard/dashboard_screen.dart';
import '../market/market_screen.dart';
import '../notifications/notifications_screen.dart';
import '../profile/profile_screen.dart';

class HomeShell extends StatelessWidget {
  const HomeShell({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AppStateController>();
    final pages = [
      const DashboardScreen(),
      const NotificationsScreen(),
      const MarketScreen(),
      const ProfileScreen(),
    ];

    return AppScaffold(
      title: context.tr('appName'),
      showBackButton: false,
      bodyPadding: EdgeInsets.zero,
      body: IndexedStack(index: controller.bottomIndex, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: controller.bottomIndex,
        onTap: controller.setBottomIndex,
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.home_rounded), label: context.tr('home')),
          BottomNavigationBarItem(icon: const Icon(Icons.notifications_rounded), label: context.tr('notifications')),
          BottomNavigationBarItem(icon: const Icon(Icons.storefront_rounded), label: context.tr('market')),
          BottomNavigationBarItem(icon: const Icon(Icons.person_rounded), label: context.tr('profile')),
        ],
      ),
    );
  }
}