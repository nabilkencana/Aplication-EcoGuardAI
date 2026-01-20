class WaterData {
  final double currentConsumption;
  final double dailyChange;
  final double monthlyAverage;
  final List<Map<String, dynamic>> consumptionHistory;
  final List<Map<String, dynamic>> aiRecommendations;

  WaterData({
    required this.currentConsumption,
    required this.dailyChange,
    required this.monthlyAverage,
    required this.consumptionHistory,
    required this.aiRecommendations,
  });

  factory WaterData.fromSimulation() {
    return WaterData(
      currentConsumption: 27200,
      dailyChange: -12.3,
      monthlyAverage: 30000,
      consumptionHistory: [
        {'day': 'Sen', 'value': 4500},
        {'day': 'Sel', 'value': 4200},
        {'day': 'Rab', 'value': 3900},
        {'day': 'Kam', 'value': 4100},
        {'day': 'Jum', 'value': 3800},
        {'day': 'Sab', 'value': 3500},
        {'day': 'Min', 'value': 3200},
      ],
      aiRecommendations: [
        {
          'title': 'Kebocoran Terdeteksi',
          'description': 'Pola penggunaan abnormal pada malam hari',
          'priority': 'Kritis',
          'impact': 'Potensi pemborosan: 500 L/hari',
        },
        {
          'title': 'Optimalkan Irigasi',
          'description': 'Jadwalkan penyiraman pada pagi/sore hari',
          'priority': 'Sedang',
          'impact': 'Penghematan: 300 L/hari',
        },
      ],
    );
  }
}
