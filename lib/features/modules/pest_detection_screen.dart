import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/localization/app_localizations.dart';
import '../../core/state/app_state_controller.dart';
import '../../core/widgets/app_scaffold.dart';
import '../../core/widgets/section_header.dart';

class PestDetectionScreen extends StatelessWidget {
  const PestDetectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final history = context.watch<AppStateController>().pestHistory;
    return AppScaffold(
      title: context.tr('pestDetection'),
      body: ListView(
        children: [
          SectionHeader(title: context.tr('pestDetection'), subtitle: context.tr('pestDetectionSubtitle')),
          const SizedBox(height: 16),
          _actionButtons(context),
          const SizedBox(height: 14),
          _previewCard(context),
          const SizedBox(height: 14),
          _resultCard(context),
          const SizedBox(height: 14),
          SectionHeader(title: context.tr('history'), subtitle: context.tr('pestHistorySubtitle')),
          const SizedBox(height: 10),
          ...history.map(
            (item) => Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                leading: const CircleAvatar(child: Icon(Icons.image_search_rounded)),
                title: Text(context.tr(item.diseaseNameKey), style: const TextStyle(fontWeight: FontWeight.w700)),
                subtitle: Text('${context.tr('confidence')}: ${item.confidence} • ${context.tr(item.treatmentKey)}'),
                trailing: Text(item.timestampLabel, style: Theme.of(context).textTheme.labelSmall),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButtons(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        FilledButton.icon(onPressed: () {}, icon: const Icon(Icons.camera_alt_rounded), label: Text(context.tr('openCamera'))),
        OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.upload_file_rounded), label: Text(context.tr('uploadImage'))),
        OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.photo_camera_back_rounded), label: Text(context.tr('takePhoto'))),
      ],
    );
  }

  Widget _previewCard(BuildContext context) {
    return Container(
      height: 190,
      decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(28)),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.image_outlined, size: 54, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 8),
            Text(context.tr('imagePreview'), style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }

  Widget _resultCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(28)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.tr('aiResult'), style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 10),
          Text('${context.tr('diseaseName')}: ${context.tr('blastDisease')}'),
          Text('${context.tr('confidence')}: 92%'),
          const SizedBox(height: 8),
          Text('${context.tr('recommendedTreatment')}: ${context.tr('blastTreatment')}'),
        ],
      ),
    );
  }
}