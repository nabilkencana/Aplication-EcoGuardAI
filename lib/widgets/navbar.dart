import 'package:ecoguard_ai/screens/profile.dart';
import 'package:flutter/material.dart';

import '../models/alert.dart';
import '../screens/dashboard_screen.dart';
import '../screens/insights_screen.dart';
import '../screens/monitoring_screen.dart';
import 'icon_String/icon.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int currentIndex = 0;
  final List<Widget> _listNavbar = [
    const DashboardScreen(),
    const InsightsScreen(),
    const AlertsScreen(),
    const MonitoringScreen(),
    const ProfileScreen(),
  ];

  void ontap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listNavbar[currentIndex],
      bottomNavigationBar: _buildFancyNavBar(),
    );
  }

  Widget _buildFancyNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 0,
            offset: const Offset(0, -4),
          ),
        ],
        border: Border.all(
          color: Colors.grey.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: ontap,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 0,
          showSelectedLabels: true, // Pastikan ini true
          showUnselectedLabels: true, // Pastikan ini true
          selectedFontSize: 11,
          unselectedFontSize: 11,
          selectedItemColor: const Color(0xFF10B981),
          unselectedItemColor: Colors.grey[600],
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
            height: 1.6, // Atur height agar tidak terlalu dekat dengan icon
          ),
          unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey[600],
            height: 1.4,
          ),
          items: List.generate(lightIcon.length, (index) {
            return BottomNavigationBarItem(
              icon: _buildNavIcon(
                lightIcon[index],
                boldIcon[index],
                index,
              ),
              label: navbel[index], // Label diatur di sini
            );
          }),
        ),
      ),
    );
  }

  Widget _buildNavIcon(
    IconData lightIconData,
    IconData boldIconData,
    int index,
  ) {
    final isSelected = currentIndex == index;
    final iconColor = isSelected ? const Color(0xFF10B981) : Colors.grey[600];
    
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF10B981).withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: isSelected
            ? Border.all(
                color: const Color(0xFF10B981).withOpacity(0.2),
                width: 1.5,
              )
            : null,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Icon utama
          Icon(
            isSelected ? boldIconData : lightIconData,
            color: iconColor,
            size: isSelected ? 22 : 20,
          ),
          
          // Indikator titik untuk alert
          if (index == 2 && _hasActiveAlerts()) // Index 2 adalah Alerts
            Positioned(
              right: -2,
              top: -2,
              child: Container(
                width: 8,
                height: 8,
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
    );
  }

  bool _hasActiveAlerts() {
    // Logika untuk menentukan apakah ada alert aktif
    return true; // Contoh: selalu true untuk demo
  }
}