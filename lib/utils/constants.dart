import 'dart:ui';

class AppConstants {
  // App Info
  static const String appName = 'EcoGuard AI';
  static const String appVersion = '1.0.0';
  static const String appBuildNumber = '1';
  static const String appDescription = 'Satpam Lingkungan Digital';

  // API Endpoints (Simulation)
  static const String baseUrl = 'https://api.ecoguard.ai';
  static const String energyEndpoint = '/api/v1/energy';
  static const String waterEndpoint = '/api/v1/water';
  static const String aiEndpoint = '/api/v1/ai';
  static const String alertsEndpoint = '/api/v1/alerts';
  static const String reportsEndpoint = '/api/v1/reports';
  static const String usersEndpoint = '/api/v1/users';

  // Colors
  static const Color primaryColor = Color(0xFF2E7D32);
  static const Color secondaryColor = Color(0xFF4CAF50);
  static const Color accentColor = Color(0xFF81C784);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color textColor = Color(0xFF333333);
  static const Color warningColor = Color(0xFFFF9800);
  static const Color dangerColor = Color(0xFFF44336);
  static const Color successColor = Color(0xFF4CAF50);
  static const Color infoColor = Color(0xFF2196F3);

  // Energy Colors
  static const Color energyColor = Color(0xFFFFB300); // Amber
  static const Color waterColor = Color(0xFF2196F3); // Blue
  static const Color emissionsColor = Color(0xFF4CAF50); // Green

  // Thresholds
  static const double energyThresholdHigh = 3000; // kWh
  static const double energyThresholdMedium = 2000; // kWh
  static const double waterThresholdHigh = 40000; // Liters
  static const double waterThresholdMedium = 25000; // Liters
  static const double co2ThresholdHigh = 100; // kg
  static const double co2ThresholdMedium = 50; // kg

  // Conversion Factors
  static const double co2PerKwh = 0.85; // kg CO2 per kWh (Indonesia)
  static const double waterPerPersonPerDay = 150; // liters
  static const double treesPerTonCO2 = 20; // trees per ton CO2
  static const double electricityPricePerKwh = 1500; // Rp per kWh
  static const double waterPricePerLiter = 5; // Rp per liter

  // Eco Score Ranges
  static const int ecoScoreExcellent = 90;
  static const int ecoScoreGood = 75;
  static const int ecoScoreFair = 60;
  static const int ecoScorePoor = 40;

  // Notification IDs
  static const int notificationIdEnergyAlert = 1001;
  static const int notificationIdWaterAlert = 1002;
  static const int notificationIdAiAnalysis = 1003;
  static const int notificationIdDailySummary = 1004;
  static const int notificationIdWeeklyReport = 1005;

  // Storage Keys
  static const String storageKeyUserPrefs = 'user_preferences';
  static const String storageKeyConsumptionData = 'consumption_data';
  static const String storageKeyEcoScore = 'eco_score';
  static const String storageKeyNotifications = 'notifications';
  static const String storageKeyAlerts = 'alerts_history';
  static const String storageKeyReports = 'saved_reports';

  // Date Formats
  static const String dateFormatFull = 'dd MMMM yyyy';
  static const String dateFormatShort = 'dd/MM/yyyy';
  static const String timeFormat = 'HH:mm';
  static const String dateTimeFormat = 'dd/MM/yyyy HH:mm';

  // Default Values
  static const double defaultEnergyConsumption = 2500; // kWh
  static const double defaultWaterConsumption = 30000; // Liters
  static const double defaultCo2Emission = 2125; // kg (2500 * 0.85)
  static const int defaultEcoScore = 70;

  // AI Parameters
  static const int aiAnalysisIntervalHours = 6;
  static const double aiConfidenceThreshold = 0.7;
  static const int maxRecommendations = 5;

  // Chart Colors
  static const List<Color> chartColors = [
    Color(0xFF2E7D32),
    Color(0xFF4CAF50),
    Color(0xFF81C784),
    Color(0xFFC8E6C9),
    Color(0xFFFFB300),
    Color(0xFF2196F3),
    Color(0xFF9C27B0),
  ];

  // Resource Types
  static const List<String> resourceTypes = [
    'electricity',
    'water',
    'emissions',
  ];
  static const List<String> resourceNames = ['Listrik', 'Air', 'Emisi CO₂'];
  static const List<String> resourceUnits = ['kWh', 'L', 'kg'];

  // Alert Types
  static const List<String> alertTypes = [
    'critical',
    'warning',
    'info',
    'success',
  ];
  static const Map<String, String> alertTypeIcons = {
    'critical': '🚨',
    'warning': '⚠️',
    'info': 'ℹ️',
    'success': '✅',
  };

  // SDG Goals
  static const Map<String, String> sdgGoals = {
    'SDG 6': 'Air Bersih dan Sanitasi Layak',
    'SDG 7': 'Energi Bersih dan Terjangkau',
    'SDG 11': 'Kota dan Pemukiman yang Berkelanjutan',
    'SDG 12': 'Konsumsi dan Produksi yang Bertanggung Jawab',
    'SDG 13': 'Penanganan Perubahan Iklim',
  };

  // User Types
  static const List<String> userTypes = [
    'Pertamina Facility',
    'Gedung Perkantoran',
    'Kampus',
    'Sekolah',
    'UMKM',
    'Rumah Tangga',
  ];

  // Building Types
  static const Map<String, double> buildingTypeMultipliers = {
    'office': 1.0,
    'school': 0.8,
    'mall': 1.5,
    'hospital': 1.2,
    'factory': 2.0,
    'hotel': 1.3,
  };

  // Time Ranges
  static const List<String> timeRanges = [
    'Hari Ini',
    'Minggu Ini',
    'Bulan Ini',
    'Tahun Ini',
    'Custom',
  ];

  // Report Types
  static const List<String> reportTypes = [
    'Bulanan',
    'Triwulan',
    'Tahunan',
    'Khusus',
    'ESG',
    'CSR',
  ];

  // Export Formats
  static const List<String> exportFormats = [
    'PDF',
    'Excel',
    'CSV',
    'PPT',
    'JSON',
  ];

  // Feature Flags
  static const bool enableRealTimeMonitoring = true;
  static const bool enableAIInsights = true;
  static const bool enableNotifications = true;
  static const bool enableOfflineMode = true;
  static const bool enableDarkMode = true;

  // URLs
  static const String privacyPolicyUrl = 'https://ecoguard.ai/privacy';
  static const String termsOfServiceUrl = 'https://ecoguard.ai/terms';
  static const String supportEmail = 'support@ecoguard.ai';
  static const String websiteUrl = 'https://ecoguard.ai';

  // Social Media
  static const String instagramUrl = 'https://instagram.com/ecoguard_ai';
  static const String twitterUrl = 'https://twitter.com/ecoguard_ai';
  static const String linkedinUrl = 'https://linkedin.com/company/ecoguard-ai';

  // Localization
  static const String defaultLocale = 'id_ID';
  static const List<String> supportedLocales = ['id_ID', 'en_US'];
}

// Screen Routes
class AppRoutes {
  static const String splash = '/';
  static const String dashboard = '/dashboard';
  static const String monitoring = '/monitoring';
  static const String insights = '/insights';
  static const String alerts = '/alerts';
  static const String ecoScore = '/eco-score';
  static const String csrReport = '/csr-report';
  static const String settings = '/settings';
  static const String profile = '/profile';
  static const String notifications = '/notifications';
  static const String help = '/help';
  static const String about = '/about';
}

// Asset Paths
class AssetPaths {
  static const String images = 'assets/images/';
  static const String icons = 'assets/icons/';
  static const String fonts = 'assets/fonts/';
  static const String sounds = 'assets/sounds/';
  static const String animations = 'assets/animations/';

  // Specific assets
  static const String logo = '${images}logo.png';
  static const String logoWhite = '${images}logo_white.png';
  static const String placeholder = '${images}placeholder.png';
  static const String energyIcon = '${icons}energy.svg';
  static const String waterIcon = '${icons}water.svg';
  static const String emissionsIcon = '${icons}emissions.svg';
  static const String notificationSound = '${sounds}notification.mp3';
}

// Animation Durations
class AnimationDurations {
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration medium = Duration(milliseconds: 350);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration pageTransition = Duration(milliseconds: 300);
}

// API Status Codes
class ApiStatus {
  static const int success = 200;
  static const int created = 201;
  static const int badRequest = 400;
  static const int unauthorized = 401;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int serverError = 500;
}
