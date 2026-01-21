import 'package:ecoguard_ai/models/alert.dart';
import 'package:ecoguard_ai/screens/csr_report_screen.dart';
import 'package:ecoguard_ai/screens/eco_score_screen.dart';
import 'package:ecoguard_ai/screens/insights_screen.dart';
import 'package:ecoguard_ai/screens/monitoring_screen.dart';
import 'package:ecoguard_ai/widgets/navbar.dart';
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
  double ecoScore = 67.0;
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
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            // AppBar dengan gradient yang lebih modern
            SliverAppBar(
              expandedHeight: 160,
              floating: false,
              pinned: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppConstants.primaryColor,
                        AppConstants.secondaryColor,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: const [0.0, 0.8],
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Top Bar
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Logo dan Nama Aplikasi
                              Flexible(
                                child: Row(
                                  children: [
                                    Container(
                                      width: 44,
                                      height: 44,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(14),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.1,
                                            ),
                                            blurRadius: 8,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: const Icon(
                                        Icons.eco_rounded,
                                        color: Colors.white,
                                        size: 26,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'EcoGuard AI',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w800,
                                              color: Colors.white,
                                              letterSpacing: -0.3,
                                              height: 1.2,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            'Satpam Lingkungan Digital',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white.withOpacity(
                                                0.85,
                                              ),
                                              height: 1.1,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Notification Icon
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.12),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.notifications_outlined,
                                        color: Colors.white,
                                        size: 22,
                                      ),
                                      onPressed: () => _goToAlerts(),
                                    ),
                                    if (activeAlerts > 0)
                                      Positioned(
                                        right: 10,
                                        top: 10,
                                        child: Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFFF4757),
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 1.5,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          // Greeting Message
                          const SizedBox(height: 24),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: Text(
                              greetingMessage,
                              key: ValueKey(greetingMessage),
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                height: 1.1,
                                letterSpacing: -0.5,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Selamat datang kembali!',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.9),
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Konten utama dengan padding yang lebih baik
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // Welcome Card dengan stats
                  _buildWelcomeCard(),
                  const SizedBox(height: 20),

                  // Stats Grid
                  _buildStatsGrid(),
                  const SizedBox(height: 24),

                  // Quick Actions
                  _buildSectionHeader('⚡ Aksi Cepat', onTap: () {}),
                  const SizedBox(height: 12),
                  _buildQuickActions(),
                  const SizedBox(height: 24),

                  // AI Recommendations
                  _buildSectionHeader(
                    '🤖 Rekomendasi AI',
                    onTap: _goToInsights,
                  ),
                  const SizedBox(height: 12),
                  _buildRecommendationSection(),
                  const SizedBox(height: 24),

                  // Environmental Impact
                  _buildSectionHeader('🌍 Dampak Lingkungan', onTap: () {}),
                  const SizedBox(height: 12),
                  EnvironmentalImpactCard(
                    treesSaved: 12,
                    co2Reduced: 150,
                    waterSaved: 4200,
                  ),
                  const SizedBox(height: 24),

                  // Recent Activity
                  _buildSectionHeader(
                    '📊 Aktivitas Terkini',
                    onTap: _goToMonitoring,
                  ),
                  const SizedBox(height: 12),
                  _buildRecentActivity(),
                  const SizedBox(height: 40),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppConstants.primaryColor.withOpacity(0.98),
            AppConstants.secondaryColor.withOpacity(0.95),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppConstants.primaryColor.withOpacity(0.25),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Eco Score',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.9),
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          ecoScore.toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            height: 0.9,
                            letterSpacing: -1,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '/100',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.7),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(
                          Icons.trending_up_rounded,
                          color: Colors.amber[300],
                          size: 16,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '+5.2 dari kemarin',
                          style: TextStyle(
                            color: Colors.amber[300],
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Progress circle
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 84,
                    height: 84,
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _getEcoScoreIcon(ecoScore),
                        color: Colors.white,
                        size: 28,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _getEcoScoreLabel(ecoScore),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Stats row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatItem(
                Icons.savings_rounded,
                'Penghematan',
                'Rp ${AppHelpers.formatNumber(monthlySavings)}',
              ),
              Container(
                width: 1,
                height: 40,
                color: Colors.white.withOpacity(0.2),
              ),
              _buildStatItem(Icons.co2_rounded, 'CO₂ Berkurang', '150 kg'),
              Container(
                width: 1,
                height: 40,
                color: Colors.white.withOpacity(0.2),
              ),
              _buildStatItem(
                Icons.park_rounded,
                'Pohon Diselamatkan',
                '12 pohon',
              ),
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
      childAspectRatio: 0.9, // Sesuaikan rasio aspek
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 180),
          child: ConsumptionCard(
            title: '⚡ Listrik',
            value: '${energyData.currentConsumption.toStringAsFixed(0)} kWh',
            percentage: energyData.dailyChange,
            icon: Icons.bolt_rounded,
            color: AppConstants.energyColor,
            subtitle: 'Hari ini',
          ),
        ),

        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 200),
          child: ConsumptionCard(
            title: '💧 Air',
            value: '${waterData.currentConsumption.toStringAsFixed(0)} m³',
            percentage: waterData.dailyChange,
            icon: Icons.water_drop_rounded,
            color: AppConstants.waterColor,
            subtitle: 'Hari ini',
          ),
        ),

        _buildStatMiniCard(
          '🌡️ Suhu Ruangan',
          '24°C',
          Icons.thermostat_rounded,
          const Color(0xFFFF6B6B),
          'Optimal',
          showBadge: true,
        ),

        _buildStatMiniCard(
          '💨 Kualitas Udara',
          'Baik',
          Icons.air_rounded,
          const Color(0xFF4CD964),
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
    String subtitle, {
    bool showBadge = false,
  }) {
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, size: 20, color: color),
                ),
                if (showBadge)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF34C759).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Optimal',
                      style: TextStyle(
                        color: const Color(0xFF34C759),
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, {required VoidCallback onTap}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
              letterSpacing: -0.3,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppConstants.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Lihat Semua',
                    style: TextStyle(
                      color: AppConstants.primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppConstants.primaryColor,
                    size: 12,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    final actions = [
      _QuickAction(
        icon: Icons.insights_rounded,
        label: 'Monitoring',
        color: AppConstants.primaryColor,
        onTap: _goToMonitoring,
      ),
      _QuickAction(
        icon: Icons.psychology_rounded,
        label: 'AI Insights',
        color: const Color(0xFF5AC8FA),
        onTap: _goToInsights,
      ),
      _QuickAction(
        icon: Icons.leaderboard_rounded,
        label: 'Eco Score',
        color: const Color(0xFFFFD60A),
        onTap: _goToEcoScore,
      ),
      _QuickAction(
        icon: Icons.assignment_rounded,
        label: 'Laporan',
        color: const Color(0xFFAF52DE),
        onTap: _goToCSRReport,
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.85,
      ),
      itemCount: actions.length,
      itemBuilder: (context, index) {
        final action = actions[index];
        return _buildActionButton(
          action.icon,
          action.label,
          action.color,
          action.onTap,
        );
      },
    );
  }

  Widget _buildActionButton(
    IconData icon,
    String label,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: color, size: 26),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
                letterSpacing: 0.2,
              ),
              maxLines: 2,
            ),
          ],
        ),
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
      {
        'icon': Icons.bolt_rounded,
        'title': 'AC Mati Otomatis',
        'time': '10:30',
        'color': AppConstants.primaryColor,
      },
      {
        'icon': Icons.water_drop_rounded,
        'title': 'Penyiraman Optimal',
        'time': '09:15',
        'color': AppConstants.waterColor,
      },
      {
        'icon': Icons.lightbulb_rounded,
        'title': 'Lampu Hemat Energi',
        'time': '08:45',
        'color': Colors.amber,
      },
      {
        'icon': Icons.eco_rounded,
        'title': 'Analisis AI Selesai',
        'time': '07:30',
        'color': Colors.green,
      },
    ];

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
      child: Column(
        children: [
          ...activities.map((activity) {
            final IconData icon = activity['icon'] as IconData;
            final String title = activity['title'] as String;
            final String time = activity['time'] as String;
            final Color color = activity['color'] as Color;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, color: color, size: 22),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Kompresor AC dimatikan secara otomatis',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _goToMonitoring,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConstants.primaryColor.withOpacity(0.1),
                  foregroundColor: AppConstants.primaryColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Lihat Aktivitas Lengkap',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward_rounded, size: 18),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String label, String value) {
    return Flexible(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: Colors.white.withOpacity(0.85),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
          ),
        ],
      ),
    );
  }

  IconData _getEcoScoreIcon(double score) {
    if (score >= 90) return Icons.emoji_events_rounded;
    if (score >= 75) return Icons.thumb_up_rounded;
    if (score >= 60) return Icons.check_circle_rounded;
    return Icons.warning_amber_rounded;
  }

  String _getEcoScoreLabel(double score) {
    if (score >= 90) return 'EXCELLENT';
    if (score >= 75) return 'BAIK';
    if (score >= 60) return 'CUKUP';
    return 'PERLU PERBAIKAN';
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

// Helper class untuk format angka
class AppHelpers {
  static String formatNumber(dynamic number) {
    if (number == null) return '0';
    final formatter = NumberFormat('#,##0', 'id_ID');
    return formatter.format(number);
  }
}

// Model untuk quick action
class _QuickAction {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  _QuickAction({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });
}
