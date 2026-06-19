import 'package:flutter/material.dart';

import '../../features/modules/auto_irrigation_screen.dart';
import '../../features/modules/buyer_match_screen.dart';
import '../../features/modules/govt_schemes_screen.dart';
import '../../features/modules/pest_detection_screen.dart';
import '../../features/modules/soil_testing_screen.dart';
import '../../features/modules/smart_seeding_screen.dart';
import '../../features/modules/storage_monitoring_screen.dart';
import '../../features/modules/weather_monitoring_screen.dart';

class AppRoutes {
  static const soilTesting = '/soil-testing';
  static const smartSeeding = '/smart-seeding';
  static const autoIrrigation = '/auto-irrigation';
  static const pestDetection = '/pest-detection';
  static const weatherMonitoring = '/weather-monitoring';
  static const storageMonitoring = '/storage-monitoring';
  static const buyerMatch = '/buyer-match';
  static const govtSchemes = '/govt-schemes';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case soilTesting:
        return MaterialPageRoute(builder: (_) => const SoilTestingScreen());
      case smartSeeding:
        return MaterialPageRoute(builder: (_) => const SmartSeedingScreen());
      case autoIrrigation:
        return MaterialPageRoute(builder: (_) => const AutoIrrigationScreen());
      case pestDetection:
        return MaterialPageRoute(builder: (_) => const PestDetectionScreen());
      case weatherMonitoring:
        return MaterialPageRoute(builder: (_) => const WeatherMonitoringScreen());
      case storageMonitoring:
        return MaterialPageRoute(builder: (_) => const StorageMonitoringScreen());
      case buyerMatch:
        return MaterialPageRoute(builder: (_) => const BuyerMatchScreen());
      case govtSchemes:
        return MaterialPageRoute(builder: (_) => const GovtSchemesScreen());
      default:
        return MaterialPageRoute(builder: (_) => const GovtSchemesScreen());
    }
  }
}