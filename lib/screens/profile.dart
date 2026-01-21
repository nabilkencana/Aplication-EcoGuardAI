import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Map<String, dynamic> _userData = {
    'name': 'Ahmad Surya',
    'email': 'ahmad.surya@ecoguard.com',
    'company': 'PT EcoGuard Indonesia',
    'role': 'Head of Sustainability',
    'avatar': 'AS',
    'joinDate': '15 Maret 2023',
    'ecoPoints': 2850,
    'level': 'Eco Champion',
    'badges': 12,
    'streak': 45,
  };

  final List<Map<String, dynamic>> _achievements = [
    {
      'title': 'Energy Saver Master',
      'description': 'Menghemat 5000 kWh listrik',
      'icon': Icons.bolt_rounded,
      'color': Color(0xFFFFD60A),
      'unlocked': '2024-01-15',
    },
    {
      'title': 'Water Guardian',
      'description': 'Mengurangi konsumsi air 30%',
      'icon': Icons.water_drop_rounded,
      'color': Color(0xFF007AFF),
      'unlocked': '2023-12-20',
    },
    {
      'title': 'Carbon Neutral Hero',
      'description': 'Menetralkan 1000kg CO₂',
      'icon': Icons.eco_rounded,
      'color': Color(0xFF32D74B),
      'unlocked': '2024-02-10',
    },
    {
      'title': 'Consistency King',
      'description': '45 hari streak monitoring',
      'icon': Icons.local_fire_department_rounded,
      'color': Color(0xFFFF9500),
      'unlocked': 'Hari ini',
    },
  ];

  final List<Map<String, dynamic>> _activityHistory = [
    {
      'action': 'Menetapkan target baru',
      'detail': 'Target emisi -15% bulan depan',
      'time': '10:30',
      'icon': Icons.flag_rounded,
      'color': Color(0xFF5856D6),
    },
    {
      'action': 'Menerapkan rekomendasi AI',
      'detail': 'Optimasi jadwal AC otomatis',
      'time': 'Kemarin • 14:20',
      'icon': Icons.psychology_rounded,
      'color': Color(0xFFAF52DE),
    },
    {
      'action': 'Mencapai milestone',
      'detail': 'Eco Score 90+ untuk pertama kali',
      'time': '2 hari lalu • 09:15',
      'icon': Icons.emoji_events_rounded,
      'color': Color(0xFFFFD60A),
    },
    {
      'action': 'Bergabung dalam program',
      'detail': 'Program Go Green Perusahaan',
      'time': '1 minggu lalu',
      'icon': Icons.group_rounded,
      'color': Color(0xFF34C759),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Modern AppBar with Profile Header
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: 320,
            floating: false,
            pinned: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF5856D6),
                      Color(0xFFAF52DE),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                    child: Column(
                      children: [
                        // Profile Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // IconButton(
                            //   icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                            //   onPressed: () => Navigator.pop(context),
                            // ),
                            IconButton(
                              icon: const Icon(Icons.settings_rounded, color: Colors.white),
                              onPressed: () => _openSettings(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        
                        // Avatar and Basic Info
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white.withOpacity(0.3), width: 3),
                          ),
                          child: Center(
                            child: Text(
                              _userData['avatar'],
                              style: const TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        
                        Text(
                          _userData['name'],
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        
                        Text(
                          _userData['role'],
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                        const SizedBox(height: 8),
                        
                        Text(
                          _userData['company'],
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Stats Overview
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
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Icon(Icons.bar_chart_rounded, color: Color(0xFF5856D6), size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Statistik Prestasi',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.9,
                    children: [
                      _buildStatItem(
                        '🏆 Level',
                        _userData['level'],
                        Icons.star_rounded,
                        const Color(0xFFFFD60A),
                      ),
                      _buildStatItem(
                        '🎯 Eco Points',
                        _userData['ecoPoints'].toString(),
                        Icons.leaderboard_rounded,
                        const Color(0xFF34C759),
                      ),
                      _buildStatItem(
                        '🛡️ Badges',
                        '${_userData['badges']}',
                        Icons.verified_rounded,
                        const Color(0xFF007AFF),
                      ),
                      _buildStatItem(
                        '🔥 Streak',
                        '${_userData['streak']} hari',
                        Icons.local_fire_department_rounded,
                        const Color(0xFFFF3B30),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Personal Information
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.person_rounded, color: Color(0xFF5856D6), size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Informasi Pribadi',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildInfoRow(Icons.email_rounded, 'Email', _userData['email']),
                  const SizedBox(height: 16),
                  _buildInfoRow(Icons.business_rounded, 'Perusahaan', _userData['company']),
                  const SizedBox(height: 16),
                  _buildInfoRow(Icons.work_rounded, 'Jabatan', _userData['role']),
                  const SizedBox(height: 16),
                  _buildInfoRow(Icons.calendar_today_rounded, 'Bergabung', _userData['joinDate']),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => _editProfile(),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        side: BorderSide(color: Colors.grey[300]!),
                      ),
                      icon: const Icon(Icons.edit_rounded, size: 18),
                      label: const Text(
                        'Edit Profil',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Achievements Section
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.emoji_events_rounded, color: Color(0xFFFFD60A), size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Pencapaian',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${_achievements.length} pencapaian terkunci',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: _achievements.map((achievement) {
                      return _buildAchievementCard(achievement);
                    }).toList(),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () => _viewAllAchievements(),
                      child: const Text(
                        'Lihat Semua Pencapaian →',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF5856D6),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Recent Activity
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.history_rounded, color: Color(0xFF007AFF), size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Aktivitas Terbaru',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: _activityHistory.map((activity) {
                      return _buildActivityItem(activity);
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2F2F7),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.insights_rounded, color: Color(0xFF5856D6), size: 24),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Performa Anda',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Lebih baik dari 85% pengguna lain',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF8E8E93),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF34C759).withOpacity(0.12),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'TOP 15%',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF34C759),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Action Buttons
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 40),
              child: Column(
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _shareProfile(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF5856D6),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(color: Colors.grey[300]!),
                      ),
                      minimumSize: const Size(double.infinity, 0),
                    ),
                    icon: const Icon(Icons.share_rounded, size: 20),
                    label: const Text(
                      'Bagikan Profil Saya',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: () => _exportData(),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      side: BorderSide(color: Colors.grey[300]!),
                      minimumSize: const Size(double.infinity, 0),
                    ),
                    icon: const Icon(Icons.download_rounded, size: 20),
                    label: const Text(
                      'Ekspor Data Saya',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton.icon(
                    onPressed: () => _showLogoutDialog(),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      minimumSize: const Size(double.infinity, 0),
                    ),
                    icon: const Icon(Icons.logout_rounded, color: Color(0xFFFF3B30), size: 20),
                    label: const Text(
                      'Keluar',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFFF3B30),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[100]!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 16),
                ),
                const Spacer(),
                if (label.contains('Streak'))
                  const Icon(Icons.local_fire_department_rounded, color: Color(0xFFFF3B30), size: 14),
              ],
            ),
            const SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
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
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: const Color(0xFF5856D6).withOpacity(0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 18, color: const Color(0xFF5856D6)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                value,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAchievementCard(Map<String, dynamic> achievement) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[100]!),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: achievement['color'].withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(achievement['icon'], color: achievement['color'], size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  achievement['title'],
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  achievement['description'],
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.calendar_today_rounded, size: 12, color: Colors.grey[500]),
                    const SizedBox(width: 4),
                    Text(
                      'Dibuka: ${achievement['unlocked']}',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Icon(Icons.verified_rounded, color: achievement['color'], size: 20),
        ],
      ),
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> activity) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: activity['color'].withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(activity['icon'], color: activity['color'], size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity['action'],
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  activity['detail'],
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  activity['time'],
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _openSettings() {
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
              const SizedBox(height: 20),
              const Text(
                'Pengaturan',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              ...[
                _buildSettingTile(Icons.notifications_rounded, 'Notifikasi', true),
                _buildSettingTile(Icons.privacy_tip_rounded, 'Privasi', false),
                _buildSettingTile(Icons.language_rounded, 'Bahasa', false),
                _buildSettingTile(Icons.dark_mode_rounded, 'Mode Gelap', true),
                _buildSettingTile(Icons.help_rounded, 'Bantuan & Dukungan', false),
                _buildSettingTile(Icons.info_rounded, 'Tentang Aplikasi', false),
              ],
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5856D6),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Simpan Pengaturan',
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

  Widget _buildSettingTile(IconData icon, String title, bool hasSwitch) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: const Color(0xFF5856D6).withOpacity(0.12),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, size: 20, color: const Color(0xFF5856D6)),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
      trailing: hasSwitch
          ? Switch(
              value: true,
              activeColor: const Color(0xFF5856D6),
              onChanged: (value) {},
            )
          : const Icon(Icons.chevron_right_rounded, color: Color(0xFF8E8E93)),
      onTap: () {},
    );
  }

  void _editProfile() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profil'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Nama Lengkap',
                border: OutlineInputBorder(),
              ),
              initialValue: _userData['name'],
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              initialValue: _userData['email'],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Profil berhasil diperbarui'),
                  backgroundColor: Color(0xFF34C759),
                ),
              );
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _viewAllAchievements() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Membuka halaman semua pencapaian'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _shareProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Tautan profil telah disalin ke clipboard'),
        backgroundColor: Color(0xFF5856D6),
      ),
    );
  }

  void _exportData() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Data sedang diekspor...'),
        backgroundColor: Color(0xFF007AFF),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Keluar dari Akun?'),
        content: const Text('Anda akan keluar dari akun EcoGuard AI.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Berhasil keluar'),
                  backgroundColor: Color(0xFF34C759),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF3B30),
            ),
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
  }
}