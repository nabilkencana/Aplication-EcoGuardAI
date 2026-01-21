import 'package:ecoguard_ai/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MonitoringScreen extends StatefulWidget {
  const MonitoringScreen({super.key});

  @override
  State<MonitoringScreen> createState() => _MonitoringScreenState();
}

class _MonitoringScreenState extends State<MonitoringScreen> {
  String _selectedTimeRange = 'Hari Ini';
  final List<Map<String, dynamic>> _timeRanges = [
    {'label': 'Hari Ini', 'icon': Icons.today_rounded},
    {'label': 'Minggu Ini', 'icon': Icons.calendar_view_week_rounded},
    {'label': 'Bulan Ini', 'icon': Icons.calendar_month_rounded},
    {'label': 'Tahun Ini', 'icon': Icons.calendar_today_rounded},
  ];

  @override
  Widget build(BuildContext context) {
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
                            'Monitoring Energy',
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
                              'Pantau konsumsi energi secara real-time',
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
                icon: const Icon(Icons.refresh_rounded, color: Colors.white),
                onPressed: _refreshData,
              ),
            ],
          ),

          // Time Range Selector
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
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
                      Icon(Icons.timeline_rounded, color: Color(0xFF32D74B), size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Rentang Waktu',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _timeRanges.map((range) {
                      final isSelected = _selectedTimeRange == range['label'];
                      return ChoiceChip.elevated(
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(range['icon'] as IconData, size: 16),
                            const SizedBox(width: 6),
                            Text(range['label']),
                          ],
                        ),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() => _selectedTimeRange = range['label']);
                        },
                        selectedColor: Colors.green[600],
                        backgroundColor: Colors.grey[50],
                        labelStyle: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : Colors.grey[700],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 0,
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),

          // Statistics Overview
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.2,
                children: [
                  _buildStatCard(
                    '⚡ Listrik Hari Ini',
                    '2,850 kWh',
                    '-8.5%',
                    Colors.green,
                    Icons.bolt_rounded,
                    const Color(0xFFFFD60A),
                  ),
                  _buildStatCard(
                    '💧 Air Minggu Ini',
                    '27,200 L',
                    '-12.3%',
                    Colors.green,
                    Icons.water_drop_rounded,
                    const Color(0xFF007AFF),
                  ),
                  _buildStatCard(
                    '🌡️ Suhu Rata-rata',
                    '24.5°C',
                    'Optimal',
                    Colors.green,
                    Icons.thermostat_rounded,
                    const Color(0xFFFF3B30),
                  ),
                  _buildStatCard(
                    '🌿 Emisi CO₂',
                    '45 kg',
                    '-15%',
                    Colors.green,
                    Icons.eco_rounded,
                    const Color(0xFF32D74B),
                  ),
                ],
              ),
            ),
          ),

          // Energy Consumption Chart
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
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
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFD60A).withOpacity(0.12),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.bolt_rounded, color: Color(0xFFFFD60A), size: 24),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Konsumsi Listrik',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Pola harian dalam kWh',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF8E8E93),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.trending_down_rounded, size: 14, color: Colors.green),
                              SizedBox(width: 4),
                              Text(
                                '-8.5%',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 220,
                      child: SfCartesianChart(
                        plotAreaBorderWidth: 0,
                        margin: EdgeInsets.zero,
                        primaryXAxis: const CategoryAxis(
                          majorGridLines: MajorGridLines(width: 0),
                          labelStyle: TextStyle(fontSize: 11, color: Color(0xFF8E8E93)),
                        ),
                        primaryYAxis: NumericAxis(
                          axisLine: const AxisLine(width: 0),
                          majorGridLines: const MajorGridLines(
                            width: 1,
                            color: Color(0xFFF2F2F7),
                          ),
                          labelStyle: const TextStyle(fontSize: 11, color: Color(0xFF8E8E93)),
                        ),
                        series: <CartesianSeries>[
                          AreaSeries<ChartData, String>(
                            dataSource: _getEnergyData(),
                            xValueMapper: (ChartData data, _) => data.time,
                            yValueMapper: (ChartData data, _) => data.consumption,
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFFFFD60A).withOpacity(0.3),
                                const Color(0xFFFFD60A).withOpacity(0.05),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderWidth: 2,
                            borderColor: const Color(0xFFFFD60A),
                            dataLabelSettings: const DataLabelSettings(
                              isVisible: true,
                              textStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                        tooltipBehavior: TooltipBehavior(
                          enable: true,
                          color: Colors.white,
                          borderColor: const Color(0xFFFFD60A),
                          borderWidth: 1,
                          textStyle: const TextStyle(color: Colors.black87),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Divider(height: 1, color: Color(0xFFF2F2F7)),
                    const SizedBox(height: 16),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total Konsumsi',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF8E8E93),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '2,850 kWh',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Puncak Hari Ini',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF8E8E93),
                              ),
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(Icons.bolt_rounded, size: 16, color: Color(0xFFFF3B30)),
                                SizedBox(width: 4),
                                Text(
                                  '410 kW',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFFFF3B30),
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
            ),
          ),

          // Water Consumption Chart
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
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
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFF007AFF).withOpacity(0.12),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.water_drop_rounded, color: Color(0xFF007AFF), size: 24),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Konsumsi Air',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Pola mingguan dalam liter',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF8E8E93),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.trending_down_rounded, size: 14, color: Colors.green),
                              SizedBox(width: 4),
                              Text(
                                '-12.3%',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 220,
                      child: SfCartesianChart(
                        plotAreaBorderWidth: 0,
                        margin: EdgeInsets.zero,
                        primaryXAxis: const CategoryAxis(
                          majorGridLines: MajorGridLines(width: 0),
                          labelStyle: TextStyle(fontSize: 11, color: Color(0xFF8E8E93)),
                        ),
                        primaryYAxis: NumericAxis(
                          axisLine: const AxisLine(width: 0),
                          majorGridLines: const MajorGridLines(
                            width: 1,
                            color: Color(0xFFF2F2F7),
                          ),
                          labelStyle: const TextStyle(fontSize: 11, color: Color(0xFF8E8E93)),
                        ),
                        series: <CartesianSeries>[
                          ColumnSeries<ChartData, String>(
                            dataSource: _getWaterData(),
                            xValueMapper: (ChartData data, _) => data.time,
                            yValueMapper: (ChartData data, _) => data.consumption,
                            color: const Color(0xFF007AFF),
                            borderRadius: BorderRadius.circular(4),
                            dataLabelSettings: const DataLabelSettings(
                              isVisible: true,
                              textStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.white),
                            ),
                          ),
                        ],
                        tooltipBehavior: TooltipBehavior(
                          enable: true,
                          color: Colors.white,
                          borderColor: const Color(0xFF007AFF),
                          borderWidth: 1,
                          textStyle: const TextStyle(color: Colors.black87),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Divider(height: 1, color: Color(0xFFF2F2F7)),
                    const SizedBox(height: 16),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total Konsumsi',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF8E8E93),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '27,200 L',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Penggunaan Terendah',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF8E8E93),
                              ),
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(Icons.water_drop_rounded, size: 16, color: Color(0xFF34C759)),
                                SizedBox(width: 4),
                                Text(
                                  '3,200 L',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF34C759),
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
            ),
          ),

          // Comparison Table
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
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
                    const Row(
                      children: [
                        Icon(Icons.bar_chart_rounded, color: Color(0xFF5856D6), size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Perbandingan dengan Standar',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFF2F2F7), width: 1),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Table(
                          columnWidths: const {
                            0: FlexColumnWidth(2.5),
                            1: FlexColumnWidth(1.5),
                            2: FlexColumnWidth(1.5),
                            3: FlexColumnWidth(1.0), // Lebarkan kolom status untuk icon
                          },
                          children: [
                            TableRow(
                              decoration: const BoxDecoration(
                                color: Color(0xFFF2F2F7),
                              ),
                              children: [
                                _buildTableHeader('Parameter'),
                                _buildTableHeader('Anda'),
                                _buildTableHeader('Standar'),
                                _buildTableHeader(''), // Kosongkan header status
                              ],
                            ),
                            _buildTableRow(
                              'Listrik/kapita',
                              '2.8 kWh',
                              '3.5 kWh',
                              const Color(0xFF34C759),
                              Icons.check_circle_rounded,
                            ),
                            _buildTableRow(
                              'Air/kapita',
                              '120 L',
                              '159 L',
                              const Color(0xFF32D74B),
                              Icons.star_rounded,
                            ),
                            _buildTableRow(
                              'Emisi CO₂',
                              '45 kg',
                              '60 kg',
                              const Color(0xFF34C759),
                              Icons.check_circle_rounded,
                            ),
                            _buildTableRow(
                              'Puncak Listrik',
                              '410 kW',
                              '350 kW',
                              const Color(0xFFFF9500),
                              Icons.warning_rounded,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2F2F7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.info_outline_rounded, color: Color(0xFF8E8E93), size: 20),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Rata-rata performa Anda 15% lebih baik dari standar industri',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF8E8E93),
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
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    String change,
    Color changeColor,
    IconData icon,
    Color iconColor,
  ) {
    final isPositive = change.contains('-') || change.toLowerCase().contains('optimal');

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
                    color: iconColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: iconColor, size: 20),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: isPositive ? Colors.green.withOpacity(0.12) : Colors.red.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isPositive ? Icons.trending_down_rounded : Icons.trending_up_rounded,
                        size: 12,
                        color: isPositive ? Colors.green : Colors.red,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        change,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: isPositive ? Colors.green : Colors.red,
                        ),
                      ),
                    ],
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
          ],
        ),
      ),
    );
  }

  Widget _buildTableHeader(String text) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: Color(0xFF8E8E93),
        ),
      ),
    );
  }

  TableRow _buildTableRow(
    String param,
    String value,
    String standard,
    Color statusColor,
    IconData statusIcon,
  ) {
    return TableRow(
      decoration: const BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(color: Color(0xFFF2F2F7), width: 1),
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            param,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            standard,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF8E8E93),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            padding: const EdgeInsets.all(10), // Padding untuk center icon
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Icon(
                statusIcon,
                size: 20, // Ukuran icon sedikit lebih besar
                color: statusColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<ChartData> _getEnergyData() {
    return [
      ChartData('00:00', 120),
      ChartData('04:00', 90),
      ChartData('08:00', 280),
      ChartData('12:00', 320),
      ChartData('16:00', 410),
      ChartData('20:00', 350),
      ChartData('24:00', 180),
    ];
  }

  List<ChartData> _getWaterData() {
    return [
      ChartData('Sen', 4500),
      ChartData('Sel', 4200),
      ChartData('Rab', 3900),
      ChartData('Kam', 4100),
      ChartData('Jum', 3800),
      ChartData('Sab', 3500),
      ChartData('Min', 3200),
    ];
  }

  void _refreshData() {
    // Simulasi refresh data
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.refresh_rounded, color: Colors.white),
            SizedBox(width: 8),
            Text('Data monitoring diperbarui'),
          ],
        ),
        backgroundColor: Colors.green[600],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.time, this.consumption);
  final String time;
  final double consumption;
}