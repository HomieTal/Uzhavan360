import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/localization/app_localizations.dart';
import '../../core/state/app_state_controller.dart';
import '../../core/widgets/app_scaffold.dart';
import '../../core/widgets/section_header.dart';
import '../../core/widgets/stat_card.dart';
import '../../data/mock_data_service.dart';
import '../../models/app_models.dart';

class SoilTestingScreen extends StatefulWidget {
  const SoilTestingScreen({super.key});

  @override
  State<SoilTestingScreen> createState() => _SoilTestingScreenState();
}

class _SoilTestingScreenState extends State<SoilTestingScreen> {
  final _nitrogenController = TextEditingController(text: '45');
  final _phosphorusController = TextEditingController(text: '35');
  final _potassiumController = TextEditingController(text: '42');
  final _phController = TextEditingController(text: '6.8');
  SoilReport? _report;
  CropRecommendation? _recommendation;

  @override
  void dispose() {
    _nitrogenController.dispose();
    _phosphorusController.dispose();
    _potassiumController.dispose();
    _phController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AppStateController>();
    return AppScaffold(
      title: context.tr('soilTesting'),
      body: ListView(
        children: [
          SectionHeader(title: context.tr('soilTesting'), subtitle: context.tr('soilTestingSubtitle')),
          const SizedBox(height: 16),
          _inputField(context, _nitrogenController, context.tr('nitrogen')),
          const SizedBox(height: 12),
          _inputField(context, _phosphorusController, context.tr('phosphorus')),
          const SizedBox(height: 12),
          _inputField(context, _potassiumController, context.tr('potassium')),
          const SizedBox(height: 12),
          _inputField(context, _phController, context.tr('ph')),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              final service = MockDataService();
              final report = service.generateSoilReport(
                double.tryParse(_nitrogenController.text) ?? 0,
                double.tryParse(_phosphorusController.text) ?? 0,
                double.tryParse(_potassiumController.text) ?? 0,
                double.tryParse(_phController.text) ?? 0,
              );
              final recommendation = service.generateCropRecommendation(report);
              controller.saveSoilReport(report, recommendation);
              setState(() {
                _report = report;
                _recommendation = recommendation;
              });
            },
            child: Text(context.tr('generateReport')),
          ),
          const SizedBox(height: 18),
          if (_report != null) ...[
            StatCard(title: context.tr('soilHealthScore'), value: '${_report!.healthScore}', icon: Icons.verified_rounded),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _InfoCard(
                    title: context.tr('npkStatus'),
                    value: _statusLabel(context, _report!.npkStatus),
                    color: Colors.green,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _InfoCard(
                    title: context.tr('ph'),
                    value: _report!.ph.toStringAsFixed(1),
                    color: Colors.teal,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _ReportCard(title: context.tr('recommendations'), items: _report!.recommendations.map((item) => context.tr(item)).toList()),
            if (_recommendation != null) ...[
              const SizedBox(height: 12),
              _ReportCard(title: context.tr('recommendedCrops'), items: _recommendation!.recommendedCrops.map((crop) => context.tr(crop)).toList()),
            ],
          ],
        ],
      ),
    );
  }

  Widget _inputField(BuildContext context, TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: label, prefixIcon: const Icon(Icons.grain_rounded)),
    );
  }

  String _statusLabel(BuildContext context, String status) {
    switch (status) {
      case 'low':
        return context.tr('soilStatus.low');
      case 'high':
        return context.tr('soilStatus.high');
      default:
        return context.tr('soilStatus.balanced');
    }
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.value, required this.color});

  final String title;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(22)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.labelMedium),
          const SizedBox(height: 6),
          Text(value, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}

class _ReportCard extends StatelessWidget {
  const _ReportCard({required this.title, required this.items});

  final String title;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 12),
          Wrap(spacing: 8, runSpacing: 8, children: items.map((item) => Chip(label: Text(item))).toList()),
        ],
      ),
    );
  }
}
