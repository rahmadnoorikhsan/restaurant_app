import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/static/restaurant_detail_result_state.dart';

class RestaurantDetailProvider extends ChangeNotifier{
  final ApiService apiService;
  final String restaurantId;

  RestaurantDetailProvider({
    required this.apiService,
    required this.restaurantId,
  }) {
    fetchRestaurantDetail();
  }

  RestaurantDetailResultState _resultState = RestaurantDetailNoneState();
  RestaurantDetailResultState get resultState => _resultState;

  bool _isSubmitting = false;
  bool get isSubmitting => _isSubmitting;

  String _reviewMessage = '';
  String get reviewMessage => _reviewMessage;

  Future<void> fetchRestaurantDetail() async {
    try {
      _resultState = RestaurantDetailLoadingState();
      notifyListeners();

      final result = await apiService.getRestaurantDetail(restaurantId);

      if (result.error) {
        _resultState = RestaurantDetailErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = RestaurantDetailLoadedState(result.restaurant);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error fetching restaurant list: $e');
      _resultState = RestaurantDetailErrorState(
        'Gagal terhubung ke server. Periksa koneksi internet Anda.',
      );
      notifyListeners();
    }
  }

  Future<void> addReview(String name, String review) async {
    try {
      _isSubmitting = true;
      _reviewMessage = '';
      notifyListeners();

      final newReviews = await apiService.postReview(
        id: restaurantId,
        name: name,
        review: review,
      );

      if (_resultState is RestaurantDetailLoadedState) {
        final currentState = _resultState as RestaurantDetailLoadedState;
        final updatedRestaurant = currentState.restaurant.copyWith(
          customerReviews: newReviews,
        );
        _resultState = RestaurantDetailLoadedState(updatedRestaurant);
        _reviewMessage = 'Ulasan berhasil ditambahkan!';
        notifyListeners();
      }
    } catch (e) {
      _reviewMessage = 'Gagal mengirim ulasan: $e';
      notifyListeners();
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }
  }
}