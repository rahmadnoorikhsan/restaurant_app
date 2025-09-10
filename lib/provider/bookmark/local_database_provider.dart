import 'package:flutter/material.dart';
import 'package:restaurant_app/data/local/local_database_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/static/bookmark_result_state.dart'; // <-- Impor sealed class

class LocalDatabaseProvider extends ChangeNotifier {
  final LocalDatabaseService _service;

  BookmarkResultState _resultState = BookmarkLoadingState();
  BookmarkResultState get resultState => _resultState;

  String _message = "";
  String get message => _message;

  List<Restaurant> _bookmarkList = [];
  List<Restaurant> get bookmarkList => _bookmarkList;

  LocalDatabaseProvider(this._service) {
    loadAllRestaurant();
  }

  Future<void> loadAllRestaurant() async {
    _resultState = BookmarkLoadingState();
    notifyListeners();

    try {
      _bookmarkList = await _service.getAllItems();
      if (_bookmarkList.isNotEmpty) {
        _resultState = BookmarkLoadedState(_bookmarkList);
      } else {
        _resultState = BookmarkEmptyState("Anda belum punya restoran favorit");
      }
    } catch (e) {
      _resultState = BookmarkErrorState("Gagal memuat data favorit");
    }
    notifyListeners();
  }

  Future<void> saveRestaurant(Restaurant value) async {
    try {
      await _service.insertItem(value);
      _message = "Berhasil ditambahkan ke favorit";
    } catch (e) {
      _message = "Gagal menambahkan ke favorit";
    }
    await loadAllRestaurant();
  }

  Future<void> removeRestaurantById(String id) async {
    try {
      await _service.removeItem(id);
      _message = "Berhasil dihapus dari favorit";
    } catch (e) {
      _message = "Gagal menghapus favorit";
    }
    await loadAllRestaurant();
  }

  bool isBookmarked(String id) {
    return _bookmarkList.any((restaurant) => restaurant.id == id);
  }
}