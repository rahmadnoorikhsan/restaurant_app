import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:restaurant_app/main.dart' as app;
import 'package:restaurant_app/screen/detail/detail_screen.dart';
import 'package:restaurant_app/widget/restaurant_card_widget.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App Integration Test', () {
    testWidgets('tap on a restaurant card should navigate to detail screen', (tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      final firstRestaurantCard = find.byType(RestaurantCardWidget).first;
      expect(firstRestaurantCard, findsOneWidget);
      await tester.tap(firstRestaurantCard);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      final detailScreen = find.byType(DetailScreen);
      expect(detailScreen, findsOneWidget);
    });
  });
}