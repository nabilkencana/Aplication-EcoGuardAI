import '../models/energy_data.dart';
import '../models/water_data.dart';

class SimulationService {
  EnergyData getEnergyData() {
    return EnergyData.fromSimulation();
  }

  WaterData getWaterData() {
    return WaterData.fromSimulation();
  }

  List<Map<String, dynamic>> getAiInsights() {
    return [
      {
        'title': 'Analisis Pola Penggunaan',
        'description': 'AI mendeteksi pola pemborosan pada jam non-operasional',
        'timestamp': DateTime.now().subtract(const Duration(hours: 2)),
      },
      {
        'title': 'Prediksi Konsumsi',
        'description': 'Bulan depan diperkirakan naik 15% tanpa intervensi',
        'timestamp': DateTime.now().subtract(const Duration(days: 1)),
      },
    ];
  }

  Map<String, dynamic> getEnvironmentalImpact() {
    return {
      'treesSaved': 12,
      'co2Reduced': 150,
      'waterSaved': 4200,
      'energySaved': 850,
      'moneySaved': 1250000,
    };
  }

  Map<String, dynamic> getEcoScore() {
    return {
      'score': 78,
      'rank': 'Baik',
      'trend': 'Meningkat',
      'comparison': '20% lebih baik dari rata-rata',
    };
  }
}
