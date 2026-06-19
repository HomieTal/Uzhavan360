import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/localization/app_localizations.dart';
import '../../core/state/app_state_controller.dart';
import '../../core/widgets/app_scaffold.dart';
import '../../core/widgets/section_header.dart';
import '../home/home_shell.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateController>(
      builder: (context, controller, _) {
        return controller.authenticated ? const HomeShell() : const AuthScreen();
      },
    );
  }
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController = TabController(length: 2, vsync: this);
  final _loginMobileController = TextEditingController(text: AppStateController.demoMobileNumber);
  final _loginOtpController = TextEditingController(text: AppStateController.demoOtp);
  final _signupNameController = TextEditingController();
  final _signupDistrictController = TextEditingController();
  final _signupFarmController = TextEditingController();
  final _signupMobileController = TextEditingController(text: AppStateController.demoMobileNumber);
  final _signupOtpController = TextEditingController(text: AppStateController.demoOtp);

  @override
  void dispose() {
    _tabController.dispose();
    _loginMobileController.dispose();
    _loginOtpController.dispose();
    _signupNameController.dispose();
    _signupDistrictController.dispose();
    _signupFarmController.dispose();
    _signupMobileController.dispose();
    _signupOtpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AppStateController>();
    return AppScaffold(
      title: context.tr('appName'),
      showBackButton: false,
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.tertiary],
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(Icons.agriculture_rounded, color: Colors.white, size: 32),
                ),
                const SizedBox(height: 18),
                Text(context.tr('tagline'), style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                Text(context.tr('authHeroText'), style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white.withValues(alpha: 0.92))),
              ],
            ),
          ),
          const SizedBox(height: 20),
          TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: context.tr('login')),
              Tab(text: context.tr('signup')),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 580,
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildLoginForm(context, controller),
                _buildSignupForm(context, controller),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context, AppStateController controller) {
    return ListView(
      children: [
        const SizedBox(height: 8),
        SectionHeader(title: context.tr('welcomeBack'), subtitle: context.tr('loginPrompt')),
        const SizedBox(height: 16),
        TextField(
          controller: _loginMobileController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(labelText: context.tr('mobileNumber'), prefixIcon: const Icon(Icons.phone_android_rounded)),
        ),
        const SizedBox(height: 12),
        ElevatedButton.icon(
          onPressed: () {
            if (_loginMobileController.text.trim().length >= 10) {
              controller.sendOtp(_loginMobileController.text.trim());
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.tr('otpSent'))));
            }
          },
          icon: const Icon(Icons.sms_rounded),
          label: Text(context.tr('sendOtp')),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _loginOtpController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: context.tr('otp'),
            prefixIcon: const Icon(Icons.lock_rounded),
            helperText: '${context.tr('demoOtp')}: ${AppStateController.demoOtp}',
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            final success = controller.verifyOtp(
              mobileNumber: _loginMobileController.text.trim(),
              otp: _loginOtpController.text.trim(),
              isSignup: false,
            );
            if (!success) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.tr('invalidOtp'))));
            }
          },
          child: Text(context.tr('signIn')),
        ),
        const SizedBox(height: 16),
        _buildAuthNote(context),
      ],
    );
  }

  Widget _buildSignupForm(BuildContext context, AppStateController controller) {
    return ListView(
      children: [
        const SizedBox(height: 8),
        SectionHeader(title: context.tr('signup'), subtitle: context.tr('signupPrompt')),
        const SizedBox(height: 16),
        TextField(controller: _signupNameController, decoration: InputDecoration(labelText: context.tr('farmerName'), prefixIcon: const Icon(Icons.person_rounded))),
        const SizedBox(height: 12),
        TextField(controller: _signupDistrictController, decoration: InputDecoration(labelText: context.tr('district'), prefixIcon: const Icon(Icons.location_city_rounded))),
        const SizedBox(height: 12),
        TextField(controller: _signupFarmController, decoration: InputDecoration(labelText: context.tr('farmSize'), prefixIcon: const Icon(Icons.landscape_rounded))),
        const SizedBox(height: 12),
        TextField(
          controller: _signupMobileController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(labelText: context.tr('mobileNumber'), prefixIcon: const Icon(Icons.phone_android_rounded)),
        ),
        const SizedBox(height: 12),
        ElevatedButton.icon(
          onPressed: () {
            if (_signupMobileController.text.trim().length >= 10) {
              controller.sendOtp(_signupMobileController.text.trim());
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.tr('otpSent'))));
            }
          },
          icon: const Icon(Icons.sms_rounded),
          label: Text(context.tr('sendOtp')),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _signupOtpController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: context.tr('otp'),
            prefixIcon: const Icon(Icons.lock_rounded),
            helperText: '${context.tr('demoOtp')}: ${AppStateController.demoOtp}',
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            final success = controller.verifyOtp(
              mobileNumber: _signupMobileController.text.trim(),
              otp: _signupOtpController.text.trim(),
              isSignup: true,
              name: _signupNameController.text.trim(),
              district: _signupDistrictController.text.trim(),
              farmSize: _signupFarmController.text.trim(),
            );
            if (!success) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.tr('invalidOtp'))));
            }
          },
          child: Text(context.tr('createAccount')),
        ),
        const SizedBox(height: 16),
        _buildAuthNote(context),
      ],
    );
  }

  Widget _buildAuthNote(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline_rounded, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(child: Text(context.tr('authMockNote'))),
        ],
      ),
    );
  }
}