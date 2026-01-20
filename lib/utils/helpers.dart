import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ecoguard_ai/utils/constants.dart';

class AppHelpers {
  // Format numbers with thousand separators
  static String formatNumber(dynamic number) {
    if (number == null) return '0';
    final formatter = NumberFormat('#,##0', 'id_ID');
    return formatter.format(number);
  }

  // Format currency
  static String formatCurrency(double amount) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  // Format date
  static String formatDate(DateTime date, {String format = 'dd/MM/yyyy'}) {
    final formatter = DateFormat(format);
    return formatter.format(date);
  }

  // Format date with time
  static String formatDateTime(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
  }

  // Format relative time (e.g., "2 jam yang lalu")
  static String formatRelativeTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '$years tahun yang lalu';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '$months bulan yang lalu';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} hari yang lalu';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} jam yang lalu';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} menit yang lalu';
    } else {
      return 'Baru saja';
    }
  }

  // Calculate environmental impact
  static Map<String, dynamic> calculateImpact(
    double energySaved,
    double waterSaved,
  ) {
    final co2Reduced = energySaved * AppConstants.co2PerKwh;
    final treesEquivalent = co2Reduced / 1000 * AppConstants.treesPerTonCO2;
    final moneySaved =
        (energySaved * AppConstants.electricityPricePerKwh) +
        (waterSaved * AppConstants.waterPricePerLiter);

    return {
      'co2_reduced': co2Reduced,
      'trees_saved': treesEquivalent,
      'money_saved': moneySaved,
      'water_saved': waterSaved,
      'energy_saved': energySaved,
    };
  }

  // Calculate Eco Score
  static int calculateEcoScore(
    double energyEfficiency,
    double waterEfficiency,
    double emissionReduction,
  ) {
    final energyScore = (energyEfficiency / 100 * 40).clamp(0, 40);
    final waterScore = (waterEfficiency / 100 * 30).clamp(0, 30);
    final emissionScore = (emissionReduction / 100 * 30).clamp(0, 30);

    return (energyScore + waterScore + emissionScore).round();
  }

  // Get color based on value and thresholds
  static Color getThresholdColor(double value, double low, double high) {
    if (value <= low) {
      return Colors.green;
    } else if (value <= high) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  // Get icon based on resource type
  static IconData getResourceIcon(String resourceType) {
    switch (resourceType) {
      case 'electricity':
        return Icons.bolt;
      case 'water':
        return Icons.water_drop;
      case 'emissions':
        return Icons.cloud;
      default:
        return Icons.eco;
    }
  }

  // Get color based on resource type
  static Color getResourceColor(String resourceType) {
    switch (resourceType) {
      case 'electricity':
        return AppConstants.energyColor;
      case 'water':
        return AppConstants.waterColor;
      case 'emissions':
        return AppConstants.emissionsColor;
      default:
        return AppConstants.primaryColor;
    }
  }

  // Get unit for resource type
  static String getResourceUnit(String resourceType) {
    switch (resourceType) {
      case 'electricity':
        return 'kWh';
      case 'water':
        return 'L';
      case 'emissions':
        return 'kg CO₂';
      default:
        return '';
    }
  }

  // Validate email
  static bool isValidEmail(String email) {
    final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return regex.hasMatch(email);
  }

  // Validate phone number
  static bool isValidPhoneNumber(String phone) {
    final regex = RegExp(r'^\+?[0-9]{10,13}$');
    return regex.hasMatch(phone);
  }

  // Show snackbar
  static void showSnackBar(
    BuildContext context, {
    required String message,
    Color? backgroundColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  // Show confirmation dialog
  static Future<bool?> showConfirmationDialog(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = 'Ya',
    String cancelText = 'Tidak',
  }) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(cancelText),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }

  // Show loading dialog
  static void showLoadingDialog(BuildContext context, {String? message}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            if (message != null) ...[const SizedBox(height: 16), Text(message)],
          ],
        ),
      ),
    );
  }

  // Hide loading dialog
  static void hideLoadingDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  // Copy to clipboard
  static Future<void> copyToClipboard(BuildContext context, String text) async {
    // You need to add clipboard package: flutter pub add clipboard
    // await Clipboard.setData(ClipboardData(text: text));
    showSnackBar(context, message: 'Tersalin ke clipboard');
  }

  // Get time of day greeting
  static String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Selamat Pagi';
    } else if (hour < 15) {
      return 'Selamat Siang';
    } else if (hour < 19) {
      return 'Selamat Sore';
    } else {
      return 'Selamat Malam';
    }
  }

  // Calculate percentage change
  static double calculatePercentageChange(double oldValue, double newValue) {
    if (oldValue == 0) return 0;
    return ((newValue - oldValue) / oldValue * 100);
  }

  // Format percentage
  static String formatPercentage(double value) {
    final sign = value >= 0 ? '+' : '';
    return '$sign${value.toStringAsFixed(1)}%';
  }

  // Get alert severity color
  static Color getAlertColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'critical':
        return Colors.red;
      case 'high':
        return Colors.orange;
      case 'medium':
        return Colors.yellow[700]!;
      case 'low':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  // Get alert icon
  static IconData getAlertIcon(String severity) {
    switch (severity.toLowerCase()) {
      case 'critical':
        return Icons.error;
      case 'high':
        return Icons.warning;
      case 'medium':
        return Icons.info;
      case 'low':
        return Icons.notifications;
      default:
        return Icons.info;
    }
  }

  // Generate random color
  static Color getRandomColor() {
    final colors = AppConstants.chartColors;
    return colors[DateTime.now().millisecond % colors.length];
  }

  // Debounce function
  static Function debounce(Function func, Duration delay) {
    Timer? timer;
    return () {
      timer?.cancel();
      timer = Timer(delay, () => func());
    };
  }

  // Throttle function
  static Function throttle(Function func, Duration duration) {
    bool waiting = false;
    return () {
      if (!waiting) {
        func();
        waiting = true;
        Timer(duration, () => waiting = false);
      }
    };
  }

  // Capitalize first letter
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  // Truncate text with ellipsis
  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  // Calculate reading time
  static String calculateReadingTime(String text) {
    final wordsPerMinute = 200;
    final wordCount = text.split(' ').length;
    final minutes = (wordCount / wordsPerMinute).ceil();
    return '$minutes min';
  }

  // Check if dark mode is active
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  // Get contrast color
  static Color getContrastColor(Color color) {
    final luminance =
        (0.299 * color.red + 0.587 * color.green + 0.114 * color.blue) / 255;
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}

// Extension methods for DateTime
extension DateTimeExtension on DateTime {
  DateTime get startOfDay => DateTime(year, month, day);
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59);
  DateTime get startOfWeek => subtract(Duration(days: weekday - 1));
  DateTime get startOfMonth => DateTime(year, month, 1);
  DateTime get endOfMonth => DateTime(year, month + 1, 0);
  bool isToday() {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

// Extension methods for String
extension StringExtension on String {
  bool get isNullOrEmpty => isEmpty;
  bool get isNotNullOrEmpty => !isEmpty;
  String toTitleCase() {
    return split(' ').map((word) => AppHelpers.capitalize(word)).join(' ');
  }

  bool containsIgnoreCase(String other) {
    return toLowerCase().contains(other.toLowerCase());
  }
}

// Extension methods for List
extension ListExtension<T> on List<T> {
  List<T> get safeSublist {
    try {
      return sublist(0, length > 3 ? 3 : length);
    } catch (e) {
      return [];
    }
  }

  T? get safeFirst => isEmpty ? null : first;
  T? get safeLast => isEmpty ? null : last;
}

// Extension methods for double
extension DoubleExtension on double {
  String toFormattedString({int decimals = 2}) {
    return toStringAsFixed(decimals);
  }

  String toPercentageString() {
    return '${(this * 100).toFormattedString(decimals: 1)}%';
  }
}
