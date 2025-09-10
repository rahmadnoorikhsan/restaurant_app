import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  static final StreamController<String?> _selectNotificationStream =
      StreamController<String?>.broadcast();

  static Stream<String?> get selectNotificationStream =>
      _selectNotificationStream.stream;

  static void disposeStream() {
    _selectNotificationStream.close();
  }

  static const _dailyReminderNotificationId = 1001;
  static const _androidChannelId = 'daily_recommendation_channel';
  static const _androidChannelName = 'Daily Recommendation';

  final FlutterLocalNotificationsPlugin _localNotificationsPlugin;

  LocalNotificationService(this._localNotificationsPlugin);

  Future<void> init() async {
    await _configureLocalTimeZone();
    await _initializeNotifications();
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  static void _onDidReceiveNotificationResponse(NotificationResponse details) {
    final payload = details.payload;
    if (payload != null && payload.isNotEmpty) {
      _selectNotificationStream.add(payload);
    }
  }

  Future<void> _initializeNotifications() async {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final initializationSettingsDarwin = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await _localNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse:
          _onDidReceiveNotificationResponse,
    );
  }

  Future<bool> requestPermissions() async {
    if (Platform.isIOS) {
      return await _localNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  IOSFlutterLocalNotificationsPlugin>()
              ?.requestPermissions(alert: true, badge: true, sound: true) ??
          false;
    } else if (Platform.isAndroid) {
      final plugin = _localNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      return await plugin?.requestNotificationsPermission() ?? false;
    }
    return false;
  }

  Future<void> scheduleDailyReminder(List<Restaurant> restaurants) async {
    final random = Random();
    final randomRestaurant = restaurants[random.nextInt(restaurants.length)];
    final restaurantPayload = randomRestaurant.id;

    final androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      _androidChannelId,
      _androidChannelName,
      channelDescription: 'Channel for daily restaurant recommendations',
      importance: Importance.max,
      priority: Priority.high,
    );

    DarwinNotificationDetails? iOSPlatformChannelSpecifics;
    if (!kIsWeb && Platform.isIOS) {
      iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    }

    final notificationDetails = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    debugPrint("Menjadwalkan notifikasi untuk: ${_nextInstanceOfElevenAM()}");

    await _localNotificationsPlugin.zonedSchedule(
      _dailyReminderNotificationId,
      'Rekomendasi Restoran Hari Ini!',
      'Yuk, mampir ke ${randomRestaurant.name} untuk makan siang!',
      _nextInstanceOfElevenAM(),
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: restaurantPayload,
    );
  }

  tz.TZDateTime _nextInstanceOfElevenAM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 11);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  Future<void> cancelDailyReminder() async {
    await _localNotificationsPlugin.cancel(_dailyReminderNotificationId);
  }
}