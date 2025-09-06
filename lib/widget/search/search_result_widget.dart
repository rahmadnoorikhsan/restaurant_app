import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/search/search_provider.dart';
import 'package:restaurant_app/screen/detail/detail_screen.dart';
import 'package:restaurant_app/static/search_result_state.dart';
import 'package:restaurant_app/widget/error_state_widget.dart';
import 'package:restaurant_app/widget/restaurant_card_widget.dart';

class SearchResultWidget extends StatelessWidget {
  const SearchResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<SearchProvider>(
        builder: (context, provider, child) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _buildStateContent(context, provider),
          );
        },
      ),
    );
  }

  Widget _buildStateContent(BuildContext context, SearchProvider provider) {
    return switch (provider.resultState) {
      SearchInitialState() => _buildInfoWidget(
        context,
        icon: Icons.search,
        message: 'Cari restoran favoritmu!',
      ),
      SearchLoadingState() => const Center(child: CircularProgressIndicator()),
      SearchErrorState(message: var message) => ErrorStateWidget(
        key: const ValueKey('error_search'),
        message: message,
        onRetry: () {
          provider.searchRestaurants(provider.query);
        },
      ),
      SearchNoDataState(message: var message) => _buildInfoWidget(
        context,
        icon: Icons.search_off,
        message: message,
      ),
      SearchLoadedState(restaurants: var restaurants) => ListView.builder(
        key: const ValueKey('restaurant_list'),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          final restaurant = restaurants[index];
          return RestaurantCardWidget(
            restaurant: restaurant,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(restaurantId: restaurant.id),
              ),
            ),
          );
        },
      ),
    };
  }

  Widget _buildInfoWidget(
    BuildContext context, {
    required IconData icon,
    required String message,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      key: ValueKey(message),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 80, color: colorScheme.onSurfaceVariant),
          const SizedBox(height: 16),
          Text(
            message,
            style: textTheme.titleMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
