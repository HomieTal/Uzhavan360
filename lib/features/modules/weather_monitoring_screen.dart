import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/localization/app_localizations.dart';
import '../../core/state/app_state_controller.dart';
import '../../core/widgets/app_scaffold.dart';
import '../../core/widgets/section_header.dart';

class WeatherMonitoringScreen extends StatelessWidget {
  const WeatherMonitoringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AppStateController>();
    return AppScaffold(
      title: context.tr('weatherMonitoring'),
      body: ListView(
        children: [
          SectionHeader(title: context.tr('weatherMonitoring'), subtitle: context.tr('weatherMonitoringSubtitle')),
          const SizedBox(height: 16),
          FilledButton.icon(onPressed: () {}, icon: const Icon(Icons.gps_fixed_rounded), label: Text(context.tr('useGpsLocation'))),
          const SizedBox(height: 16),
          _WeatherHero(controller: controller),
          const SizedBox(height: 12),
          _WeatherStats(controller: controller),
          const SizedBox(height: 16),
          Text(context.tr('yesterdayWeatherSummary'), style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          Card(child: Padding(padding: const EdgeInsets.all(16), child: Text(context.tr('yesterdayWeatherText')))),
          const SizedBox(height: 16),
          Text(context.tr('sevenDayForecast'), style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 10),
          ...controller.sevenDayForecast.map(
            (day) => Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                leading: const CircleAvatar(child: Icon(Icons.cloud_rounded)),
                title: Text(context.tr(day.dayKey), style: const TextStyle(fontWeight: FontWeight.w700)),
                subtitle: Text('${context.tr(day.summaryKey)} • ${context.tr('rainProbability')}: ${day.rainProbability}'),
                trailing: Text(day.temperature, style: const TextStyle(fontWeight: FontWeight.w800)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WeatherHero extends StatelessWidget {
  const _WeatherHero({required this.controller});

  final AppStateController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(colors: [Color(0xFF1565C0), Color(0xFF42A5F5)]),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.tr('currentWeather'), style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w800)),
          const SizedBox(height: 12),
          Text(controller.currentWeather.temperature, style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          Text(context.tr(controller.currentWeather.summaryKey), style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}

class _WeatherStats extends StatelessWidget {
  const _WeatherStats({required this.controller});

  final AppStateController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _WeatherStat(label: context.tr('temperature'), value: controller.currentWeather.temperature)),
        const SizedBox(width: 10),
        Expanded(child: _WeatherStat(label: context.tr('humidity'), value: controller.currentWeather.humidity)),
        const SizedBox(width: 10),
        Expanded(child: _WeatherStat(label: context.tr('windSpeed'), value: controller.currentWeather.windSpeed)),
      ],
    );
  }
}

class _WeatherStat extends StatelessWidget {
  const _WeatherStat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Text(label, textAlign: TextAlign.center, style: Theme.of(context).textTheme.labelMedium),
          const SizedBox(height: 6),
          Text(value, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}
