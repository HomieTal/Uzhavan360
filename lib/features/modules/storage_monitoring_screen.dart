import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/localization/app_localizations.dart';
import '../../core/state/app_state_controller.dart';
import '../../core/widgets/app_scaffold.dart';
import '../../core/widgets/section_header.dart';

class StorageMonitoringScreen extends StatefulWidget {
  const StorageMonitoringScreen({super.key});

  @override
  State<StorageMonitoringScreen> createState() => _StorageMonitoringScreenState();
}

class _StorageMonitoringScreenState extends State<StorageMonitoringScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AppStateController>();
    final facilities = controller.storageFacilities.where((facility) {
      return context.tr(facility.nameKey).toLowerCase().contains(_query.toLowerCase());
    }).toList();

    return AppScaffold(
      title: context.tr('storageMonitoring'),
      body: ListView(
        children: [
          SectionHeader(title: context.tr('storageMonitoring'), subtitle: context.tr('storageMonitoringSubtitle')),
          const SizedBox(height: 14),
          TextField(
            decoration: InputDecoration(labelText: context.tr('search'), prefixIcon: const Icon(Icons.search_rounded)),
            onChanged: (value) => setState(() => _query = value),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              FilterChip(label: Text(context.tr('filter')), selected: true, onSelected: (_) {}),
              FilterChip(label: Text(context.tr('map')), selected: false, onSelected: (_) {}),
            ],
          ),
          const SizedBox(height: 16),
          ...facilities.map(
            (facility) => Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text(context.tr(facility.nameKey), style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800))),
                        FilledButton.tonal(onPressed: () {}, child: Text(context.tr('map'))),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text('${context.tr('distance')}: ${facility.distance}'),
                    Text('${context.tr('availableCapacity')}: ${facility.availableCapacity}'),
                    Text('${context.tr('contactNumber')}: ${facility.contactNumber}'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
