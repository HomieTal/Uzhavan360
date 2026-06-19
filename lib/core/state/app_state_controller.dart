import 'dart:async';

import 'package:flutter/material.dart';

import '../../data/mock_data_service.dart';
import '../../models/app_models.dart';
import '../localization/localization_service.dart';

class AppStateController extends ChangeNotifier {
  AppStateController._(this._localizationService, this._mockDataService);

  static const demoMobileNumber = '9876543210';
  static const demoOtp = '123456';

  static AppStateController create() {
    final controller = AppStateController._(LocalizationService(), MockDataService());
    controller._bootstrap();
    return controller;
  }

  final LocalizationService _localizationService;
  final MockDataService _mockDataService;

  Locale _locale = const Locale('en');
  ThemeMode _themeMode = ThemeMode.light;
  bool _authenticated = false;
  int _bottomIndex = 0;
  String? _pendingOtp;
  String? _pendingMobile;

  late FarmerProfile profile;
  late List<AppNotificationItem> notifications;
  late List<StorageFacility> storageFacilities;
  late List<BuyerOffer> buyerOffers;
  late List<GovtScheme> governmentSchemes;
  late WeatherSnapshot currentWeather;
  late List<WeatherForecastDay> sevenDayForecast;
  late List<PestScanHistoryItem> pestHistory;

  SoilReport? soilReport;
  CropRecommendation? cropRecommendation;
  bool pumpOn = false;
  bool autoMode = true;
  int moisture = 68;
  bool gsmCallEnabled = true;

  void _bootstrap() {
    profile = _mockDataService.defaultProfile;
    notifications = _mockDataService.notifications;
    storageFacilities = _mockDataService.storageFacilities;
    buyerOffers = _mockDataService.buyerOffers;
    governmentSchemes = _mockDataService.governmentSchemes;
    currentWeather = _mockDataService.currentWeather;
    sevenDayForecast = _mockDataService.sevenDayForecast;
    pestHistory = _mockDataService.pestHistory;
    unawaited(_localizationService.load().then((_) => notifyListeners()));
  }

  String tr(String key, {Map<String, String> args = const {}}) {
    return _localizationService.translate(_locale, key, args: args);
  }

  Locale get locale => _locale;
  ThemeMode get themeMode => _themeMode;
  bool get authenticated => _authenticated;
  int get bottomIndex => _bottomIndex;
  String? get pendingOtp => _pendingOtp;
  String? get pendingMobile => _pendingMobile;

  void toggleLocale() {
    _locale = _locale.languageCode == 'en' ? const Locale('ta') : const Locale('en');
    profile = profile.copyWith(preferredLanguage: _locale.languageCode == 'ta' ? 'தமிழ்' : 'English');
    notifyListeners();
  }

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void setBottomIndex(int index) {
    _bottomIndex = index;
    notifyListeners();
  }

  void sendOtp(String mobileNumber) {
    _pendingMobile = mobileNumber;
    _pendingOtp = demoOtp;
    notifyListeners();
  }

  bool verifyOtp({
    required String mobileNumber,
    required String otp,
    required bool isSignup,
    String? name,
    String? district,
    String? farmSize,
  }) {
    final isDemoLogin = mobileNumber == demoMobileNumber && otp == demoOtp;
    if (!isDemoLogin && (_pendingMobile != mobileNumber || _pendingOtp != otp)) {
      return false;
    }

    if (isSignup) {
      profile = profile.copyWith(
        name: name ?? profile.name,
        district: district ?? profile.district,
        farmSize: farmSize ?? profile.farmSize,
        contactNumber: mobileNumber,
      );
    } else {
      profile = profile.copyWith(contactNumber: mobileNumber);
    }

    _authenticated = true;
    _bottomIndex = 0;
    notifyListeners();
    return true;
  }

  void logout() {
    _authenticated = false;
    _bottomIndex = 0;
    notifyListeners();
  }

  void updateProfile(FarmerProfile value) {
    profile = value;
    notifyListeners();
  }

  void saveSoilReport(SoilReport report, CropRecommendation recommendation) {
    soilReport = report;
    cropRecommendation = recommendation;
    notifyListeners();
  }

  void togglePump(bool value) {
    pumpOn = value;
    notifyListeners();
  }

  void toggleAutoMode(bool value) {
    autoMode = value;
    notifyListeners();
  }

  void setMoisture(int value) {
    moisture = value.clamp(0, 100);
    notifyListeners();
  }

  void toggleGsmCall() {
    gsmCallEnabled = !gsmCallEnabled;
    notifyListeners();
  }
}