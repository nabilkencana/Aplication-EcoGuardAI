import 'package:ecoguard_ai/utils/constants.dart';
import 'package:flutter/material.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  final List<Map<String, dynamic>> _alerts = [
    {
      'title': '🚨 Puncak Listrik Tertinggi',
      'message': 'Konsumsi listrik mencapai 410 kW pada pukul 16:30, melebihi batas normal sebesar 27%',
      'time': '2 jam yang lalu',
      'type': 'critical',
      'category': 'listrik',
      'resolved': false,
      'icon': Icons.bolt_rounded,
      'severity': 9,
    },
    {
      'title': '💧 Kebocoran Air Terdeteksi',
      'message': 'Pola penggunaan air abnormal terdeteksi pukul 03:00. Diduga terjadi kebocoran pada pipa utama',
      'time': '5 jam yang lalu',
      'type': 'critical',
      'category': 'air',
      'resolved': false,
      'icon': Icons.water_damage_rounded,
      'severity': 10,
    },
    {
      'title': '⚠️ AC Beroperasi Berlebihan',
      'message': 'Unit AC bekerja 30% di atas kapasitas normal. Suhu ruangan tidak stabil',
      'time': '1 hari yang lalu',
      'type': 'warning',
      'category': 'suhu',
      'resolved': true,
      'icon': Icons.ac_unit_rounded,
      'severity': 6,
    },
    {
      'title': '✅ Emisi Menurun',
      'message': 'Emisi CO₂ turun 8% dibandingkan minggu lalu. Performa sangat baik',
      'time': '2 hari yang lalu',
      'type': 'success',
      'category': 'lingkungan',
      'resolved': true,
      'icon': Icons.eco_rounded,
      'severity': 2,
    },
    {
      'title': '🔋 Baterai Panel Surya Rendah',
      'message': 'Kapasitas baterai panel surya hanya tersisa 15%. Segera isi ulang',
      'time': '3 hari yang lalu',
      'type': 'warning',
      'category': 'energi',
      'resolved': false,
      'icon': Icons.solar_power_rounded,
      'severity': 7,
    },
    {
      'title': '🌡️ Suhu Optimal',
      'message': 'Suhu ruangan stabil pada 24°C selama 24 jam terakhir',
      'time': '1 minggu yang lalu',
      'type': 'info',
      'category': 'suhu',
      'resolved': true,
      'icon': Icons.thermostat_rounded,
      'severity': 1,
    },
  ];

  String _selectedFilter = 'semua';
  int _unreadCount = 2;

  @override
  Widget build(BuildContext context) {
    final filteredAlerts = _selectedFilter == 'semua'
        ? _alerts
        : _alerts.where((alert) => alert['type'] == _selectedFilter).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Modern AppBar
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
                            'Smart Alerts',
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
            // actions: [
            //   IconButton(
            //     icon: Icon(Icons.refresh_rounded, color: Colors.white),
            //     onPressed: ,
            //   ),
            // ],
          ),

          // Alert Stats Overview
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
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
                  const Row(
                    children: [
                      Icon(Icons.notifications_active_rounded, color: Color(0xFFFF3B30), size: 24),
                      SizedBox(width: 8),
                      Text(
                        'Ringkasan Alert',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildAlertStat(
                        'Kritis',
                        _alerts.where((a) => a['type'] == 'critical').length,
                        const Color(0xFFFF3B30),
                        Icons.priority_high_rounded,
                      ),
                      Container(width: 1, height: 40, color: Colors.grey[200]),
                      _buildAlertStat(
                        'Peringatan',
                        _alerts.where((a) => a['type'] == 'warning').length,
                        const Color(0xFFFF9500),
                        Icons.warning_rounded,
                      ),
                      Container(width: 1, height: 40, color: Colors.grey[200]),
                      _buildAlertStat(
                        'Aktif',
                        _alerts.where((a) => !a['resolved']).length,
                        const Color(0xFF007AFF),
                        Icons.notifications_rounded,
                      ),
                    ],
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
                  _buildFilterChip('semua', Icons.all_inclusive_rounded, '${_alerts.length}'),
                  const SizedBox(width: 8),
                  _buildFilterChip('critical', Icons.error_rounded, '${_alerts.where((a) => a['type'] == 'critical').length}'),
                  const SizedBox(width: 8),
                  _buildFilterChip('warning', Icons.warning_rounded, '${_alerts.where((a) => a['type'] == 'warning').length}'),
                  const SizedBox(width: 8),
                  _buildFilterChip('success', Icons.check_circle_rounded, '${_alerts.where((a) => a['type'] == 'success').length}'),
                  const SizedBox(width: 8),
                  _buildFilterChip('info', Icons.info_rounded, '${_alerts.where((a) => a['type'] == 'info').length}'),
                ],
              ),
            ),
          ),

          // Section Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: Row(
                children: [
                  const Text(
                    'Alert Terbaru',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${filteredAlerts.length} ditemukan',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Alerts List
          if (filteredAlerts.isEmpty)
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(40),
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
                    Icon(
                      Icons.notifications_off_rounded,
                      size: 64,
                      color: Colors.grey[300],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Tidak ada alert',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _selectedFilter == 'semua'
                          ? 'Semua alert telah ditangani'
                          : 'Tidak ada alert dengan filter ini',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final alert = filteredAlerts[index];
                  return _buildAlertCard(alert);
                },
                childCount: filteredAlerts.length,
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _testAlert,
        backgroundColor: Colors.green[600],
        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        icon: const Icon(Icons.add_alert_rounded, size: 24),
        label: const Text('Test Alert', style: TextStyle(fontWeight: FontWeight.w600)),
      ),
    );
  }

  Widget _buildAlertCard(Map<String, dynamic> alert) {
    final String title = alert['title']?.toString() ?? 'No Title';
    final String message = alert['message']?.toString() ?? 'No Message';
    final String time = alert['time']?.toString() ?? 'Just now';
    final String type = alert['type']?.toString() ?? 'info';
    final IconData icon = alert['icon'] as IconData? ?? Icons.info_rounded;
    final int severity = alert['severity'] as int? ?? 1;
    final bool resolved = alert['resolved'] as bool? ?? false;

    final color = _getAlertColor(type);
    final backgroundColor = color.withOpacity(0.08);
    final borderColor = color.withOpacity(0.2);

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
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
            // Header with icon and title
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: borderColor, width: 1),
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(Icons.access_time_rounded, size: 12, color: Colors.grey[500]),
                          const SizedBox(width: 4),
                          Text(
                            time,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: resolved
                        ? const Color(0xFF34C759).withOpacity(0.12)
                        : const Color(0xFFFF3B30).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        resolved ? Icons.check_circle_rounded : Icons.priority_high_rounded,
                        size: 12,
                        color: resolved ? const Color(0xFF34C759) : const Color(0xFFFF3B30),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        resolved ? 'SELESAI' : 'AKTIF',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: resolved ? const Color(0xFF34C759) : const Color(0xFFFF3B30),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Severity Indicator
            Row(
              children: [
                Text(
                  'Tingkat Keparahan: ',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: severity / 10,
                      child: Container(
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '$severity/10',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Alert Message
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    color: Colors.grey[600],
                    size: 18,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      message,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Action Buttons
            Row(
              children: [
                if (!resolved) ...[
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _resolveAlert(alert),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        side: BorderSide(color: Colors.grey[300]!),
                      ),
                      icon: const Icon(Icons.check_circle_outline_rounded, size: 18),
                      label: const Text(
                        'Tandai Selesai',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _showAlertActions(alert),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      side: BorderSide(color: Colors.grey[300]!),
                    ),
                    icon: const Icon(Icons.more_horiz_rounded, size: 18),
                    label: const Text(
                      'Lainnya',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
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

  Widget _buildAlertStat(String label, int count, Color color, IconData icon) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          count.toString(),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: color,
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String type, IconData icon, String count) {
    final isSelected = _selectedFilter == type;
    final color = _getAlertColor(type);
    
    return FilterChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(type == 'semua' ? 'Semua' : type),
          const SizedBox(width: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: color.withOpacity(isSelected ? 0.2 : 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              count,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : color,
              ),
            ),
          ),
        ],
      ),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedFilter = selected ? type : 'semua';
        });
      },
      avatar: Icon(icon, size: 16),
      backgroundColor: Colors.white,
      selectedColor: color,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.grey[700],
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),
      checkmarkColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isSelected ? color : Colors.grey[300]!,
          width: 1,
        ),
      ),
    );
  }

  Color _getAlertColor(String type) {
    switch (type) {
      case 'critical':
        return const Color(0xFFFF3B30);
      case 'warning':
        return const Color(0xFFFF9500);
      case 'success':
        return const Color(0xFF34C759);
      case 'info':
        return const Color(0xFF007AFF);
      case 'semua':
        return const Color(0xFF5856D6);
      default:
        return const Color(0xFF8E8E93);
    }
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Filter Alert',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              ...['semua', 'critical', 'warning', 'success', 'info'].map((type) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: _getAlertColor(type).withOpacity(0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      _getFilterIcon(type),
                      color: _getAlertColor(type),
                      size: 18,
                    ),
                  ),
                  title: Text(
                    type == 'semua' ? 'Semua Alert' : type.toUpperCase(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  subtitle: Text(
                    '${_alerts.where((a) => type == 'semua' || a['type'] == type).length} alert',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  trailing: _selectedFilter == type
                      ? Icon(Icons.check_circle_rounded, color: _getAlertColor(type))
                      : null,
                  onTap: () {
                    setState(() {
                      _selectedFilter = type;
                    });
                    Navigator.pop(context);
                  },
                );
              }).toList(),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF007AFF),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Terapkan Filter',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getFilterIcon(String type) {
    switch (type) {
      case 'critical':
        return Icons.error_rounded;
      case 'warning':
        return Icons.warning_rounded;
      case 'success':
        return Icons.check_circle_rounded;
      case 'info':
        return Icons.info_rounded;
      default:
        return Icons.all_inclusive_rounded;
    }
  }

  void _resolveAlert(Map<String, dynamic> alert) {
    setState(() {
      alert['resolved'] = true;
      _unreadCount = _alerts.where((a) => !a['resolved']).length;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle_rounded, color: Colors.white),
            SizedBox(width: 8),
            Text('Alert telah ditandai selesai'),
          ],
        ),
        backgroundColor: const Color(0xFF34C759),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  void _showAlertActions(Map<String, dynamic> alert) {
    final bool resolved = alert['resolved'] as bool? ?? false;
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  alert['title']?.toString() ?? 'Alert',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 24),
              ...[
                if (!resolved) ...[
                  _buildActionTile(
                    Icons.check_circle_rounded,
                    'Tandai Selesai',
                    const Color(0xFF34C759),
                    () {
                      Navigator.pop(context);
                      _resolveAlert(alert);
                    },
                  ),
                  _buildActionTile(
                    Icons.notifications_off_rounded,
                    'Matikan Notifikasi Serupa',
                    const Color(0xFF8E8E93),
                    () {
                      Navigator.pop(context);
                      _muteSimilarAlerts();
                    },
                  ),
                  _buildActionTile(
                    Icons.schedule_rounded,
                    'Tunda 1 Jam',
                    const Color(0xFFFF9500),
                    () {
                      Navigator.pop(context);
                      _delayAlert(alert);
                    },
                  ),
                ],
                _buildActionTile(
                  Icons.delete_outline_rounded,
                  'Hapus Alert',
                  const Color(0xFFFF3B30),
                  () {
                    Navigator.pop(context);
                    _deleteAlert(alert);
                  },
                ),
                _buildActionTile(
                  Icons.share_rounded,
                  'Bagikan Alert',
                  const Color(0xFF007AFF),
                  () {
                    Navigator.pop(context);
                    _shareAlert(alert);
                  },
                ),
                _buildActionTile(
                  Icons.info_outline_rounded,
                  'Detail Lengkap',
                  const Color(0xFF5856D6),
                  () {
                    Navigator.pop(context);
                    _showAlertDetails(alert);
                  },
                ),
              ],
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    side: BorderSide(color: Colors.grey[300]!),
                  ),
                  child: const Text(
                    'Tutup',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionTile(IconData icon, String title, Color color, VoidCallback onTap) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
      onTap: onTap,
    );
  }

  void _testAlert() {
    final newAlert = {
      'title': '🧪 Alert Uji Coba',
      'message': 'Ini adalah alert uji coba dari sistem EcoGuard AI untuk memastikan notifikasi berjalan dengan baik',
      'time': 'Baru saja',
      'type': 'warning',
      'category': 'sistem',
      'resolved': false,
      'icon': Icons.science_rounded,
      'severity': 4,
    };

    setState(() {
      _alerts.insert(0, newAlert);
      _unreadCount = _alerts.where((a) => !a['resolved']).length;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle_rounded, color: Colors.white),
            SizedBox(width: 8),
            Text('Alert uji coba telah ditambahkan'),
          ],
        ),
        backgroundColor: const Color(0xFF34C759),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  void _muteSimilarAlerts() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Notifikasi serupa telah dimatikan'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _delayAlert(Map<String, dynamic> alert) {
    setState(() {
      alert['time'] = 'Ditunda • 1 jam lagi';
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.schedule_rounded, color: Colors.white),
            SizedBox(width: 8),
            Text('Alert ditunda 1 jam'),
          ],
        ),
        backgroundColor: const Color(0xFFFF9500),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  void _deleteAlert(Map<String, dynamic> alert) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Alert?'),
        content: const Text('Alert yang sudah dihapus tidak dapat dikembalikan.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _alerts.remove(alert);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Alert telah dihapus'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text(
              'Hapus',
              style: TextStyle(color: Color(0xFFFF3B30)),
            ),
          ),
        ],
      ),
    );
  }

  void _shareAlert(Map<String, dynamic> alert) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Alert dibagikan'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _showAlertDetails(Map<String, dynamic> alert) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(alert['title']?.toString() ?? 'Detail Alert'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(alert['message']?.toString() ?? 'No details'),
            const SizedBox(height: 16),
            Text(
              'Kategori: ${alert['category']?.toString().toUpperCase() ?? 'UNKNOWN'}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            Text(
              'Status: ${alert['resolved'] == true ? 'SELESAI' : 'AKTIF'}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }
}