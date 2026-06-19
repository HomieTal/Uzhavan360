import '../models/app_models.dart';

class MockDataService {
  FarmerProfile get defaultProfile => const FarmerProfile(
        name: 'Muthu Kumar',
        district: 'Thanjavur',
        farmSize: '8 Acres',
        preferredLanguage: 'English',
        contactNumber: '+91 98765 43210',
      );

  List<AppNotificationItem> get notifications => const [
        AppNotificationItem(titleKey: 'rainExpected', messageKey: 'rainExpectedMessage', icon: 'cloud', timeLabel: '10 min ago'),
        AppNotificationItem(titleKey: 'pestDetected', messageKey: 'pestDetectedMessage', icon: 'bug_report', timeLabel: '1 hr ago'),
        AppNotificationItem(titleKey: 'irrigationRequired', messageKey: 'irrigationRequiredMessage', icon: 'water_drop', timeLabel: '3 hr ago'),
        AppNotificationItem(titleKey: 'marketPriceIncreased', messageKey: 'marketPriceIncreasedMessage', icon: 'trending_up', timeLabel: 'Today'),
      ];

  WeatherSnapshot get currentWeather => const WeatherSnapshot(
        temperature: '31°C',
        humidity: '72%',
        rainProbability: '68%',
        windSpeed: '12 km/h',
        summaryKey: 'weatherSummaryText',
      );

  List<WeatherForecastDay> get sevenDayForecast => const [
        WeatherForecastDay(dayKey: 'today', summaryKey: 'partlyCloudy', temperature: '31°C', rainProbability: '25%'),
        WeatherForecastDay(dayKey: 'tomorrow', summaryKey: 'rainShowers', temperature: '29°C', rainProbability: '78%'),
        WeatherForecastDay(dayKey: 'dayAfterTomorrow', summaryKey: 'cloudy', temperature: '30°C', rainProbability: '44%'),
        WeatherForecastDay(dayKey: 'day4', summaryKey: 'sunny', temperature: '33°C', rainProbability: '12%'),
        WeatherForecastDay(dayKey: 'day5', summaryKey: 'stormAlert', temperature: '28°C', rainProbability: '84%'),
        WeatherForecastDay(dayKey: 'day6', summaryKey: 'sunny', temperature: '34°C', rainProbability: '10%'),
        WeatherForecastDay(dayKey: 'day7', summaryKey: 'partlyCloudy', temperature: '32°C', rainProbability: '22%'),
      ];

  List<StorageFacility> get storageFacilities => const [
        StorageFacility(nameKey: 'storageFacility1', distance: '2.4 km', availableCapacity: '82%', contactNumber: '+91 94444 10001'),
        StorageFacility(nameKey: 'storageFacility2', distance: '4.1 km', availableCapacity: '67%', contactNumber: '+91 94444 10002'),
        StorageFacility(nameKey: 'storageFacility3', distance: '6.3 km', availableCapacity: '91%', contactNumber: '+91 94444 10003'),
        StorageFacility(nameKey: 'storageFacility4', distance: '8.0 km', availableCapacity: '55%', contactNumber: '+91 94444 10004'),
      ];

  List<BuyerOffer> get buyerOffers => const [
        BuyerOffer(buyerName: 'SpiceLeaf Restaurants', buyerTypeKey: 'buyerTypeRestaurant', requiredQuantity: '200 kg', offeredPrice: '₹38/kg', contactNumber: '+91 90000 11111'),
        BuyerOffer(buyerName: 'GreenStar Hotels', buyerTypeKey: 'buyerTypeHotel', requiredQuantity: '350 kg', offeredPrice: '₹41/kg', contactNumber: '+91 90000 22222'),
        BuyerOffer(buyerName: 'UrbanNest Apartments', buyerTypeKey: 'buyerTypeApartment', requiredQuantity: '120 kg', offeredPrice: '₹36/kg', contactNumber: '+91 90000 33333'),
        BuyerOffer(buyerName: 'FreshMart Retail', buyerTypeKey: 'buyerTypeRetail', requiredQuantity: '500 kg', offeredPrice: '₹43/kg', contactNumber: '+91 90000 44444'),
        BuyerOffer(buyerName: 'A2B Foods', buyerTypeKey: 'buyerTypeProcessing', requiredQuantity: '800 kg', offeredPrice: '₹45/kg', contactNumber: '+91 90000 55555'),
      ];

  List<GovtScheme> get governmentSchemes => const [
        GovtScheme(titleKey: 'schemePmKisan', descriptionKey: 'schemePmKisanDescription', benefitKey: 'schemePmKisanBenefit', eligibilityKey: 'schemePmKisanEligibility', lastDateKey: 'schemePmKisanLastDate', statusKey: 'schemeOpen'),
        GovtScheme(titleKey: 'schemeSolarPump', descriptionKey: 'schemeSolarPumpDescription', benefitKey: 'schemeSolarPumpBenefit', eligibilityKey: 'schemeSolarPumpEligibility', lastDateKey: 'schemeSolarPumpLastDate', statusKey: 'schemeNew'),
        GovtScheme(titleKey: 'schemeCropInsurance', descriptionKey: 'schemeCropInsuranceDescription', benefitKey: 'schemeCropInsuranceBenefit', eligibilityKey: 'schemeCropInsuranceEligibility', lastDateKey: 'schemeCropInsuranceLastDate', statusKey: 'schemeOpen'),
        GovtScheme(titleKey: 'schemeStorageSubsidy', descriptionKey: 'schemeStorageSubsidyDescription', benefitKey: 'schemeStorageSubsidyBenefit', eligibilityKey: 'schemeStorageSubsidyEligibility', lastDateKey: 'schemeStorageSubsidyLastDate', statusKey: 'schemeHot'),
      ];

  List<PestScanHistoryItem> get pestHistory => const [
        PestScanHistoryItem(diseaseNameKey: 'blastDisease', confidence: '92%', treatmentKey: 'blastTreatment', timestampLabel: 'Today, 8:40 AM', icon: 'warning'),
        PestScanHistoryItem(diseaseNameKey: 'leafCurl', confidence: '88%', treatmentKey: 'leafCurlTreatment', timestampLabel: 'Yesterday, 6:20 PM', icon: 'local_florist'),
        PestScanHistoryItem(diseaseNameKey: 'stemBorer', confidence: '84%', treatmentKey: 'stemBorerTreatment', timestampLabel: '22 Jun', icon: 'bug_report'),
      ];

  SoilReport generateSoilReport(double nitrogen, double phosphorus, double potassium, double ph) {
    final score = ((100 - ((nitrogen - 45).abs() + (phosphorus - 35).abs() + (potassium - 42).abs()) / 3) + (100 - ((ph - 6.8).abs() * 12))).round();
    final healthScore = score.clamp(45, 98);
    final lowCount = [nitrogen, phosphorus, potassium].where((value) => value < 35).length;
    final highCount = [nitrogen, phosphorus, potassium].where((value) => value > 60).length;
    final status = lowCount == 0 && highCount == 0
        ? 'balanced'
        : highCount > lowCount
            ? 'high'
            : 'low';

    final recommendations = <String>[
      if (nitrogen < 35) 'nitrogenBoost',
      if (phosphorus < 35) 'phosphorusBoost',
      if (potassium < 35) 'potassiumBoost',
      if (ph < 6.3) 'raisePh',
      if (ph > 7.6) 'lowerPh',
      if (nitrogen >= 35 && phosphorus >= 35 && potassium >= 35) 'balancedSoil',
    ];

    return SoilReport(
      nitrogen: nitrogen,
      phosphorus: phosphorus,
      potassium: potassium,
      ph: ph,
      healthScore: healthScore,
      npkStatus: status,
      recommendations: recommendations,
    );
  }

  CropRecommendation generateCropRecommendation(SoilReport report) {
    final recommended = report.healthScore >= 80
        ? ['cropPaddy', 'cropGroundnut', 'cropMillets', 'cropMaize']
        : report.ph < 6.5
            ? ['cropMillets', 'cropGroundnut', 'cropMaize']
            : ['cropPaddy', 'cropGroundnut', 'cropMillets'];
    final avoid = report.healthScore >= 80
        ? ['cropCotton', 'cropSugarcane']
        : ['cropWaterIntensive', 'cropSensitiveVegetables'];
    final confidence = report.healthScore >= 80 ? 94 : report.healthScore >= 65 ? 86 : 72;
    return CropRecommendation(recommendedCrops: recommended, avoidCrops: avoid, confidence: confidence);
  }
}