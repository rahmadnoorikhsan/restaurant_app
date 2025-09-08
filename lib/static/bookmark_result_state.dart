import 'package:restaurant_app/data/model/restaurant.dart';

sealed class BookmarkResultState {}

final class BookmarkLoadingState extends BookmarkResultState {}

final class BookmarkLoadedState extends BookmarkResultState {
  final List<Restaurant> bookmarks;
  BookmarkLoadedState(this.bookmarks);
}

final class BookmarkEmptyState extends BookmarkResultState {
  final String message;
  BookmarkEmptyState(this.message);
}

final class BookmarkErrorState extends BookmarkResultState {
  final String message;
  BookmarkErrorState(this.message);
}