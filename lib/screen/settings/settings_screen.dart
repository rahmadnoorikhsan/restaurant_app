import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/settings/scheduling_provider.dart';
import 'package:restaurant_app/provider/settings/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Tema'),
            subtitle: Consumer<ThemeProvider>(
              builder: (context, provider, child) {
                final themeOptions = {
                  'Terang': ThemeMode.light,
                  'Gelap': ThemeMode.dark,
                  'Sistem': ThemeMode.system,
                };

                return SegmentedButton<ThemeMode>(
                  segments: themeOptions.entries.map((entry) {
                    IconData icon;
                    switch (entry.value) {
                      case ThemeMode.light:
                        icon = Icons.light_mode;
                        break;
                      case ThemeMode.dark:
                        icon = Icons.dark_mode;
                        break;
                      case ThemeMode.system:
                        icon = Icons.brightness_auto;
                        break;
                    }
                    return ButtonSegment(
                      value: entry.value,
                      label: Text(entry.key),
                      icon: Icon(icon),
                    );
                  }).toList(),

                  selected: <ThemeMode>{provider.themeMode},
                  onSelectionChanged: (newSelection) {
                    provider.setThemeMode(newSelection.first);
                  },
                );
              },
            ),
          ),
          const Divider(indent: 16, endIndent: 16),
          Consumer<SchedulingProvider>(
            builder: (context, provider, child) {
              return SwitchListTile(
                title: const Text('Rekomendasi Harian'),
                subtitle: const Text('Aktifkan pengingat makan siang'),
                value: provider.isScheduled,
                onChanged: (value) {
                  provider.setScheduledRecommendation(value);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}