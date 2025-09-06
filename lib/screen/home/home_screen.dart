import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app/static/restaurant_list_result_state.dart';
import 'package:restaurant_app/widget/error_state_widget.dart';
import 'package:restaurant_app/widget/restaurant_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<RestaurantListProvider>().fetchRestaurantList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<RestaurantListProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text("Rekomendasi Restoran")),
      body: Consumer<RestaurantListProvider>(
        builder: (context, value, child) {
          return switch (value.resultState) {
            RestaurantListLoadingState() => const Center(
              child: CircularProgressIndicator(),
            ),
            RestaurantListErrorState(error: var message) => ErrorStateWidget(
              message: message,
              onRetry: () {
                provider.fetchRestaurantList();
              },
            ),
            RestaurantListLoadedState(restaurants: var restaurants) =>
              ListView.builder(
                itemCount: restaurants.length,
                itemBuilder: (context, index) {
                  final restaurant = restaurants[index];

                  return RestaurantCardWidget(
                    restaurant: restaurant,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/detail',
                        arguments: restaurant.id,
                      );
                    },
                  );
                },
              ),
            _ => const SizedBox(),
          };
        },
      ),
    );
  }
}
