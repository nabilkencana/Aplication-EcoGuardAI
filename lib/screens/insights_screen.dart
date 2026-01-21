import 'package:ecoguard_ai/utils/constants.dart';
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
      'description':
      'Konsumsi meningkat 27% di luar jam operasional (19:00-22:00)',
      'impact': 'Potensi penghematan: Rp 450.000/bulan',
      'recommendation': 'Jadwalkan perangkat non-esensial di luar jam puncak',
      'priority': 'Tinggi',
      'icon': Icons.bolt_rounded,
      'color': Color(0xFFFF9500),
      'trend': Icons.trending_up_rounded,
      'date': 'Hari ini • 10:30',
    },
    {
      'title': '💧 Kebocoran Air Terdeteksi',
      'description':
      'Pola penggunaan air abnormal terdeteksi antara 02:00-04:00',
      'impact': 'Kerugian air: ~500 L/hari',
      'recommendation': 'Periksa instalasi pipa dan keran',
      'priority': 'Kritis',
      'icon': Icons.water_damage_rounded,
      'color': Color(0xFF007AFF),
      'trend': Icons.warning_rounded,
      'date': 'Kemarin • 15:45',
    },
    {
      'title': '🌿 Emisi Berlebih',
      'description': 'Emisi CO₂ meningkat 15% dibandingkan bulan lalu',
      'impact': 'Setara dengan 8 pohon dewasa',
      'recommendation': 'Optimalkan penggunaan AC dan lampu',
      'priority': 'Sedang',
      'icon': Icons.eco_rounded,
      'color': Color(0xFF34C759),
      'trend': Icons.trending_up_rounded,
      'date': '2 hari lalu • 09:20',
    },
    {
      'title': '🌡️ AC Berjalan Optimal',
      'description': 'Suhu AC diatur otomatis sesuai jam operasional',
      'impact': 'Penghematan: Rp 120.000/bulan',
      'recommendation': 'Pertahankan pengaturan saat ini',
      'priority': 'Rendah',
      'icon': Icons.ac_unit_rounded,
      'color': Color(0xFFAF52DE),
      'trend': Icons.trending_down_rounded,
      'date': 'Minggu lalu • 14:10',
    },
  ];

  String _selectedFilter = 'Semua';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F7),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // AppBar Modern
          SliverAppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            expandedHeight: 120,
            floating: false,
            pinned: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                final top = constraints.biggest.height;
                final isExpanded = top > 70;

                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppConstants.primaryColor,
                        AppConstants.secondaryColor.withOpacity(0.9),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(isExpanded ? 30 : 0),
                      bottomRight: Radius.circular(isExpanded ? 30 : 0),
                    ),
                  ),
                  child: SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'AI Insights',
                            style: TextStyle(
                              fontSize: isExpanded ? 28 : 22,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              letterSpacing: -0.5,
                            ),
                          ),
                          if (isExpanded) ...[
                            const SizedBox(height: 8),
                            Text(
                              'Analisis cerdas untuk efisiensi optimal',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.refresh_rounded, color: Colors.white),
                onPressed: _refreshInsights,
              ),
            ],
          ),

          // AI Intelligence Header
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppConstants.primaryColor,
                    AppConstants.secondaryColor.withOpacity(0.9),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(
                      Icons.psychology_rounded,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'EcoGuard AI sedang bekerja',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Menganalisis pola konsumsi dan memberikan rekomendasi cerdas untuk efisiensi optimal',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white.withOpacity(0.9),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Filter Chips
          SliverToBoxAdapter(
            child: Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildFilterChip('Semua', Icons.all_inclusive_rounded),
                  const SizedBox(width: 8),
                  _buildFilterChip('Kritis', Icons.warning_rounded),
                  const SizedBox(width: 8),
                  _buildFilterChip('Tinggi', Icons.priority_high_rounded),
                  const SizedBox(width: 8),
                  _buildFilterChip('Sedang', Icons.timeline_rounded),
                  const SizedBox(width: 8),
                  _buildFilterChip('Rendah', Icons.low_priority_rounded),
                ],
              ),
            ),
          ),

          // Stats Overview
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.3,
                children: [
                  _buildStatCard(
                    'Total Insights',
                    '${_aiInsights.length}',
                    Icons.insights_rounded,
                    Color(0xFF007AFF),
                  ),
                  _buildStatCard(
                    'Potensi Hemat',
                    'Rp 570K',
                    Icons.savings_rounded,
                    Color(0xFF34C759),
                  ),
                  _buildStatCard(
                    'CO₂ Berkurang',
                    '150 kg',
                    Icons.co2_rounded,
                    Color(0xFF32D74B),
                  ),
                  _buildStatCard(
                    'Insights Aktif',
                    '3',
                    Icons.notifications_active_rounded,
                    Color(0xFFFF9500),
                  ),
                ],
              ),
            ),
          ),

          // Section Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
              child: Row(
                children: [
                  Text(
                    'Insights Terbaru',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${_aiInsights.length} ditemukan',
                    style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ),

          // Insights List
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                final insight = _aiInsights[index];
                return _buildInsightCard(insight);
              },
              childCount: _aiInsights.length,
            ),
          ),

          // Predictive Analysis Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Analisis Prediktif',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Prediksi berdasarkan pola historis dan tren terkini',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 16),
                  _buildPredictiveAnalysis(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightCard(Map<String, dynamic> insight) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: (insight['color'] as Color).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    insight['icon'] as IconData,
                    color: insight['color'] as Color,
                    size: 26,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        insight['title'] as String,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        insight['date'] as String,
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _getPriorityColor(
                      insight['priority'] as String,
                    ).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        insight['trend'] as IconData,
                        size: 14,
                        color: _getPriorityColor(insight['priority'] as String),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        insight['priority'] as String,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _getPriorityColor(insight['priority'] as String),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Description
            Text(
              insight['description'] as String,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),

            const SizedBox(height: 16),

            // Impact Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFFF2F2F7),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.savings_rounded,
                    color: Color(0xFF34C759),
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      insight['impact'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Recommendation
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFF007AFF).withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Color(0xFF007AFF).withOpacity(0.1),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.lightbulb_rounded,
                    color: Color(0xFF007AFF),
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Rekomendasi AI',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF007AFF),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          insight['recommendation'] as String,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      _markAsComplete(insight);
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      side: BorderSide(color: Colors.grey[300]!),
                    ),
                    child: Text(
                      'Tandai Selesai',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _applyRecommendation(insight);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF007AFF),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Terapkan',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Color(0xFF5856D6).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    Icons.trending_up_rounded,
                    color: Color(0xFF5856D6),
                    size: 26,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Prediksi Bulan Depan',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Berdasarkan pola historis',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                _buildPredictionRow(
                  'Konsumsi Listrik',
                  '↑ 15%',
                  Colors.red,
                  Icons.bolt_rounded,
                ),
                const SizedBox(height: 12),
                _buildPredictionRow(
                  'Biaya Energi',
                  'Rp 3.2M',
                  Colors.orange,
                  Icons.attach_money_rounded,
                ),
                const SizedBox(height: 12),
                _buildPredictionRow(
                  'Emisi CO₂',
                  '↓ 8%',
                  Colors.green,
                  Icons.co2_rounded,
                ),
                const SizedBox(height: 12),
                _buildPredictionRow(
                  'Eco Score',
                  '↑ 5 poin',
                  Color(0xFF34C759),
                  Icons.leaderboard_rounded,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPredictionRow(
      String title,
      String value,
      Color color,
      IconData icon,
      ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
      String title,
      String value,
      IconData icon,
      Color color,
      ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Colors.black87,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, IconData icon) {
    final isSelected = _selectedFilter == label;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedFilter = selected ? label : 'Semua';
        });
      },
      avatar: Icon(icon, size: 16),
      backgroundColor: Colors.white,
      selectedColor: AppConstants.primaryColor,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.grey[700],
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),
      checkmarkColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isSelected ? Color(0xFF007AFF) : Colors.grey[300]!,
          width: 1,
        ),
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'Kritis':
        return Color(0xFFFF3B30);
      case 'Tinggi':
        return Color(0xFFFF9500);
      case 'Sedang':
        return Color(0xFF007AFF);
      case 'Rendah':
        return Color(0xFF34C759);
      default:
        return Color(0xFF8E8E93);
    }
  }

  void _refreshInsights() {
    // Simulasi refresh data
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.refresh_rounded, color: Colors.white),
            const SizedBox(width: 8),
            Text('AI sedang menganalisis data terbaru...'),
          ],
        ),
        backgroundColor: Color(0xFF007AFF),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _markAsComplete(Map<String, dynamic> insight) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Tandai Selesai'),
        content: Text('Apakah Anda yakin ingin menandai "${insight['title']}" sebagai selesai?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Insight telah ditandai sebagai selesai'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: Text('Ya, Tandai'),
          ),
        ],
      ),
    );
  }

  void _applyRecommendation(Map<String, dynamic> insight) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Terapkan Rekomendasi'),
        content: Text('Anda akan menerapkan rekomendasi: "${insight['recommendation']}"'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Rekomendasi berhasil diterapkan'),
                  backgroundColor: Colors.blue,
                ),
              );
            },
            child: Text('Terapkan'),
          ),
        ],
      ),
    );
  }
}