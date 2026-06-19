import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/localization/app_localizations.dart';
import '../../core/navigation/app_routes.dart';
import '../../core/state/app_state_controller.dart';
import '../../core/widgets/feature_card.dart';
import '../../core/widgets/section_header.dart';
import '../../core/widgets/stat_card.dart';
import '../../models/app_models.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AppStateController>();
    final modules = <_DashboardModule>[
      _DashboardModule(context.tr('soilTesting'), context.tr('soilTestingSubtitle'), Icons.science_rounded, const [Color(0xFF2E7D32), Color(0xFF81C784)], AppRoutes.soilTesting),
      _DashboardModule(context.tr('smartSeeding'), context.tr('smartSeedingSubtitle'), Icons.grass_rounded, const [Color(0xFF1B5E20), Color(0xFF43A047)], AppRoutes.smartSeeding),
      _DashboardModule(context.tr('autoIrrigation'), context.tr('autoIrrigationSubtitle'), Icons.water_drop_rounded, const [Color(0xFF00695C), Color(0xFF26A69A)], AppRoutes.autoIrrigation),
      _DashboardModule(context.tr('pestDetection'), context.tr('pestDetectionSubtitle'), Icons.bug_report_rounded, const [Color(0xFF4E342E), Color(0xFF8D6E63)], AppRoutes.pestDetection),
      _DashboardModule(context.tr('weatherMonitoring'), context.tr('weatherMonitoringSubtitle'), Icons.cloud_rounded, const [Color(0xFF1565C0), Color(0xFF64B5F6)], AppRoutes.weatherMonitoring),
      _DashboardModule(context.tr('storageMonitoring'), context.tr('storageMonitoringSubtitle'), Icons.warehouse_rounded, const [Color(0xFF5D4037), Color(0xFFBCAAA4)], AppRoutes.storageMonitoring),
      _DashboardModule(context.tr('buyerMatch'), context.tr('buyerMatchSubtitle'), Icons.handshake_rounded, const [Color(0xFF00695C), Color(0xFF4DB6AC)], AppRoutes.buyerMatch),
      _DashboardModule(context.tr('govtSchemes'), context.tr('govtSchemesSubtitle'), Icons.verified_rounded, const [Color(0xFF2E7D32), Color(0xFFA5D6A7)], AppRoutes.govtSchemes),
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            gradient: LinearGradient(
              colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.tertiary],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white.withValues(alpha: 0.18),
                    child: const Icon(Icons.person_rounded, color: Colors.white),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(controller.profile.name, style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.w800)),
                        Text('${controller.profile.district} • ${controller.profile.farmSize}', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white.withValues(alpha: 0.9))),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: controller.logout,
                    icon: const Icon(Icons.logout_rounded, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Text(context.tr('tagline'), style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w700)),
              const SizedBox(height: 6),
              Text(context.tr('dashboardHeroText'), style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white.withValues(alpha: 0.92))),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.10)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(18)),
                child: const Icon(Icons.cloud_rounded),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(context.tr('weatherSummary'), style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 4),
                    Text(context.tr(controller.currentWeather.summaryKey)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(controller.currentWeather.temperature, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
                  Text('${context.tr('rainProbability')}: ${controller.currentWeather.rainProbability}'),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SectionHeader(title: context.tr('todayAlerts'), subtitle: context.tr('dashboardAlertsSubtitle')),
        const SizedBox(height: 12),
        SizedBox(
          height: 120,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: controller.notifications.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final notification = controller.notifications[index];
              return _AlertCard(notification: notification);
            },
          ),
        ),
        const SizedBox(height: 20),
        SectionHeader(title: context.tr('quickModules'), subtitle: context.tr('quickModulesSubtitle')),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: modules.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            childAspectRatio: 0.95,
          ),
          itemBuilder: (context, index) {
            final module = modules[index];
            return FeatureCard(
              title: module.title,
              subtitle: module.subtitle,
              icon: module.icon,
              gradientColors: module.gradientColors,
              onTap: () => Navigator.of(context).pushNamed(module.route),
            );
          },
        ),
        const SizedBox(height: 18),
        StatCard(title: context.tr('farmOverview'), value: context.tr('farmOverviewValue'), icon: Icons.emoji_nature_rounded, color: Theme.of(context).colorScheme.primary),
      ],
    );
  }
}

class _AlertCard extends StatelessWidget {
  const _AlertCard({required this.notification});

  final AppNotificationItem notification;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(_icon(notification.icon), color: Theme.of(context).colorScheme.primary),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(context.tr(notification.titleKey), style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800)),
              const SizedBox(height: 4),
              Text(context.tr(notification.messageKey), maxLines: 2, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 6),
              Text(notification.timeLabel, style: Theme.of(context).textTheme.labelSmall),
            ],
          ),
        ],
      ),
    );
  }

  IconData _icon(String key) {
    switch (key) {
      case 'bug_report':
        return Icons.bug_report_rounded;
      case 'water_drop':
        return Icons.water_drop_rounded;
      case 'trending_up':
        return Icons.trending_up_rounded;
      default:
        return Icons.cloud_rounded;
    }
  }
}

class _DashboardModule {
  const _DashboardModule(this.title, this.subtitle, this.icon, this.gradientColors, this.route);

  final String title;
  final String subtitle;
  final IconData icon;
  final List<Color> gradientColors;
  final String route;
}