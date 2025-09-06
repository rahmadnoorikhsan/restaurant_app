import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app/screen/detail/detail_view.dart';
import 'package:restaurant_app/static/restaurant_detail_result_state.dart';
import 'package:restaurant_app/widget/error_state_widget.dart';

class DetailScreen extends StatelessWidget {
  final String restaurantId;

  const DetailScreen({super.key, required this.restaurantId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantDetailProvider>(
      create: (_) => RestaurantDetailProvider(
        apiService: ApiService(),
        restaurantId: restaurantId,
      ),
      child: Scaffold(
        body: Consumer<RestaurantDetailProvider>(
          builder: (context, value, child) {
            return switch (value.resultState) {
              RestaurantDetailLoadingState() =>
                const Center(child: CircularProgressIndicator()),
              RestaurantDetailLoadedState() => DetailView(),
              RestaurantDetailErrorState(error: var message) => ErrorStateWidget(
                message: message,
                onRetry: () {
                  value.fetchRestaurantDetail();
                },
              ),
              _ => const SizedBox(),
            };
          },
        ),
      ),
    );
  }
}