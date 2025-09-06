import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';

class DetailSliverAppBar extends StatelessWidget {
  final RestaurantDetail restaurant;

  const DetailSliverAppBar({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SliverAppBar(
      expandedHeight: 250.0,
      pinned: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 1,
      foregroundColor: colorScheme.primary,

      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        title: Text(
          restaurant.name,
          style: textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                blurRadius: 8.0,
                color: colorScheme.scrim.withAlpha(200),
              ),
            ],
          ),
          overflow: TextOverflow.ellipsis,
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Hero(
              tag: restaurant.pictureId,
              child: Image.network(
                restaurant.largeImageUrl,
                fit: BoxFit.cover,
                errorBuilder: (ctx, error, stackTrace) =>
                    const Icon(Icons.error, color: Colors.white),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.6, 1.0],
                  colors: [
                    Colors.transparent,
                    colorScheme.scrim,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}