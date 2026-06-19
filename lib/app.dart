import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'core/navigation/app_routes.dart';
import 'core/state/app_state_controller.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/auth_screen.dart';

class Uzhavan360App extends StatelessWidget {
  const Uzhavan360App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppStateController>(
      create: (_) => AppStateController.create(),
      child: Consumer<AppStateController>(
        builder: (context, appState, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: appState.tr('appName'),
            locale: appState.locale,
            supportedLocales: const [Locale('en'), Locale('ta')],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            themeMode: appState.themeMode,
            theme: lightTheme,
            darkTheme: darkTheme,
            onGenerateRoute: AppRoutes.onGenerateRoute,
            home: const AuthGate(),
          );
        },
      ),
    );
  }
}
