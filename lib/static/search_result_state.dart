import 'package:restaurant_app/data/model/restaurant.dart';

sealed class SearchResultState {}

final class SearchInitialState extends SearchResultState {}

final class SearchLoadingState extends SearchResultState {}

final class SearchLoadedState extends SearchResultState {
  final List<Restaurant> restaurants;
  SearchLoadedState(this.restaurants);
}

final class SearchNoDataState extends SearchResultState {
  final String message;
  SearchNoDataState(this.message);
}

final class SearchErrorState extends SearchResultState {
  final String message;
  SearchErrorState(this.message);
}