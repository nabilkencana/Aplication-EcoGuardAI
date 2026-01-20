import 'dart:math';
import 'package:intl/intl.dart';

class AIService {
  // Singleton instance
  static final AIService _instance = AIService._internal();
  factory AIService() => _instance;
  AIService._internal();

  // Machine Learning Prediction
  Future<Map<String, dynamic>> predictConsumption(
    String resourceType,
    DateTime date,
  ) async {
    // Simulasi prediksi AI
    await Future.delayed(const Duration(milliseconds: 500));

    final random = Random();
    final baseValue = resourceType == 'electricity' ? 3000 : 40000;
    final variation = (random.nextDouble() * 0.3) - 0.15; // -15% to +15%
    final predicted = baseValue * (1 + variation);

    return {
      'predicted_value': predicted,
      'confidence_level': (0.8 + random.nextDouble() * 0.15), // 80-95%
      'peak_hours': _getPeakHours(resourceType),
      'recommendations': _generateRecommendations(resourceType, predicted),
      'timestamp': DateTime.now(),
    };
  }

  // AI Recommendation Engine
  Future<List<Map<String, dynamic>>> getRecommendations(
    Map<String, dynamic> consumptionData,
  ) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final recommendations = <Map<String, dynamic>>[];
    final random = Random();

    // Energy recommendations
    if (consumptionData['electricity'] > 2500) {
      recommendations.add({
        'id': 'energy_001',
        'title': 'Optimalkan Penggunaan AC',
        'description':
            'Matikan AC 30 menit sebelum jam pulang kerja. Potensi penghematan: 15-20%',
        'category': 'energy',
        'priority': 'high',
        'estimated_savings': 450000,
        'implementation_time': '2 hari',
        'difficulty': 'easy',
        'impact_score': 8.5,
      });
    }

    // Water recommendations
    if (consumptionData['water'] > 35000) {
      recommendations.add({
        'id': 'water_001',
        'title': 'Deteksi Kebocoran Air',
        'description':
            'Pola penggunaan abnormal terdeteksi pada malam hari. Periksa instalasi pipa.',
        'category': 'water',
        'priority': 'critical',
        'estimated_savings': 750000,
        'implementation_time': '1 minggu',
        'difficulty': 'medium',
        'impact_score': 9.2,
      });
    }

    // General recommendations
    recommendations.addAll([
      {
        'id': 'general_001',
        'title': 'Penjadwalan Perangkat',
        'description':
            'Atur perangkat elektronik agar mati secara otomatis setelah jam operasional',
        'category': 'energy',
        'priority': 'medium',
        'estimated_savings': 280000,
        'implementation_time': '3 hari',
        'difficulty': 'easy',
        'impact_score': 7.8,
      },
      {
        'id': 'general_002',
        'title': 'Penerangan Efisien',
        'description': 'Ganti lampu konvensional dengan LED. ROI: 8 bulan',
        'category': 'energy',
        'priority': 'medium',
        'estimated_savings': 1200000,
        'implementation_time': '2 minggu',
        'difficulty': 'medium',
        'impact_score': 8.9,
      },
    ]);

    // Sort by priority and impact
    recommendations.sort((a, b) {
      final priorityOrder = {'critical': 0, 'high': 1, 'medium': 2, 'low': 3};
      final priorityCompare = priorityOrder[a['priority']]!.compareTo(
        priorityOrder[b['priority']]!,
      );
      if (priorityCompare != 0) return priorityCompare;
      return b['impact_score'].compareTo(a['impact_score']);
    });

    return recommendations;
  }

  // Environmental Impact Calculator
  Map<String, dynamic> calculateEnvironmentalImpact(
    double energySaved,
    double waterSaved,
  ) {
    // Conversion factors
    const double co2PerKwh = 0.85; // kg CO2 per kWh (Indonesia average)
    const double treesPerTonCO2 = 20; // trees needed to absorb 1 ton CO2
    const double waterPerPersonPerDay = 150; // liters

    final co2Reduced = energySaved * co2PerKwh;
    final treesEquivalent = co2Reduced / 1000 * treesPerTonCO2;
    final peopleWaterEquivalent = waterSaved / waterPerPersonPerDay;
    final daysWaterEquivalent = waterSaved / (waterPerPersonPerDay * 100);

    return {
      'co2_reduced_kg': co2Reduced,
      'trees_equivalent': treesEquivalent,
      'people_water_equivalent': peopleWaterEquivalent,
      'days_water_equivalent': daysWaterEquivalent,
      'car_equivalent': co2Reduced / 2.3, // kg CO2 per liter gasoline
      'phone_charges': energySaved * 1000 / 5, // 5W per charge
    };
  }

  // Pattern Analysis
  Future<Map<String, dynamic>> analyzeUsagePattern(
    List<Map<String, dynamic>> usageData,
  ) async {
    if (usageData.isEmpty) {
      return {
        'status': 'insufficient_data',
        'message': 'Data tidak cukup untuk analisis',
      };
    }

    await Future.delayed(const Duration(milliseconds: 800));

    final random = Random();
    final anomalies = random.nextInt(3);
    final efficiencyScore = 60 + random.nextDouble() * 30;
    final peakDetection = random.nextDouble() > 0.5;

    final patterns = <Map<String, dynamic>>[];

    if (peakDetection) {
      patterns.add({
        'type': 'peak_usage',
        'description': 'Puncak konsumsi terdeteksi pada jam 16:00-18:00',
        'severity': 'high',
        'confidence': 0.87,
      });
    }

    if (anomalies > 0) {
      patterns.add({
        'type': 'anomaly',
        'description': '$anomalies anomali terdeteksi dalam pola penggunaan',
        'severity': anomalies > 1 ? 'high' : 'medium',
        'confidence': 0.92,
      });
    }

    patterns.add({
      'type': 'efficiency_trend',
      'description': efficiencyScore > 75
          ? 'Efisiensi meningkat dalam 30 hari terakhir'
          : 'Perlu perbaikan dalam efisiensi',
      'severity': efficiencyScore > 75 ? 'low' : 'medium',
      'confidence': 0.78,
    });

    return {
      'analysis_date': DateTime.now(),
      'efficiency_score': efficiencyScore,
      'patterns_detected': patterns,
      'anomaly_count': anomalies,
      'recommendations_count': 2 + random.nextInt(3),
      'next_analysis': DateTime.now().add(const Duration(days: 7)),
    };
  }

  // Smart Alert Generation
  Future<List<Map<String, dynamic>>> generateAlerts(
    Map<String, dynamic> currentData,
  ) async {
    await Future.delayed(const Duration(milliseconds: 200));

    final alerts = <Map<String, dynamic>>[];
    final random = Random();

    // Check for critical thresholds
    if (currentData['electricity'] > 3500) {
      alerts.add({
        'id': 'alert_${DateTime.now().millisecondsSinceEpoch}_001',
        'type': 'critical',
        'title': '⚡ Konsumsi Listrik Tinggi',
        'message':
            'Konsumsi listrik melebihi 3500 kWh. Segera tinjau penggunaan perangkat.',
        'timestamp': DateTime.now(),
        'resource': 'electricity',
        'threshold': 3500,
        'current_value': currentData['electricity'],
        'actions': ['review_usage', 'schedule_audit'],
      });
    }

    if (currentData['water'] > 50000) {
      alerts.add({
        'id': 'alert_${DateTime.now().millisecondsSinceEpoch}_002',
        'type': 'warning',
        'title': '💧 Konsumsi Air Berlebihan',
        'message':
            'Konsumsi air melebihi 50,000L. Periksa kemungkinan kebocoran.',
        'timestamp': DateTime.now(),
        'resource': 'water',
        'threshold': 50000,
        'current_value': currentData['water'],
        'actions': ['check_leaks', 'review_schedule'],
      });
    }

    // Generate random alerts (for simulation)
    if (random.nextDouble() > 0.7) {
      alerts.add({
        'id': 'alert_${DateTime.now().millisecondsSinceEpoch}_003',
        'type': 'info',
        'title': '📊 Analisis AI Selesai',
        'message':
            'AI telah menganalisis pola penggunaan dan menemukan peluang penghematan baru.',
        'timestamp': DateTime.now(),
        'resource': 'system',
        'actions': ['view_insights', 'apply_recommendations'],
      });
    }

    return alerts;
  }

  // Helper methods
  List<String> _getPeakHours(String resourceType) {
    if (resourceType == 'electricity') {
      return ['16:00', '17:00', '18:00'];
    } else {
      return ['07:00', '08:00', '12:00'];
    }
  }

  List<Map<String, dynamic>> _generateRecommendations(
    String resourceType,
    double predictedValue,
  ) {
    if (resourceType == 'electricity') {
      return [
        {
          'action': 'shift_peak_usage',
          'description': 'Pindahkan penggunaan ke luar jam puncak',
          'savings': '15-20%',
        },
        {
          'action': 'upgrade_equipment',
          'description': 'Pertimbangkan peralatan hemat energi',
          'savings': '25-30%',
        },
      ];
    } else {
      return [
        {
          'action': 'fix_leaks',
          'description': 'Perbaiki kebocoran segera',
          'savings': '20-40%',
        },
        {
          'action': 'install_sensors',
          'description': 'Pasang sensor aliran air',
          'savings': '10-15%',
        },
      ];
    }
  }

  // Calculate Eco Score
  Future<Map<String, dynamic>> calculateEcoScore(
    Map<String, dynamic> metrics,
  ) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final energyScore = _calculateResourceScore(
      metrics['energy_efficiency'] ?? 0,
      80,
      20,
    );
    final waterScore = _calculateResourceScore(
      metrics['water_efficiency'] ?? 0,
      85,
      15,
    );
    final emissionScore = _calculateResourceScore(
      metrics['emission_reduction'] ?? 0,
      70,
      30,
    );

    final totalScore =
        (energyScore * 0.4 + waterScore * 0.3 + emissionScore * 0.3).round();

    String rank;
    if (totalScore >= 90) {
      rank = 'Sangat Baik';
    } else if (totalScore >= 75) {
      rank = 'Baik';
    } else if (totalScore >= 60) {
      rank = 'Cukup';
    } else {
      rank = 'Perlu Perbaikan';
    }

    return {
      'total_score': totalScore,
      'rank': rank,
      'breakdown': {
        'energy': energyScore,
        'water': waterScore,
        'emissions': emissionScore,
      },
      'comparison': {
        'average': 65,
        'top_performer': 92,
        'percentile': ((totalScore / 100) * 100).round(),
      },
      'last_updated': DateTime.now(),
    };
  }

  double _calculateResourceScore(double value, double target, double weight) {
    final score = (value / target * 100).clamp(0, 100);
    return score * (weight / 100);
  }
}
