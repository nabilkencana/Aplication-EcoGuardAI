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
      'message': 'Konsumsi mencapai 410 kW pada pukul 16:30',
      'time': '2 jam yang lalu',
      'type': 'critical',
      'resolved': false,
    },
    {
      'title': '💧 Kebocoran Air Terdeteksi',
      'message': 'Pola penggunaan abnormal terdeteksi pukul 03:00',
      'time': '5 jam yang lalu',
      'type': 'critical',
      'resolved': false,
    },
    {
      'title': '⚠️ AC Beroperasi Berlebihan',
      'message': 'Unit AC bekerja 30% di atas kapasitas normal',
      'time': '1 hari yang lalu',
      'type': 'warning',
      'resolved': true,
    },
    {
      'title': '✅ Emisi Menurun',
      'message': 'Emisi CO₂ turun 8% dibandingkan minggu lalu',
      'time': '2 hari yang lalu',
      'type': 'success',
      'resolved': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Alerts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          // Alert Summary
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.blue[50],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildAlertCount('Kritis', 2, Colors.red),
                _buildAlertCount('Peringatan', 1, Colors.orange),
                _buildAlertCount('Selesai', 1, Colors.green),
              ],
            ),
          ),

          // Alerts List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _alerts.length,
              itemBuilder: (context, index) {
                return _buildAlertCard(_alerts[index]);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _testAlert,
        child: const Icon(Icons.add_alert),
      ),
    );
  }

  Widget _buildAlertCount(String type, int count, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.notifications, color: color),
        ),
        const SizedBox(height: 8),
        Text(type, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
        Text(
          count.toString(),
          style: TextStyle(
            color: color,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildAlertCard(Map<String, dynamic> alert) {
    Color backgroundColor;
    IconData icon;

    switch (alert['type']) {
      case 'critical':
        backgroundColor = Colors.red[50]!;
        icon = Icons.error;
        break;
      case 'warning':
        backgroundColor = Colors.orange[50]!;
        icon = Icons.warning;
        break;
      case 'success':
        backgroundColor = Colors.green[50]!;
        icon = Icons.check_circle;
        break;
      default:
        backgroundColor = Colors.grey[50]!;
        icon = Icons.info;
    }

    return Card(
      color: backgroundColor,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: _getAlertColor(alert['type'])),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    alert['title'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Chip(
                  label: Text(
                    alert['resolved'] ? 'SELESAI' : 'AKTIF',
                    style: TextStyle(
                      fontSize: 10,
                      color: alert['resolved'] ? Colors.green : Colors.red,
                    ),
                  ),
                  backgroundColor: alert['resolved']
                      ? Colors.green[100]
                      : Colors.red[100],
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(alert['message']),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  alert['time'],
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
                Row(
                  children: [
                    if (!alert['resolved'])
                      TextButton(
                        onPressed: () => _resolveAlert(alert),
                        child: const Text('Tandai Selesai'),
                      ),
                    IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () => _showAlertActions(alert),
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

  Color _getAlertColor(String type) {
    switch (type) {
      case 'critical':
        return Colors.red;
      case 'warning':
        return Colors.orange;
      case 'success':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Alert'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CheckboxListTile(
              title: const Text('Alert Kritis'),
              value: true,
              onChanged: (value) {},
            ),
            CheckboxListTile(
              title: const Text('Alert Peringatan'),
              value: true,
              onChanged: (value) {},
            ),
            CheckboxListTile(
              title: const Text('Alert Sukses'),
              value: true,
              onChanged: (value) {},
            ),
            CheckboxListTile(
              title: const Text('Hanya Belum Selesai'),
              value: false,
              onChanged: (value) {},
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Terapkan'),
          ),
        ],
      ),
    );
  }

  void _resolveAlert(Map<String, dynamic> alert) {
    setState(() {
      alert['resolved'] = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Alert telah ditandai selesai')),
    );
  }

  void _showAlertActions(Map<String, dynamic> alert) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.notifications_off),
            title: const Text('Matikan Notifikasi Serupa'),
            onTap: () {
              Navigator.pop(context);
              _muteSimilarAlerts();
            },
          ),
          ListTile(
            leading: const Icon(Icons.schedule),
            title: const Text('Tunda 1 Jam'),
            onTap: () {
              Navigator.pop(context);
              _delayAlert();
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Hapus Alert'),
            onTap: () {
              Navigator.pop(context);
              _deleteAlert(alert);
            },
          ),
        ],
      ),
    );
  }

  void _testAlert() {
    setState(() {
      _alerts.insert(0, {
        'title': '🧪 Alert Uji Coba',
        'message': 'Ini adalah alert uji coba dari sistem AI',
        'time': 'Baru saja',
        'type': 'warning',
        'resolved': false,
      });
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Alert uji coba telah ditambahkan')),
    );
  }

  void _muteSimilarAlerts() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Notifikasi serupa telah dimatikan')),
    );
  }

  void _delayAlert() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Alert ditunda 1 jam')));
  }

  void _deleteAlert(Map<String, dynamic> alert) {
    setState(() {
      _alerts.remove(alert);
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Alert telah dihapus')));
  }
}
