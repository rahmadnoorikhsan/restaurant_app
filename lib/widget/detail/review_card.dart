import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/customer_review.dart';

class ReviewCard extends StatelessWidget {
  final CustomerReview review;
  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      color: colorScheme.surfaceContainerHighest,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(review.name, style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
            Text(review.date, style: textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant)),
            const SizedBox(height: 2),
            Text('"${review.review}"', style: textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic)),
          ],
        ),
      ),
    );
  }
}