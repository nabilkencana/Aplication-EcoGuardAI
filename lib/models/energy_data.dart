class EnergyData {
  final double currentConsumption;
  final double dailyChange;
  final double monthlyAverage;
  final List<Map<String, dynamic>> consumptionHistory;
  final List<Map<String, dynamic>> aiRecommendations;

  EnergyData({
    required this.currentConsumption,
    required this.dailyChange,
    required this.monthlyAverage,
    required this.consumptionHistory,
    required this.aiRecommendations,
  });

  factory EnergyData.fromSimulation() {
    return EnergyData(
      currentConsumption: 2850,
      dailyChange: -8.5,
      monthlyAverage: 3200,
      consumptionHistory: [
        {'time': '00:00', 'value': 120},
        {'time': '04:00', 'value': 90},
        {'time': '08:00', 'value': 280},
        {'time': '12:00', 'value': 320},
        {'time': '16:00', 'value': 410},
        {'time': '20:00', 'value': 350},
        {'time': '24:00', 'value': 180},
      ],
      aiRecommendations: [
        {
          'title': 'Optimalkan Penggunaan AC',
          'description': 'Matikan AC 1 jam sebelum jam pulang kerja',
          'priority': 'Tinggi',
          'impact': 'Penghematan: 120 kWh/bulan',
        },
        {
          'title': 'Penerangan Berlebihan',
          'description': '27% lampu menyala di area tidak terpakai',
          'priority': 'Sedang',
          'impact': 'Penghematan: 80 kWh/bulan',
        },
      ],
    );
  }
}
