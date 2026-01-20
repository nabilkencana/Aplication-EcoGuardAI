import 'package:ecoguard_ai/screens/monitoring_screen.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class EcoScoreScreen extends StatefulWidget {
  const EcoScoreScreen({super.key});

  @override
  State<EcoScoreScreen> createState() => _EcoScoreScreenState();
}

class _EcoScoreScreenState extends State<EcoScoreScreen> {
  int _currentScore = 78;
  String _currentRank = 'Baik';
  List<Map<String, dynamic>> _scoreHistory = [];
  List<Map<String, dynamic>> _leaderboard = [];
  List<String> _timeRanges = ['Minggu Ini', 'Bulan Ini', 'Tahun Ini'];
  String _selectedRange = 'Minggu Ini';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    // Data simulasi
    _scoreHistory = [
      {'date': 'Sen', 'score': 72, 'trend': 'naik'},
      {'date': 'Sel', 'score': 74, 'trend': 'naik'},
      {'date': 'Rab', 'score': 73, 'trend': 'turun'},
      {'date': 'Kam', 'score': 76, 'trend': 'naik'},
      {'date': 'Jum', 'score': 78, 'trend': 'naik'},
      {'date': 'Sab', 'score': 77, 'trend': 'turun'},
      {'date': 'Min', 'score': 78, 'trend': 'naik'},
    ];

    _leaderboard = [
      {'name': 'PT Pertamina RU V', 'score': 92, 'change': '+3'},
      {'name': 'Universitas Indonesia', 'score': 88, 'change': '+2'},
      {'name': 'Mall Taman Anggrek', 'score': 85, 'change': '-1'},
      {'name': 'Anda', 'score': 78, 'change': '+5'},
      {'name': 'Hotel Santika', 'score': 76, 'change': '+2'},
      {'name': 'Rumah Sakit Siloam', 'score': 72, 'change': '-3'},
      {'name': 'Supermarket Carrefour', 'score': 68, 'change': '0'},
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eco Score & Leaderboard'),
        actions: [
          IconButton(icon: const Icon(Icons.share), onPressed: _shareScore),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Score Card
            _buildScoreCard(),
            const SizedBox(height: 24),

            // Time Range Selector
            _buildTimeRangeSelector(),
            const SizedBox(height: 24),

            // Score History Chart
            _buildScoreChart(),
            const SizedBox(height: 24),

            // Score Breakdown
            _buildScoreBreakdown(),
            const SizedBox(height: 24),

            // Leaderboard
            _buildLeaderboard(),
            const SizedBox(height: 24),

            // Tips Improvement
            _buildImprovementTips(),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreCard() {
    Color scoreColor;
    if (_currentScore >= 90) {
      scoreColor = Colors.green;
    } else if (_currentScore >= 70) {
      scoreColor = Colors.blue;
    } else if (_currentScore >= 50) {
      scoreColor = Colors.orange;
    } else {
      scoreColor = Colors.red;
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text(
              'Eco Score Anda',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 180,
                  height: 180,
                  child: CircularProgressIndicator(
                    value: _currentScore / 100,
                    strokeWidth: 15,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(scoreColor),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      '$_currentScore',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: scoreColor,
                      ),
                    ),
                    Text(
                      _currentRank,
                      style: TextStyle(
                        fontSize: 18,
                        color: scoreColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.trending_up, color: Colors.green),
                const SizedBox(width: 8),
                const Text(
                  'Naik 5 poin dari minggu lalu',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeRangeSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: _timeRanges.map((range) {
        return GestureDetector(
          onTap: () => setState(() => _selectedRange = range),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: _selectedRange == range
                  ? Theme.of(context).primaryColor
                  : Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              range,
              style: TextStyle(
                color: _selectedRange == range ? Colors.white : Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildScoreChart() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Riwayat Eco Score',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: SfCartesianChart(
                primaryXAxis: const CategoryAxis(),
                series: <LineSeries<ChartData, String>>[
                  LineSeries<ChartData, String>(
                    dataSource: _scoreHistory
                        .map(
                          (data) =>
                              ChartData(data['date'], data['score'].toDouble()),
                        )
                        .toList(),
                    xValueMapper: (ChartData data, _) => data.time,
                    yValueMapper: (ChartData data, _) => data.consumption,
                    markerSettings: const MarkerSettings(isVisible: true),
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreBreakdown() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Detail Penilaian',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildBreakdownItem(
              '⚡ Efisiensi Energi',
              28,
              30,
              Colors.amber,
              'Sangat Baik',
            ),
            const SizedBox(height: 12),
            _buildBreakdownItem(
              '💧 Konservasi Air',
              22,
              30,
              Colors.blue,
              'Baik',
            ),
            const SizedBox(height: 12),
            _buildBreakdownItem(
              '🌿 Pengurangan Emisi',
              18,
              25,
              Colors.green,
              'Cukup',
            ),
            const SizedBox(height: 12),
            _buildBreakdownItem(
              '📊 Kepatuhan Standar',
              10,
              15,
              Colors.purple,
              'Perlu Ditingkatkan',
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Score',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  '$_currentScore/100',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBreakdownItem(
    String title,
    int score,
    int max,
    Color color,
    String status,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(title), Text('$score/$max')],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: score / max,
          backgroundColor: Colors.grey[200],
          valueColor: AlwaysStoppedAnimation<Color>(color),
          minHeight: 8,
          borderRadius: BorderRadius.circular(4),
        ),
        const SizedBox(height: 4),
        Text(
          status,
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildLeaderboard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Leaderboard Nasional',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Chip(
                  label: const Text('Top 100'),
                  backgroundColor: Colors.green[100],
                ),
              ],
            ),
            const SizedBox(height: 16),
            ..._leaderboard.map((entry) {
              bool isCurrentUser = entry['name'] == 'Anda';
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isCurrentUser ? Colors.green[50] : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: isCurrentUser
                      ? Border.all(color: Colors.green[100]!)
                      : null,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: _getRankColor(_leaderboard.indexOf(entry) + 1),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${_leaderboard.indexOf(entry) + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entry['name'],
                            style: TextStyle(
                              fontWeight: isCurrentUser
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: isCurrentUser
                                  ? Theme.of(context).primaryColor
                                  : Colors.black,
                            ),
                          ),
                          Text(
                            'Score: ${entry['score']}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: entry['change'].toString().contains('+')
                            ? Colors.green[100]
                            : entry['change'].toString().contains('-')
                            ? Colors.red[100]
                            : Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        entry['change'],
                        style: TextStyle(
                          color: entry['change'].toString().contains('+')
                              ? Colors.green
                              : entry['change'].toString().contains('-')
                              ? Colors.red
                              : Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 16),
            Center(
              child: TextButton(
                onPressed: () {},
                child: const Text('Lihat Ranking Lengkap →'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImprovementTips() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tips Meningkatkan Eco Score',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildTipItem(
              '⚡ Matikan perangkat saat tidak digunakan',
              '+5 poin',
            ),
            const SizedBox(height: 12),
            _buildTipItem('💧 Perbaiki kebocoran air segera', '+8 poin'),
            const SizedBox(height: 12),
            _buildTipItem('🌿 Gunakan energi terbarukan', '+15 poin'),
            const SizedBox(height: 12),
            _buildTipItem('📊 Laporkan data secara rutin', '+3 poin'),
          ],
        ),
      ),
    );
  }

  Widget _buildTipItem(String tip, String points) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(child: Text(tip)),
          const SizedBox(width: 12),
          Chip(
            label: Text(
              points,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
            backgroundColor: Colors.green,
          ),
        ],
      ),
    );
  }

  Color _getRankColor(int rank) {
    switch (rank) {
      case 1:
        return Colors.amber;
      case 2:
        return Colors.grey;
      case 3:
        return Colors.orange;
      default:
        return Colors.grey[400]!;
    }
  }

  void _shareScore() async {
    // Simulasi share score
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Eco Score berhasil dibagikan!')),
    );
  }
}
