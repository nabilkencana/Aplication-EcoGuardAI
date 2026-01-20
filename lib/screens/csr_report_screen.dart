import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CSRReportScreen extends StatefulWidget {
  const CSRReportScreen({super.key});

  @override
  State<CSRReportScreen> createState() => _CSRReportScreenState();
}

class _CSRReportScreenState extends State<CSRReportScreen> {
  final List<String> _reportTypes = [
    'Bulanan',
    'Triwulan',
    'Tahunan',
    'Khusus',
  ];
  String _selectedReportType = 'Bulanan';
  final List<String> _sdgGoals = [
    'SDG 7: Energi Bersih',
    'SDG 6: Air Bersih',
    'SDG 13: Penanganan Perubahan Iklim',
    'SDG 12: Konsumsi Berkelanjutan',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Laporan CSR & ESG'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: _downloadReport,
          ),
          IconButton(icon: const Icon(Icons.print), onPressed: _printReport),
        ],
      ),
      body: Column(
        children: [
          // Report Type Selector
          Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _reportTypes.map((type) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(type),
                      selected: _selectedReportType == type,
                      onSelected: (selected) {
                        setState(() => _selectedReportType = type);
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Report Summary
                _buildReportSummary(),
                const SizedBox(height: 24),

                // Environmental Impact
                _buildEnvironmentalImpact(),
                const SizedBox(height: 24),

                // SDG Goals
                _buildSDGGoals(),
                const SizedBox(height: 24),

                // Financial Savings
                _buildFinancialSavings(),
                const SizedBox(height: 24),

                // Recommendations
                _buildRecommendations(),
                const SizedBox(height: 24),

                // Export Section
                _buildExportSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportSummary() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.business, color: Colors.blue),
                SizedBox(width: 12),
                Text(
                  'Ringkasan Laporan CSR',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Table(
              columnWidths: const {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(3),
              },
              children: [
                _buildTableRow('Periode Laporan', 'November 2024'),
                _buildTableRow(
                  'Tanggal Dibuat',
                  DateFormat('dd MMMM yyyy').format(DateTime.now()),
                ),
                _buildTableRow('Status', 'Disetujui'),
                _buildTableRow('Versi', '1.2'),
                _buildTableRow('Disiapkan Oleh', 'Tim EcoGuard AI'),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Laporan ini menunjukkan capaian keberlanjutan dan dampak lingkungan '
              'yang dihasilkan melalui implementasi EcoGuard AI.',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEnvironmentalImpact() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dampak Lingkungan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildImpactCard(
                    '⚡ Energi Tersimpan',
                    '12,850 kWh',
                    'Setara dengan 150 rumah',
                    Colors.amber,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildImpactCard(
                    '💧 Air Tersimpan',
                    '45,200 L',
                    'Setara dengan 3 kolam renang',
                    Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildImpactCard(
                    '🌿 CO₂ Berkurang',
                    '8.5 ton',
                    'Setara dengan 200 pohon',
                    Colors.green,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildImpactCard(
                    '💰 Penghematan',
                    'Rp 185 juta',
                    'Penghematan operasional',
                    Colors.purple,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImpactCard(
    String title,
    String value,
    String description,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: color, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildSDGGoals() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Kontribusi SDGs',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Sustainable Development Goals yang didukung',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ..._sdgGoals.map((goal) => _buildSDGGoalItem(goal)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSDGGoalItem(String goal) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            child: const Text(
              'SDG',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(goal)),
          const Icon(Icons.check_circle, color: Colors.green),
        ],
      ),
    );
  }

  Widget _buildFinancialSavings() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Analisis Finansial',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            DataTable(
              columns: const [
                DataColumn(label: Text('Komponen')),
                DataColumn(label: Text('Penghematan')),
                DataColumn(label: Text('ROI')),
              ],
              rows: [
                DataRow(
                  cells: [
                    const DataCell(Text('Listrik')),
                    DataCell(
                      Text(
                        'Rp 120 juta',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const DataCell(Text('45%')),
                  ],
                ),
                DataRow(
                  cells: [
                    const DataCell(Text('Air')),
                    DataCell(
                      Text(
                        'Rp 35 juta',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const DataCell(Text('32%')),
                  ],
                ),
                DataRow(
                  cells: [
                    const DataCell(Text('Maintenance')),
                    DataCell(
                      Text(
                        'Rp 30 juta',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const DataCell(Text('28%')),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(Icons.savings, color: Colors.green),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Penghematan Tahunan',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        Text(
                          'Rp 185 juta',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendations() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Rekomendasi untuk Perbaikan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildRecommendationItem(
              'Implementasi Solar Panel',
              'Potensi penghematan tambahan 40%',
              'Tinggi',
              Colors.orange,
            ),
            const SizedBox(height: 12),
            _buildRecommendationItem(
              'Rainwater Harvesting',
              'Penghematan air hingga 60%',
              'Sedang',
              Colors.blue,
            ),
            const SizedBox(height: 12),
            _buildRecommendationItem(
              'IoT Sensor Upgrade',
              'Monitoring real-time yang lebih akurat',
              'Rendah',
              Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationItem(
    String title,
    String description,
    String priority,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 60,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(description, style: TextStyle(color: Colors.grey[600])),
              ],
            ),
          ),
          Chip(
            label: Text(
              priority,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
            backgroundColor: color,
          ),
        ],
      ),
    );
  }

  Widget _buildExportSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ekspor Laporan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Format yang didukung',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildFormatChip('PDF', Icons.picture_as_pdf),
                _buildFormatChip('Excel', Icons.table_chart),
                _buildFormatChip('CSV', Icons.grid_on),
                _buildFormatChip('PPT', Icons.slideshow),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _generateFullReport,
                icon: const Icon(Icons.description),
                label: const Text('Buat Laporan Lengkap'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormatChip(String format, IconData icon) {
    return Chip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 4),
          Text(format),
        ],
      ),
      backgroundColor: Colors.blue[100],
    );
  }

  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(value),
        ),
      ],
    );
  }

  void _downloadReport() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Laporan sedang diunduh...'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _printReport() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Mengirim ke printer...'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _generateFullReport() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Membuat laporan lengkap...'),
        duration: Duration(seconds: 3),
      ),
    );
  }
}
