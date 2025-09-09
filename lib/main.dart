import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/local/local_database_service.dart';
import 'package:restaurant_app/data/preferences/settings_preferences.dart';
import 'package:restaurant_app/provider/bookmark/local_database_provider.dart';
import 'package:restaurant_app/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app/provider/main/index_nav_provider.dart';
import 'package:restaurant_app/provider/search/search_provider.dart';
import 'package:restaurant_app/provider/settings/scheduling_provider.dart';
import 'package:restaurant_app/provider/settings/theme_provider.dart';
import 'package:restaurant_app/screen/detail/detail_screen.dart';
import 'package:restaurant_app/screen/main/main_screen.dart';
import 'package:restaurant_app/services/local_notification_service.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/theme/theme.dart';
import 'package:restaurant_app/theme/util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final flutterLocalNotificationPlugin = FlutterLocalNotificationsPlugin();
  final localNotificationService =
      LocalNotificationService(flutterLocalNotificationPlugin);
  await localNotificationService.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => IndexNavProvider()),
        Provider(create: (context) => ApiService()),
        ChangeNotifierProvider(
          create: (context) =>
              RestaurantListProvider(context.read<ApiService>()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              SearchProvider(apiService: context.read<ApiService>()),
        ),
        Provider(create: (context) => LocalDatabaseService()),
        ChangeNotifierProvider(
          create: (context) =>
              LocalDatabaseProvider(context.read<LocalDatabaseService>()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              ThemeProvider(themePreference: SettingsPreference()),
        ),
        ChangeNotifierProvider(
          create: (_) => SchedulingProvider(
            settingsPreference: SettingsPreference(),
            apiService: ApiService(),
            localNotificationService: localNotificationService,
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "Poppins", "Poppins");
    MaterialTheme theme = MaterialTheme(textTheme);
    return Consumer<ThemeProvider>(
      builder: (context, provider, child) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          title: 'Restaurant App',
          debugShowCheckedModeBanner: false,
          theme: theme.light(),
          darkTheme: theme.dark(),
          themeMode: provider.themeMode,
          initialRoute: NavigationRoute.mainRoute.name,
          routes: {
            NavigationRoute.mainRoute.name: (context) => const MainScreen(),
            NavigationRoute.detailRoute.name: (context) => DetailScreen(
              restaurantId:
                  ModalRoute.of(context)?.settings.arguments as String,
            ),
          },
        );
      },
    );
  }
}
