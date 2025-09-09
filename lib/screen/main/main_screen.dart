import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/main/index_nav_provider.dart';
import 'package:restaurant_app/screen/bookmark/bookmark_screen.dart';
import 'package:restaurant_app/screen/home/home_screen.dart';
import 'package:restaurant_app/screen/search/search_screen.dart';
import 'package:restaurant_app/screen/settings/settings_screen.dart';
import 'package:restaurant_app/services/local_notification_service.dart';
import 'package:restaurant_app/static/navigation_route.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    LocalNotificationService.selectNotificationStream.listen((payload) {
      if (payload != null && payload.isNotEmpty) {
        debugPrint('Notification payload: $payload');
        navigatorKey.currentState?.pushNamed(
          NavigationRoute.detailRoute.name,
          arguments: payload,
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    LocalNotificationService.disposeStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Consumer<IndexNavProvider>(builder: (context, value, child) {
        final screens = [
          const HomeScreen(),
          const SearchScreen(),
          const BookmarkScreen(),
          const SettingsScreen(),
        ];
        return screens[value.indexBottomNavBar];
      }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: context.watch<IndexNavProvider>().indexBottomNavBar,
        onTap: (index) {
          context.read<IndexNavProvider>().setIndexBottomNavBar = index;
        },
        type: BottomNavigationBarType.fixed,

        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.onSurfaceVariant,

        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: "Home", tooltip: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.search), label: "Search", tooltip: "Search"),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark), label: "Bookmark", tooltip: "Bookmark"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings", tooltip: "Settings"),
        ],
      ),
    );
  }
}