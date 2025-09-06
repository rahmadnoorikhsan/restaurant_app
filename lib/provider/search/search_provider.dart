import 'dart:async';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/static/search_result_state.dart';

class SearchProvider extends ChangeNotifier {
  final ApiService apiService;
  String _query = '';
  String get query => _query;

  SearchProvider({required this.apiService});

  SearchResultState _resultState = SearchInitialState();
  Timer? _debounce;

  SearchResultState get resultState => _resultState;

  void searchRestaurants(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _performSearch(query);
    });
  }

  Future<void> _performSearch(String query) async {
    _query = query;
    if (query.isEmpty) {
      _resultState = SearchInitialState();
      notifyListeners();
      return;
    }

    try {
      _resultState = SearchLoadingState();
      notifyListeners();

      final result = await apiService.searchRestaurants(query);

      if (result.restaurants.isEmpty) {
        _resultState = SearchNoDataState('Restoran tidak ditemukan.');
        notifyListeners();
      } else {
        _resultState = SearchLoadedState(result.restaurants);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error fetching restaurant list: $e');
      _resultState = SearchErrorState(
        'Gagal terhubung ke server. Periksa koneksi internet Anda.',
      );
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
