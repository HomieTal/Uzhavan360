import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/localization/app_localizations.dart';
import '../../core/state/app_state_controller.dart';
import '../../core/widgets/section_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AppStateController>();
    final profile = controller.profile;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SectionHeader(title: context.tr('profile'), subtitle: context.tr('profileSubtitle')),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            color: Theme.of(context).cardColor,
          ),
          child: Column(
            children: [
              CircleAvatar(radius: 38, backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.12), child: const Icon(Icons.person_rounded, size: 36)),
              const SizedBox(height: 14),
              Text(profile.name, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
              Text(profile.district),
              const SizedBox(height: 20),
              _ProfileTile(label: context.tr('farmSize'), value: profile.farmSize),
              _ProfileTile(label: context.tr('preferredLanguage'), value: profile.preferredLanguage),
              _ProfileTile(label: context.tr('contactNumber'), value: profile.contactNumber),
              _ProfileTile(label: context.tr('district'), value: profile.district),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.edit_rounded),
                  label: Text(context.tr('editProfile')),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProfileTile extends StatelessWidget {
  const _ProfileTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(child: Text(label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700))),
          Text(value),
        ],
      ),
    );
  }
}