import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/bookmark/local_database_provider.dart';

class BookmarkIconWidget extends StatelessWidget {
  final Restaurant restaurant;
  const BookmarkIconWidget({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocalDatabaseProvider>(
      builder: (context, provider, child) {
        final isBookmarked = provider.isBookmarked(restaurant.id);

        return IconButton(
          onPressed: () async {
            if (isBookmarked) {
              await provider.removeRestaurantById(restaurant.id);
            } else {
              await provider.saveRestaurant(restaurant);
            }

            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(provider.message),
                  duration: const Duration(seconds: 1),
                ),
              );
            }
          },
          icon: Icon(
            isBookmarked ? Icons.bookmark : Icons.bookmark_border,
            color: Theme.of(context).colorScheme.primary,
          ),
        );
      },
    );
  }
}
