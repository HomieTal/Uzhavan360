import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/localization/app_localizations.dart';
import '../../core/state/app_state_controller.dart';
import '../../core/widgets/section_header.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AppStateController>();
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SectionHeader(title: context.tr('notifications'), subtitle: context.tr('notificationsSubtitle')),
        const SizedBox(height: 16),
        ...controller.notifications.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.10),
                  child: Icon(_icon(item.icon)),
                ),
                title: Text(context.tr(item.titleKey), style: const TextStyle(fontWeight: FontWeight.w700)),
                subtitle: Text(context.tr(item.messageKey)),
                trailing: Text(item.timeLabel, style: Theme.of(context).textTheme.labelSmall),
              ),
            ),
          ),
        ),
      ],
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