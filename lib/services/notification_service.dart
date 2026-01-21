import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart' show FlutterLocalNotificationsPlugin, AndroidInitializationSettings, DarwinInitializationSettings, InitializationSettings, AndroidFlutterLocalNotificationsPlugin, IOSFlutterLocalNotificationsPlugin, Importance, Priority, AndroidNotificationDetails, RawResourceAndroidNotificationSound, DarwinNotificationDetails, NotificationDetails, PendingNotificationRequest, NotificationResponse, DrawableResourceAndroidBitmap, BigTextStyleInformation, DateTimeComponents, AndroidScheduleMode;
import 'package:timezone/timezone.dart' as tz show TZDateTime, local;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  // Singleton instance
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  late FlutterLocalNotificationsPlugin _notificationsPlugin;

  Future<void> initialize() async {
    tz.initializeTimeZones();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
          requestSoundPermission: true,
          requestBadgePermission: true,
          requestAlertPermission: true,
        );

    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS,
        );

    _notificationsPlugin = FlutterLocalNotificationsPlugin();
    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTap,
    );

    // Request permissions
    await _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();

    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  // Send immediate notification
  Future<void> showNotification({
    required String title,
    required String body,
    String? channelId = 'ecoguard_alerts',
    String? channelName = 'EcoGuard Alerts',
    Importance importance = Importance.high,
    Priority priority = Priority.high,
    String? payload,
  }) async {
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'ecoguard_alerts',
          'EcoGuard Alerts',
          channelDescription: 'Notifications for energy and water alerts',
          importance: Importance.high,
          priority: Priority.high,
          ticker: 'ticker',
          colorized: true,
          color: Colors.green,
          enableVibration: true,
          vibrationPattern: Int64List.fromList([0, 250, 250, 250]),
          playSound: true,
          sound: const RawResourceAndroidNotificationSound('notification_sound'),
          largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
          styleInformation: BigTextStyleInformation(''),
        );

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
          sound: 'default',
        );

    final NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await _notificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  // Schedule notification
  Future<void> scheduleNotification({
    required String title,
    required String body,
    required DateTime scheduledTime,
    String? payload,
  }) async {
    final tz.TZDateTime scheduledDate = tz.TZDateTime.from(
      scheduledTime,
      tz.local,
    );

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'ecoguard_scheduled',
          'EcoGuard Scheduled',
          channelDescription: 'Scheduled notifications for EcoGuard',
          importance: Importance.high,
          priority: Priority.high,
        );

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails();

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await _notificationsPlugin.zonedSchedule(
      scheduledTime.millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      scheduledDate,
      platformChannelSpecifics,
      payload: payload,
      matchDateTimeComponents: DateTimeComponents.time,
      androidScheduleMode: AndroidScheduleMode.alarmClock,
    );
  }

  // Schedule recurring notifications
  Future<void> scheduleDailyNotification({
    required String title,
    required String body,
    required TimeOfDay time,
    String? payload,
  }) async {
    final now = DateTime.now();
    final scheduledTime = DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    final tz.TZDateTime scheduledDate = tz.TZDateTime.from(
      scheduledTime,
      tz.local,
    );

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'ecoguard_daily',
          'EcoGuard Daily',
          channelDescription: 'Daily reminders from EcoGuard',
          importance: Importance.defaultImportance,
          priority: Priority.defaultPriority,
        );

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails();

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await _notificationsPlugin.zonedSchedule(
      scheduledTime.millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      scheduledDate,
      platformChannelSpecifics,
      payload: payload,
      matchDateTimeComponents: DateTimeComponents.time,
      androidScheduleMode: AndroidScheduleMode.alarmClock,
    );
  }

  // Cancel notification by ID
  Future<void> cancelNotification(int id) async {
    await _notificationsPlugin.cancel(id);
  }

  // Cancel all notifications
  Future<void> cancelAllNotifications() async {
    await _notificationsPlugin.cancelAll();
  }

  // Get pending notifications
  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await _notificationsPlugin.pendingNotificationRequests();
  }

  // Notification tap handler
  void _onNotificationTap(NotificationResponse notificationResponse) {
    final String? payload = notificationResponse.payload;

    // Handle notification tap based on payload
    if (payload != null) {
      // Navigate to specific screen based on payload
      print('Notification tapped with payload: $payload');

      // You can use a navigation service or event bus here
      // For example: EventBus().fire(NotificationTappedEvent(payload));
    }
  }

  // Alert-specific notifications
  Future<void> showEnergyAlert(
    String message,
    double consumption,
    double threshold,
  ) async {
    await showNotification(
      title: '⚡ Alert Energi Tinggi',
      body:
          '$message\nKonsumsi: ${consumption.toStringAsFixed(1)} kWh\nThreshold: ${threshold.toStringAsFixed(1)} kWh',
      payload: 'energy_alert',
    );
  }

  Future<void> showWaterAlert(
    String message,
    double consumption,
    double threshold,
  ) async {
    await showNotification(
      title: '💧 Alert Air Tinggi',
      body:
          '$message\nKonsumsi: ${consumption.toStringAsFixed(1)} L\nThreshold: ${threshold.toStringAsFixed(1)} L',
      payload: 'water_alert',
    );
  }

  Future<void> showAIAnalysisComplete() async {
    await showNotification(
      title: '🤖 Analisis AI Selesai',
      body:
          'EcoGuard AI telah menganalisis data terbaru dan menemukan peluang penghematan baru.',
      payload: 'ai_analysis',
    );
  }

  Future<void> showEcoScoreUpdate(int newScore, int change) async {
    final changeText = change >= 0 ? '+$change' : '$change';
    await showNotification(
      title: '📈 Eco Score Diperbarui',
      body:
          'Score Anda: $newScore ($changeText)\nTerus tingkatkan efisiensi Anda!',
      payload: 'eco_score',
    );
  }

  // Schedule regular alerts
  Future<void> scheduleRegularAlerts() async {
    // Daily summary at 8 PM
    await scheduleDailyNotification(
      title: '📊 Ringkasan Harian',
      body: 'Lihat konsumsi energi dan air Anda hari ini',
      time: const TimeOfDay(hour: 20, minute: 0),
      payload: 'daily_summary',
    );

    // Weekly report every Monday at 9 AM
    final now = DateTime.now();
    final nextMonday = now.add(Duration(days: (8 - now.weekday) % 7));
    await scheduleNotification(
      title: '📋 Laporan Mingguan',
      body: 'Laporan efisiensi mingguan Anda sudah siap',
      scheduledTime: DateTime(
        nextMonday.year,
        nextMonday.month,
        nextMonday.day,
        9,
        0,
      ),
      payload: 'weekly_report',
    );

    // Monthly reminder on 1st of month
    if (now.day == 1) {
      await scheduleNotification(
        title: '📈 Laporan Bulanan',
        body: 'Tinjau performa efisiensi bulan lalu',
        scheduledTime: DateTime(now.year, now.month, 1, 10, 0),
        payload: 'monthly_report',
      );
    }
  }

  // Check and send threshold alerts
  Future<void> checkAndSendThresholdAlerts(
    Map<String, double> currentValues,
    Map<String, double> thresholds,
  ) async {
    for (final resource in thresholds.keys) {
      final current = currentValues[resource] ?? 0;
      final threshold = thresholds[resource] ?? 0;

      if (current > threshold) {
        if (resource == 'electricity') {
          await showEnergyAlert('Konsumsi melebihi batas', current, threshold);
        } else if (resource == 'water') {
          await showWaterAlert('Konsumsi melebihi batas', current, threshold);
        }
      }
    }
  }
}

