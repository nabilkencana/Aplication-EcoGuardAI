import 'package:flutter/material.dart';

class InsightsScreen extends StatefulWidget {
  const InsightsScreen({super.key});

  @override
  State<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends State<InsightsScreen> {
  final List<Map<String, dynamic>> _aiInsights = [
    {
      'title': '⚡ Puncak Konsumsi Listrik',
      'description': 'Konsumsi meningkat 27% di luar jam operasional (19:00-22:00)',
      'impact': 'Potensi penghematan: Rp 450.000/bulan',
      'recommendation': 'Jadwalkan perangkat non-esensial di luar jam puncak',
      'priority': 'Tinggi',
      'icon': Icons.bolt,
      'color': Colors.amber,
    },
    {
      'title': '💧 Kebocoran Air Terdeteksi',
      'description': 'Pola penggunaan air abnormal terdeteksi antara 02:00-04:00',
      'impact': 'Kerugian air: ~500 L/hari',
      'recommendation': 'Periksa instalasi pipa dan keran',
      'priority': 'Kritis',
      'icon': Icons.water_damage,
      'color': Colors.blue,
    },
    {
      'title': '🌿 Emisi Berlebih',
      'description': 'Emisi CO₂ meningkat 15% dibandingkan bulan lalu',
      'impact': 'Setara dengan 8 pohon dewasa',
      'recommendation': 'Optimalkan penggunaan AC dan lampu',
      'priority': 'Sedang',
      'icon': Icons.cloud,
      'color': Colors.green,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Insights'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _refreshInsights(),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // AI Insight Header
          Card(
            color: Colors.blue[50],
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Icon(Icons.psychology, color: Colors.blue),
                      SizedBox(width: 8),
                      Text(
                        'EcoGuard AI Menganalisis',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'AI menganalisis pola penggunaan Anda dan memberikan rekomendasi cerdas untuk meningkatkan efisiensi',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Chip(
                        label: const Text('Machine Learning'),
                        backgroundColor: Colors.blue[100],
                      ),
                      Chip(
                        label: const Text('Pattern Recognition'),
                        backgroundColor: Colors.green[100],
                      ),
                      Chip(
                        label: const Text('Predictive Analytics'),
                        backgroundColor: Colors.amber[100],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Insights List
          const Text(
            'Insights Terbaru',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ..._aiInsights.map((insight) => _buildInsightCard(insight)),
          const SizedBox(height: 24),

          // Predictive Analysis
          _buildPredictiveAnalysis(),
        ],
      ),
    );
  }

  Widget _buildInsightCard(Map<String, dynamic> insight) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: insight['color'].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(insight['icon'], color: insight['color']),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        insight['title'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        insight['description'],
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                Chip(
                  label: Text(insight['priority']),
                  backgroundColor: _getPriorityColor(insight['priority']),
                  labelStyle: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.savings, size: 20, color: Colors.green),
                  const SizedBox(width: 8),
                  Expanded(child: Text(insight['impact'])),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Rekomendasi: ${insight['recommendation']}',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('Tandai Selesai'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Terapkan'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPredictiveAnalysis() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.trending_up, color: Colors.purple),
                SizedBox(width: 8),
                Text(
                  'Analisis Prediktif',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Berdasarkan pola penggunaan, AI memprediksi:',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            DataTable(
              columns: const [
                DataColumn(label: Text('Parameter')),
                DataColumn(label: Text('Prediksi')),
                DataColumn(label: Text('Rekomendasi')),
              ],
              rows: [
                DataRow(cells: [
                  const DataCell(Text('Bulan Depan')),
                  DataCell(Text(
                    '↑ 15%',
                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                  )),
                  const DataCell(Text('Optimalkan AC')),
                ]),
                DataRow(cells: [
                  const DataCell(Text('Biaya Listrik')),
                  DataCell(Text(
                    'Rp 3.2M',
                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                  )),
                  const DataCell(Text('Implementasi Solar Panel')),
                ]),
                DataRow(cells: [
                  const DataCell(Text('Emisi CO₂')),
                  DataCell(Text(
                    '↓ 8%',
                    style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                  )),
                  const DataCell(Text('Pertahankan pola hemat')),
                ]),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'Kritis':
        return Colors.red;
      case 'Tinggi':
        return Colors.orange;
      case 'Sedang':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  void _refreshInsights() {
    // Simulasi refresh data
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('AI sedang menganalisis data terbaru...'),
      ),
    );
  }
}