import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/app_state_controller.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.title,
    required this.body,
    this.leading,
    this.actions = const [],
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.bodyPadding = const EdgeInsets.all(16),
    this.showBackButton = true,
  });

  final String title;
  final Widget body;
  final Widget? leading;
  final List<Widget> actions;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final EdgeInsetsGeometry bodyPadding;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AppStateController>();
    return Scaffold(
      extendBody: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        titleSpacing: 16,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
            Text(
              controller.tr('appName'),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Theme.of(context).colorScheme.primary),
            ),
          ],
        ),
        automaticallyImplyLeading: showBackButton,
        leading: leading,
        actions: [
          IconButton(
            tooltip: controller.locale.languageCode == 'en' ? 'தமிழ்' : 'English',
            onPressed: controller.toggleLocale,
            icon: Text(
              controller.locale.languageCode == 'en' ? 'தமிழ்' : 'EN',
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
          IconButton(
            tooltip: controller.themeMode == ThemeMode.light ? 'Dark' : 'Light',
            onPressed: controller.toggleTheme,
            icon: Icon(controller.themeMode == ThemeMode.light ? Icons.dark_mode_rounded : Icons.light_mode_rounded),
          ),
          ...actions,
        ],
      ),
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary.withValues(alpha: 0.06),
              Theme.of(context).scaffoldBackgroundColor,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: bodyPadding,
            child: body,
          ),
        ),
      ),
    );
  }
}