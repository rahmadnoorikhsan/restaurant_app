import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/preferences/settings_preferences.dart';
import 'package:restaurant_app/services/local_notification_service.dart';

class SchedulingProvider extends ChangeNotifier {
  final SettingsPreference settingsPreference;
  final ApiService apiService;
  final LocalNotificationService localNotificationService;

  SchedulingProvider({
    required this.settingsPreference,
    required this.apiService,
    required this.localNotificationService,
  }) {
    _getDailyReminderStatus();
  }

  bool _isScheduled = false;
  bool get isScheduled => _isScheduled;

  void _getDailyReminderStatus() async {
    _isScheduled = await settingsPreference.isDailyReminderActive;
    notifyListeners();
  }

  Future<void> setScheduledRecommendation(bool value) async {
    await settingsPreference.setDailyReminder(value);
    _isScheduled = value;
    notifyListeners();

    if (value) {
      debugPrint('Reminder diaktifkan, menjadwalkan notifikasi...');
      final isPermissionGranted = await localNotificationService
          .requestPermissions();
      if (isPermissionGranted) {
        debugPrint('Izin diberikan. Menjadwalkan notifikasi...');
        final restaurantList = await apiService.getRestaurantList();
        if (restaurantList.restaurants.isNotEmpty) {
          await localNotificationService.scheduleDailyReminder(
            restaurantList.restaurants,
          );
        }
      } else {
        debugPrint('Izin ditolak.');
      }
    } else {
      debugPrint('Reminder di matikan, membatalkan notifikasi...');
      await localNotificationService.cancelDailyReminder();
    }
  }
}
