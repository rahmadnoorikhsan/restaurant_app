import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/bookmark/local_database_provider.dart';
import 'package:restaurant_app/static/bookmark_result_state.dart';
import 'package:restaurant_app/widget/error_state_widget.dart';
import 'package:restaurant_app/widget/restaurant_card_widget.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Restoran Favorit')),
      body: Consumer<LocalDatabaseProvider>(
        builder: (context, provider, child) {
          return switch (provider.resultState) {
            BookmarkLoadingState() => const Center(
              child: CircularProgressIndicator(),
            ),

            BookmarkErrorState(message: var message) => ErrorStateWidget(
              message: message,
              onRetry: () {
                provider.loadAllRestaurant();
              },
            ),

            BookmarkEmptyState(message: var message) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bookmark_remove_outlined,
                    size: 80,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    message,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            BookmarkLoadedState(bookmarks: var bookmarks) => ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: bookmarks.length,
              itemBuilder: (context, index) {
                final restaurant = bookmarks[index];
                return RestaurantCardWidget(
                  restaurant: restaurant,
                  onTap: () => Navigator.pushNamed(
                    context,
                    '/detail',
                    arguments: restaurant.id,
                  ),
                );
              },
            ),
          };
        },
      ),
    );
  }
}
