import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/widget/restaurant_card_widget.dart';

void main() {
  group('RestaurantCardWidget Test', () {
    testWidgets('should display restaurant name and city correctly',
        (WidgetTester tester) async {
      final restaurant = Restaurant(
        id: "1", name: "Kafe Mock", description: "Desc",
        pictureId: "1", city: "Kota Mock", rating: 4.0
      );

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: RestaurantCardWidget(
            restaurant: restaurant,
            onTap: () {},
          ),
        ),
      ));

      final nameFinder = find.text('Kafe Mock');
      final cityFinder = find.text('Kota Mock');

      expect(nameFinder, findsOneWidget);
      expect(cityFinder, findsOneWidget);
    });
  });
}