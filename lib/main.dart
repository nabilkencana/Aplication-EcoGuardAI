import 'package:ecoguard_ai/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:ecoguard_ai/screens/dashboard_screen.dart';
import 'package:ecoguard_ai/utils/theme.dart';

void main() {
  runApp(const EcoGuardAIApp());
}

class EcoGuardAIApp extends StatelessWidget {
  const EcoGuardAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EcoGuard AI',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      home: Navbar(),
    );
  }
}
