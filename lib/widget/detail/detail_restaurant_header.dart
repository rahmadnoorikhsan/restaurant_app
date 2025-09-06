import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';

class DetailRestaurantHeader extends StatelessWidget {
  final RestaurantDetail restaurant;

  const DetailRestaurantHeader({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.location_on, color: colorScheme.onSurfaceVariant, size: 16),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                '${restaurant.address}, ${restaurant.city}',
                style: textTheme.bodyMedium,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Icon(Icons.star, color: colorScheme.primary, size: 16),
            const SizedBox(width: 4),
            Text(restaurant.rating.toString(), style: textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8.0,
          children: restaurant.categories
              .map(
                (category) => Chip(
                  label: Text(category.name),
                  backgroundColor: colorScheme.secondaryContainer,
                  labelStyle: TextStyle(color: colorScheme.onSecondaryContainer),
                  side: BorderSide.none,
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
