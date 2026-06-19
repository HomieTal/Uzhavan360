import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/localization/app_localizations.dart';
import '../../core/state/app_state_controller.dart';
import '../../core/widgets/app_scaffold.dart';
import '../../core/widgets/section_header.dart';
import '../../models/app_models.dart';

class SmartSeedingScreen extends StatefulWidget {
  const SmartSeedingScreen({super.key});

  @override
  State<SmartSeedingScreen> createState() => _SmartSeedingScreenState();
}

class _SmartSeedingScreenState extends State<SmartSeedingScreen> {
  final _soilReportController = TextEditingController(text: 'Balanced soil, pH 6.8');

  @override
  void dispose() {
    _soilReportController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AppStateController>();
    final recommendation = controller.cropRecommendation;

    return AppScaffold(
      title: context.tr('smartSeeding'),
      body: ListView(
        children: [
          SectionHeader(title: context.tr('smartSeeding'), subtitle: context.tr('smartSeedingSubtitle')),
          const SizedBox(height: 16),
          TextField(
            controller: _soilReportController,
            maxLines: 3,
            decoration: InputDecoration(labelText: context.tr('soilReport'), prefixIcon: const Icon(Icons.note_alt_rounded)),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: [
                const Icon(Icons.psychology_alt_rounded),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    context.tr('aiRecommendationSection'),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          if (recommendation == null)
            _EmptyState(message: context.tr('seedingEmptyState'))
          else
            _RecommendationSummary(recommendation: recommendation),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final report = controller.soilReport ?? const SoilReport(
            nitrogen: 45,
            phosphorus: 35,
            potassium: 42,
            ph: 6.8,
            healthScore: 86,
            npkStatus: 'balanced',
            recommendations: ['balancedSoil'],
          );
          final value = MockRecommendationBuilder.recommendation(report);
          controller.saveSoilReport(report, value);
          setState(() {});
        },
        icon: const Icon(Icons.auto_fix_high_rounded),
        label: Text(context.tr('getRecommendation')),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(24)),
      child: Column(
        children: [
          Icon(Icons.grass_rounded, size: 42, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 12),
          Text(message, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _RecommendationSummary extends StatelessWidget {
  const _RecommendationSummary({required this.recommendation});

  final CropRecommendation recommendation;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _RecommendationPanel(
          title: context.tr('recommendedCrops'),
          items: recommendation.recommendedCrops.map((crop) => context.tr(crop)).toList(),
          accent: Colors.green,
        ),
        const SizedBox(height: 12),
        _RecommendationPanel(
          title: context.tr('avoidCrops'),
          items: recommendation.avoidCrops.map((crop) => context.tr(crop)).toList(),
          accent: Colors.red,
        ),
        const SizedBox(height: 12),
        _ConfidenceCard(confidence: recommendation.confidence),
      ],
    );
  }
}

class _RecommendationPanel extends StatelessWidget {
  const _RecommendationPanel({required this.title, required this.items, required this.accent});

  final String title;
  final List<String> items;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: accent.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 10),
          Wrap(spacing: 8, runSpacing: 8, children: items.map((item) => Chip(label: Text(item))).toList()),
        ],
      ),
    );
  }
}

class _ConfidenceCard extends StatelessWidget {
  const _ConfidenceCard({required this.confidence});

  final int confidence;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(24)),
      child: Row(
        children: [
          Expanded(child: Text(context.tr('confidence'), style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800))),
          Text('$confidence%', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}

class MockRecommendationBuilder {
  static CropRecommendation recommendation(SoilReport report) {
    final recommended = report.healthScore >= 80
        ? ['cropPaddy', 'cropGroundnut', 'cropMillets', 'cropMaize']
        : report.ph < 6.5
            ? ['cropMillets', 'cropGroundnut', 'cropMaize']
            : ['cropPaddy', 'cropGroundnut', 'cropMillets'];
    final avoid = report.healthScore >= 80 ? ['cropCotton', 'cropSugarcane'] : ['cropWaterIntensive', 'cropSensitiveVegetables'];
    final confidence = report.healthScore >= 80 ? 94 : report.healthScore >= 65 ? 86 : 72;
    return CropRecommendation(recommendedCrops: recommended, avoidCrops: avoid, confidence: confidence);
  }
}
