import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/model/restaurant_list_response.dart';
import 'package:restaurant_app/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app/static/restaurant_list_result_state.dart';
import 'mocks/mock_api_services.mocks.dart';

void main() {
  group('RestaurantListProvider', () {
    late MockApiService mockApiService;
    late RestaurantListProvider provider;

    setUp(() {
      mockApiService = MockApiService();
      provider = RestaurantListProvider(mockApiService);
    });

    final tRestaurant = Restaurant(
      id: "1",
      name: "Test Restaurant",
      description: "Test Desc",
      pictureId: "1",
      city: "Test City",
      rating: 4.5,
    );
    final tRestaurantListResponse =
        RestaurantListResponse(error: false, message: "success", count: 1, restaurants: [tRestaurant]);

    // Skenario 1: Memastikan state awal provider harus didefinisikan
    test('should have an initial state of None', () {
      expect(provider.resultState, isA<RestaurantListNoneState>());
    });

    // Skenario 2: Memastikan harus mengembalikan daftar restoran ketika pengambilan data API berhasil
    test('should get restaurant list successfully from the API', () async {
      when(mockApiService.getRestaurantList())
          .thenAnswer((_) async => tRestaurantListResponse);

      await provider.fetchRestaurantList();

      expect(provider.resultState, isA<RestaurantListLoadedState>());
      
      final loadedState = provider.resultState as RestaurantListLoadedState;
      expect(loadedState.restaurants.isNotEmpty, true);
      expect(loadedState.restaurants.first.name, "Test Restaurant");
    });

    // Skenario 3: Memastikan harus mengembalikan kesalahan ketika pengambilan data API gagal
    test('should return an error state when API call fails', () async {
      when(mockApiService.getRestaurantList())
          .thenThrow(Exception('Gagal memuat daftar restoran'));

      await provider.fetchRestaurantList();

      expect(provider.resultState, isA<RestaurantListErrorState>());
      
      final errorState = provider.resultState as RestaurantListErrorState;
      expect(errorState.error, isNotEmpty);
    });
  });
}