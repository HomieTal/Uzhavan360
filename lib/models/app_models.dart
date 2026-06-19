class FarmerProfile {
  const FarmerProfile({
    required this.name,
    required this.district,
    required this.farmSize,
    required this.preferredLanguage,
    required this.contactNumber,
  });

  final String name;
  final String district;
  final String farmSize;
  final String preferredLanguage;
  final String contactNumber;

  FarmerProfile copyWith({
    String? name,
    String? district,
    String? farmSize,
    String? preferredLanguage,
    String? contactNumber,
  }) {
    return FarmerProfile(
      name: name ?? this.name,
      district: district ?? this.district,
      farmSize: farmSize ?? this.farmSize,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
      contactNumber: contactNumber ?? this.contactNumber,
    );
  }
}

class SoilReport {
  const SoilReport({
    required this.nitrogen,
    required this.phosphorus,
    required this.potassium,
    required this.ph,
    required this.healthScore,
    required this.npkStatus,
    required this.recommendations,
  });

  final double nitrogen;
  final double phosphorus;
  final double potassium;
  final double ph;
  final int healthScore;
  final String npkStatus;
  final List<String> recommendations;
}

class CropRecommendation {
  const CropRecommendation({
    required this.recommendedCrops,
    required this.avoidCrops,
    required this.confidence,
  });

  final List<String> recommendedCrops;
  final List<String> avoidCrops;
  final int confidence;
}

class AppNotificationItem {
  const AppNotificationItem({
    required this.titleKey,
    required this.messageKey,
    required this.icon,
    required this.timeLabel,
  });

  final String titleKey;
  final String messageKey;
  final String icon;
  final String timeLabel;
}

class WeatherSnapshot {
  const WeatherSnapshot({
    required this.temperature,
    required this.humidity,
    required this.rainProbability,
    required this.windSpeed,
    required this.summaryKey,
  });

  final String temperature;
  final String humidity;
  final String rainProbability;
  final String windSpeed;
  final String summaryKey;
}

class WeatherForecastDay {
  const WeatherForecastDay({
    required this.dayKey,
    required this.summaryKey,
    required this.temperature,
    required this.rainProbability,
  });

  final String dayKey;
  final String summaryKey;
  final String temperature;
  final String rainProbability;
}

class StorageFacility {
  const StorageFacility({
    required this.nameKey,
    required this.distance,
    required this.availableCapacity,
    required this.contactNumber,
  });

  final String nameKey;
  final String distance;
  final String availableCapacity;
  final String contactNumber;
}

class BuyerOffer {
  const BuyerOffer({
    required this.buyerName,
    required this.buyerTypeKey,
    required this.requiredQuantity,
    required this.offeredPrice,
    required this.contactNumber,
  });

  final String buyerName;
  final String buyerTypeKey;
  final String requiredQuantity;
  final String offeredPrice;
  final String contactNumber;
}

class GovtScheme {
  const GovtScheme({
    required this.titleKey,
    required this.descriptionKey,
    required this.benefitKey,
    required this.eligibilityKey,
    required this.lastDateKey,
    required this.statusKey,
  });

  final String titleKey;
  final String descriptionKey;
  final String benefitKey;
  final String eligibilityKey;
  final String lastDateKey;
  final String statusKey;
}

class PestScanHistoryItem {
  const PestScanHistoryItem({
    required this.diseaseNameKey,
    required this.confidence,
    required this.treatmentKey,
    required this.timestampLabel,
    required this.icon,
  });

  final String diseaseNameKey;
  final String confidence;
  final String treatmentKey;
  final String timestampLabel;
  final String icon;
}