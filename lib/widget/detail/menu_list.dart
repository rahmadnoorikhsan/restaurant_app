import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/category.dart';

class MenuList extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Category> items;

  const MenuList({
    super.key,
    required this.title,
    required this.icon,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: colorScheme.secondary),
              const SizedBox(width: 8),
              Text(title, style: textTheme.titleMedium),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: items
                  .map((item) => Text("• ${item.name}", style: textTheme.bodyMedium))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}