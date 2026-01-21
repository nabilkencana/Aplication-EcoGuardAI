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
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  BottomNavigationBar _buildBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: ontap,
      type: BottomNavigationBarType.fixed,
      items: List.generate(lightIcon.length, (index) {
        return BottomNavigationBarItem(
          icon: Icon(
            lightIcon[index],
            color: currentIndex == index
                ? Colors.green[400]
                : Colors.grey,
          ),
          activeIcon: Icon(boldIcon[index], color: Colors.green[800]),
          label: navbel[index],
        );
      }),
    );
  }
}
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
