import 'package:ecoguard_ai/models/alert.dart';
import 'package:ecoguard_ai/screens/csr_report_screen.dart';
import 'package:ecoguard_ai/screens/eco_score_screen.dart';
import 'package:ecoguard_ai/screens/insights_screen.dart';
import 'package:ecoguard_ai/screens/monitoring_screen.dart';
import 'package:flutter/material.dart';
import 'package:ecoguard_ai/models/energy_data.dart';
import 'package:ecoguard_ai/models/water_data.dart';
import 'package:ecoguard_ai/widgets/consumption_card.dart';
import 'package:ecoguard_ai/widgets/ai_recommendation_card.dart';
import 'package:ecoguard_ai/widgets/environmental_impact_card.dart';
import 'package:ecoguard_ai/services/simulation_service.dart';
import 'package:ecoguard_ai/utils/constants.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late EnergyData energyData;
  late WaterData waterData;
  final SimulationService _simulationService = SimulationService();

  // State untuk greeting message
  String greetingMessage = "Selamat Pagi";

  // State untuk data utama
  double ecoScore = 78.0;
  int activeAlerts = 3;
  double monthlySavings = 1850000;

  @override
  void initState() {
    super.initState();
    _loadData();
    _updateGreeting();
  }

  void _loadData() {
    setState(() {
      energyData = _simulationService.getEnergyData();
      waterData = _simulationService.getWaterData();
    });
  }

  void _updateGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      greetingMessage = "Selamat Pagi 🌅";
    } else if (hour < 15) {
      greetingMessage = "Selamat Siang ☀️";
    } else if (hour < 19) {
      greetingMessage = "Selamat Sore 🌇";
    } else {
      greetingMessage = "Selamat Malam 🌙";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() => _loadData());
        },
        child: CustomScrollView(
          slivers: [
            // AppBar dengan gradient
            // Ganti bagian SliverAppBar dengan ini:
            SliverAppBar(
              expandedHeight: 140,
              floating: false,
              pinned: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              flexibleSpace: LayoutBuilder(
                builder: (context, constraints) {
                  final top = constraints.biggest.height;
                  final isExpanded = top > 100;

                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppConstants.primaryColor,
                          AppConstants.secondaryColor,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Top Bar
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Logo dan Nama Aplikasi
                                Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Icon(
                                        Icons.eco,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'EcoGuard AI',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.white,
                                            letterSpacing: -0.5,
                                          ),
                                        ),
                                        if (isExpanded)
                                          Text(
                                            'Satpam Lingkungan Digital',
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.white.withOpacity(
                                                0.9,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),

                                // Notification Icon
                                Stack(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.1),
                                        shape: BoxShape.circle,
                                      ),
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.notifications_outlined,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        onPressed: () => _goToAlerts(),
                                      ),
                                    ),
                                    if (activeAlerts > 0)
                                      Positioned(
                                        right: 8,
                                        top: 8,
                                        child: Container(
                                          width: 8,
                                          height: 8,
                                          decoration: const BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),

                            // Greeting Message (hanya muncul saat expanded)
                            if (isExpanded) ...[
                              const SizedBox(height: 20),
                              Text(
                                greetingMessage,
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  height: 1.2,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Selamat datang kembali!',
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
            ),

            // Konten utama
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // Welcome Card dengan stats
                  _buildWelcomeCard(),
                  const SizedBox(height: 20),

                  // Stats Grid
                  _buildStatsGrid(),
                  const SizedBox(height: 20),

                  // Quick Actions
                  _buildSectionHeader('⚡ Aksi Cepat'),
                  const SizedBox(height: 12),
                  _buildQuickActions(),
                  const SizedBox(height: 20),

                  // AI Recommendations
                  _buildSectionHeader('🤖 Rekomendasi AI'),
                  const SizedBox(height: 12),
                  _buildRecommendationSection(),
                  const SizedBox(height: 20),

                  // Environmental Impact
                  _buildSectionHeader('🌍 Dampak Lingkungan'),
                  const SizedBox(height: 12),
                  EnvironmentalImpactCard(
                    treesSaved: 12,
                    co2Reduced: 150,
                    waterSaved: 4200,
                  ),
                  const SizedBox(height: 20),

                  // Recent Activity
                  _buildSectionHeader('📊 Aktivitas Terkini'),
                  const SizedBox(height: 12),
                  _buildRecentActivity(),
                  const SizedBox(height: 40),
                ]),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildWelcomeCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppConstants.primaryColor.withOpacity(0.95),
            AppConstants.secondaryColor.withOpacity(0.9),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppConstants.primaryColor.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Eco Score',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        ecoScore.toString(),
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 0.9,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        '/100',
                        style: TextStyle(fontSize: 16, color: Colors.white70),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.trending_up,
                        color: Colors.amber[300],
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '+5.2 dari kemarin',
                        style: TextStyle(
                          color: Colors.amber[300],
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // Progress circle
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: CircularProgressIndicator(
                      value: ecoScore / 100,
                      strokeWidth: 8,
                      backgroundColor: Colors.white.withOpacity(0.2),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.amber,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Icon(
                        _getEcoScoreIcon(ecoScore),
                        color: Colors.white,
                        size: 24,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _getEcoScoreLabel(ecoScore),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Stats row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                Icons.savings,
                'Penghematan',
                'Rp ${AppHelpers.formatNumber(monthlySavings)}',
              ),
              _buildStatItem(Icons.eco, 'CO₂ Berkurang', '150 kg'),
              _buildStatItem(Icons.park, 'Pohon Diselamatkan', '12 pohon'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.2,
      children: [
        ConsumptionCard(
          title: '⚡ Listrik',
          value: '${energyData.currentConsumption.toStringAsFixed(0)} kWh',
          percentage: energyData.dailyChange,
          icon: Icons.bolt,
          color: AppConstants.energyColor,
          subtitle: 'Hari ini',
        ),
        ConsumptionCard(
          title: '💧 Air',
          value: '${waterData.currentConsumption.toStringAsFixed(0)} L',
          percentage: waterData.dailyChange,
          icon: Icons.water_drop,
          color: AppConstants.waterColor,
          subtitle: 'Hari ini',
        ),
        _buildStatMiniCard(
          '🌡️ Suhu Ruangan',
          '24°C',
          Icons.thermostat,
          Colors.red,
          'Optimal',
        ),
        _buildStatMiniCard(
          '💨 Kualitas Udara',
          'Baik',
          Icons.air,
          Colors.green,
          'AQI: 45',
        ),
      ],
    );
  }

  Widget _buildStatMiniCard(
    String title,
    String value,
    IconData icon,
    Color color,
    String subtitle,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, size: 20, color: color),
                ),
                const Spacer(),
                if (subtitle.contains('Optimal'))
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Optimal',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
            const Spacer(),
            Text(
              title,
              style: TextStyle(fontSize: 13, color: Colors.grey[600]),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              subtitle,
              style: TextStyle(fontSize: 11, color: Colors.grey[500]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: () {
            if (title.contains('Aksi Cepat')) {
              // Handle view all actions
            } else if (title.contains('Rekomendasi')) {
              _goToInsights();
            } else if (title.contains('Aktivitas')) {
              _goToMonitoring();
            }
          },
          child: Text(
            'Lihat Semua',
            style: TextStyle(
              color: AppConstants.primaryColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      childAspectRatio: 0.8,
      children: [
        _buildActionButton(
          Icons.insights,
          'Monitoring',
          AppConstants.primaryColor,
          _goToMonitoring,
        ),
        _buildActionButton(
          Icons.psychology,
          'AI Insights',
          Colors.blue,
          _goToInsights,
        ),
        _buildActionButton(
          Icons.leaderboard,
          'Eco Score',
          Colors.amber,
          _goToEcoScore,
        ),
        _buildActionButton(
          Icons.report,
          'Laporan',
          Colors.purple,
          _goToCSRReport,
        ),
      ],
    );
  }

  Widget _buildActionButton(
    IconData icon,
    String label,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationSection() {
    final recommendation = energyData.aiRecommendations.first;
    return AiRecommendationCard(
      recommendation: recommendation,
      impact:
          'Potensi penghematan: Rp ${(energyData.currentConsumption * 1500 * 0.2).toStringAsFixed(0)}/bulan',
      priority: 'Tinggi',
      onTap: () => _goToInsights(),
    );
  }

  Widget _buildRecentActivity() {
    final List<Map<String, dynamic>> activities = [
      {'icon': Icons.bolt, 'title': 'AC Mati Otomatis', 'time': '10:30'},
      {
        'icon': Icons.water_drop,
        'title': 'Penyiraman Optimal',
        'time': '09:15',
      },
      {'icon': Icons.lightbulb, 'title': 'Lampu Hemat Energi', 'time': '08:45'},
      {'icon': Icons.eco, 'title': 'Analisis AI Selesai', 'time': '07:30'},
    ];

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ...activities.map((activity) {
              // Ekstrak nilai dengan tipe yang jelas
              final IconData icon = activity['icon'] as IconData;
              final String title = activity['title'] as String;
              final String time = activity['time'] as String;

              return ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 4),
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppConstants.primaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon, // Gunakan variable yang sudah di-cast
                    color: AppConstants.primaryColor,
                    size: 20,
                  ),
                ),
                title: Text(
                  title, // Gunakan variable yang sudah di-cast
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: Text(
                  time, // Gunakan variable yang sudah di-cast
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              );
            }).toList(),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: _goToMonitoring,
                child: const Text('Lihat Aktivitas Lengkap →'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: Colors.white.withOpacity(0.9), size: 20),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(fontSize: 10, color: Colors.white.withOpacity(0.8)),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  BottomNavigationBar _buildBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: 0,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: AppConstants.primaryColor,
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: const TextStyle(fontSize: 11),
      unselectedLabelStyle: const TextStyle(fontSize: 11),
      elevation: 4,
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.dashboard_outlined),
          activeIcon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.insights_outlined),
          activeIcon: Icon(Icons.insights),
          label: 'Insights',
        ),
        BottomNavigationBarItem(
          icon: Stack(
            children: [
              const Icon(Icons.notifications_outlined),
              if (activeAlerts > 0)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
          activeIcon: Stack(
            children: [
              const Icon(Icons.notifications),
              if (activeAlerts > 0)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
          label: 'Alerts',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart_outlined),
          activeIcon: Icon(Icons.bar_chart),
          label: 'Monitoring',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: 'Profil',
        ),
      ],
      onTap: (index) {
        switch (index) {
          case 1:
            _goToInsights();
            break;
          case 2:
            _goToAlerts();
            break;
          case 3:
            _goToMonitoring();
            break;
        }
      },
    );
  }

  IconData _getEcoScoreIcon(double score) {
    if (score >= 90) return Icons.emoji_events;
    if (score >= 75) return Icons.thumb_up;
    if (score >= 60) return Icons.check_circle;
    return Icons.warning;
  }

  String _getEcoScoreLabel(double score) {
    if (score >= 90) return 'Excellent';
    if (score >= 75) return 'Baik';
    if (score >= 60) return 'Cukup';
    return 'Perlu Perbaikan';
  }

  // Navigation Methods
  void _goToMonitoring() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MonitoringScreen()),
    );
  }

  void _goToInsights() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const InsightsScreen()),
    );
  }

  void _goToAlerts() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AlertsScreen()),
    );
  }

  void _goToEcoScore() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EcoScoreScreen()),
    );
  }

  void _goToCSRReport() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CSRReportScreen()),
    );
  }
}

// Helper class untuk format angka (sesuaikan dengan yang ada di utils/helpers.dart)
class AppHelpers {
  static String formatNumber(dynamic number) {
    if (number == null) return '0';
    final formatter = NumberFormat('#,##0', 'id_ID');
    return formatter.format(number);
  }
}
