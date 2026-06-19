import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/localization/app_localizations.dart';
import '../../core/state/app_state_controller.dart';
import '../../core/widgets/app_scaffold.dart';
import '../../core/widgets/section_header.dart';

class AutoIrrigationScreen extends StatelessWidget {
  const AutoIrrigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AppStateController>();
    return AppScaffold(
      title: context.tr('autoIrrigation'),
      body: ListView(
        children: [
          SectionHeader(title: context.tr('autoIrrigation'), subtitle: context.tr('autoIrrigationSubtitle')),
          const SizedBox(height: 16),
          _WaterLevelCard(moisture: controller.moisture),
          const SizedBox(height: 12),
          _ActionRow(
            controller: controller,
            onPumpOn: () => controller.togglePump(true),
            onPumpOff: () => controller.togglePump(false),
            onCallDevice: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.tr('gsmCallTriggered')))),
          ),
          const SizedBox(height: 12),
          _StatusCard(controller: controller),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Slider(
                  value: controller.moisture.toDouble(),
                  min: 0,
                  max: 100,
                  onChanged: (value) => controller.setMoisture(value.round()),
                ),
              ),
              Text('${controller.moisture}%'),
            ],
          ),
        ],
      ),
    );
  }
}

class _WaterLevelCard extends StatelessWidget {
  const _WaterLevelCard({required this.moisture});

  final int moisture;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(28), color: Theme.of(context).cardColor),
      child: Column(
        children: [
          Text(context.tr('currentMoisture'), style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 16),
          SizedBox(
            height: 180,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(36),
                    border: Border.all(color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2), width: 2),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 700),
                  width: 120,
                  height: math.max(24, 1.6 * moisture),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(34),
                    gradient: const LinearGradient(colors: [Color(0xFF1E88E5), Color(0xFF64B5F6)]),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  child: Text('$moisture%', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionRow extends StatelessWidget {
  const _ActionRow({required this.controller, required this.onPumpOn, required this.onPumpOff, required this.onCallDevice});

  final AppStateController controller;
  final VoidCallback onPumpOn;
  final VoidCallback onPumpOff;
  final VoidCallback onCallDevice;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SwitchListTile(
          value: controller.autoMode,
          onChanged: controller.toggleAutoMode,
          title: Text(context.tr('autoMode')),
        ),
        SwitchListTile(
          value: controller.gsmCallEnabled,
          onChanged: (_) => controller.toggleGsmCall(),
          title: Text(context.tr('gsmCallControl')),
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: onPumpOn,
                child: Text(context.tr('turnOnPump')),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: OutlinedButton(
                onPressed: onPumpOff,
                child: Text(context.tr('turnOffPump')),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: FilledButton.tonalIcon(
            onPressed: onCallDevice,
            icon: const Icon(Icons.call_rounded),
            label: Text(context.tr('callDevice')),
          ),
        ),
      ],
    );
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({required this.controller});

  final AppStateController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(24)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _StatusItem(label: context.tr('pumpStatus'), value: controller.pumpOn ? context.tr('on') : context.tr('off')),
          _StatusItem(label: context.tr('autoMode'), value: controller.autoMode ? context.tr('enabled') : context.tr('disabled')),
          _StatusItem(label: context.tr('gsmCallControl'), value: controller.gsmCallEnabled ? context.tr('enabled') : context.tr('disabled')),
        ],
      ),
    );
  }
}

class _StatusItem extends StatelessWidget {
  const _StatusItem({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: 4),
        Text(value, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800)),
      ],
    );
  }
}