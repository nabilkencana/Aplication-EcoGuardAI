import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MonitoringScreen extends StatefulWidget {
  const MonitoringScreen({super.key});

  @override
  State<MonitoringScreen> createState() => _MonitoringScreenState();
}

class _MonitoringScreenState extends State<MonitoringScreen> {
  String _selectedTimeRange = 'Hari Ini';
  final List<String> _timeRanges = [
    'Hari Ini',
    'Minggu Ini',
    'Bulan Ini',
    'Tahun Ini',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Monitoring Real-Time')),
      body: Column(
        children: [
          // Time Range Selector
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: _timeRanges.map((range) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: ChoiceChip(
                      label: Text(range),
                      selected: _selectedTimeRange == range,
                      onSelected: (selected) {
                        setState(() => _selectedTimeRange = range);
                      },
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // Charts Section
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildEnergyChart(),
                const SizedBox(height: 24),
                _buildWaterChart(),
                const SizedBox(height: 24),
                _buildComparisonTable(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnergyChart() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.bolt, color: Colors.amber),
                SizedBox(width: 8),
                Text(
                  'Konsumsi Listrik',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: SfCartesianChart(
                primaryXAxis: const CategoryAxis(),
                series: <LineSeries<ChartData, String>>[
                  LineSeries<ChartData, String>(
                    dataSource: [
                      ChartData('00:00', 120),
                      ChartData('04:00', 90),
                      ChartData('08:00', 280),
                      ChartData('12:00', 320),
                      ChartData('16:00', 410),
                      ChartData('20:00', 350),
                      ChartData('24:00', 180),
                    ],
                    xValueMapper: (ChartData data, _) => data.time,
                    yValueMapper: (ChartData data, _) => data.consumption,
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Hari Ini',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      '2,850 kWh',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('vs Kemarin', style: TextStyle(color: Colors.grey)),
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_downward,
                          color: Colors.green,
                          size: 16,
                        ),
                        SizedBox(width: 4),
                        Text(
                          '-8.5%',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWaterChart() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.water_drop, color: Colors.blue),
                SizedBox(width: 8),
                Text(
                  'Konsumsi Air',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: SfCartesianChart(
                primaryXAxis: const CategoryAxis(),
                series: <ColumnSeries<ChartData, String>>[
                  ColumnSeries<ChartData, String>(
                    dataSource: [
                      ChartData('Sen', 4500),
                      ChartData('Sel', 4200),
                      ChartData('Rab', 3900),
                      ChartData('Kam', 4100),
                      ChartData('Jum', 3800),
                      ChartData('Sab', 3500),
                      ChartData('Min', 3200),
                    ],
                    xValueMapper: (ChartData data, _) => data.time,
                    yValueMapper: (ChartData data, _) => data.consumption,
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Minggu Ini',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      '27,200 L',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'vs Minggu Lalu',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_downward,
                          color: Colors.green,
                          size: 16,
                        ),
                        SizedBox(width: 4),
                        Text(
                          '-12.3%',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComparisonTable() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Perbandingan dengan Standar',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Table(
              columnWidths: const {
                0: FlexColumnWidth(3),
                1: FlexColumnWidth(2),
                2: FlexColumnWidth(2),
                3: FlexColumnWidth(2),
              },
              border: TableBorder.all(color: Colors.grey[300]!),
              children: [
                TableRow(
                  decoration: BoxDecoration(color: Colors.grey[100]),
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text('Parameter', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text('Anda', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text('Standar', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text('Status', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                _buildTableRow(
                  'Listrik/kapita',
                  '2.8 kWh',
                  '3.5 kWh',
                  'Baik',
                  Colors.green,
                ),
                _buildTableRow(
                  'Air/kapita',
                  '120 L',
                  '150 L',
                  'Sangat Baik',
                  Colors.green,
                ),
                _buildTableRow(
                  'Emisi CO₂',
                  '45 kg',
                  '60 kg',
                  'Baik',
                  Colors.green,
                ),
                _buildTableRow(
                  'Puncak Listrik',
                  '410 kW',
                  '350 kW',
                  'Perlu Perbaikan',
                  Colors.orange,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TableRow _buildTableRow(
    String param,
    String value,
    String standard,
    String status,
    Color color,
  ) {
    return TableRow(
      children: [
        Padding(padding: const EdgeInsets.all(8), child: Text(param)),
        Padding(padding: const EdgeInsets.all(8), child: Text(value)),
        Padding(padding: const EdgeInsets.all(8), child: Text(standard)),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Chip(
            label: Text(
              status,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
            backgroundColor: color,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          ),
        ),
      ],
    );
  }
}

class ChartData {
  ChartData(this.time, this.consumption);
  final String time;
  final double consumption;
}
