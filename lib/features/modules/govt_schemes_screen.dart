import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/localization/app_localizations.dart';
import '../../core/state/app_state_controller.dart';
import '../../core/widgets/app_scaffold.dart';
import '../../core/widgets/section_header.dart';

class GovtSchemesScreen extends StatelessWidget {
  const GovtSchemesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AppStateController>();
    return AppScaffold(
      title: context.tr('govtSchemes'),
      body: ListView(
        children: [
          SectionHeader(title: context.tr('govtSchemes'), subtitle: context.tr('govtSchemesSubtitle')),
          const SizedBox(height: 16),
          ...controller.governmentSchemes.map(
            (scheme) => Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text(context.tr(scheme.titleKey), style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800))),
                        Chip(label: Text(context.tr(scheme.statusKey))),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(context.tr(scheme.descriptionKey)),
                    const SizedBox(height: 8),
                    Text('${context.tr('benefits')}: ${context.tr(scheme.benefitKey)}'),
                    Text('${context.tr('eligibility')}: ${context.tr(scheme.eligibilityKey)}'),
                    Text('${context.tr('lastDate')}: ${context.tr(scheme.lastDateKey)}'),
                    const SizedBox(height: 12),
                    SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {}, child: Text(context.tr('applyNow')))),
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
