import 'dart:convert';
import 'package:restaurant_app/data/model/customer_review.dart';
import 'package:restaurant_app/data/model/restaurant_detail_response.dart';
import 'package:restaurant_app/data/model/restaurant_list_response.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/search_response.dart';

class ApiService {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev";

  Future<RestaurantListResponse> getRestaurantList() async {
    final response = await http.get(Uri.parse("$_baseUrl/list"));

    if (response.statusCode == 200) {
      return RestaurantListResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal memuat daftar restoran');
    }
  }

  Future<RestaurantDetailResponse> getRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse("$_baseUrl/detail/$id"));

    if (response.statusCode == 200) {
      return RestaurantDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal memuat detail restoran');
    }
  }

  Future<List<CustomerReview>> postReview({
    required String id,
    required String name,
    required String review,
  }) async {
    final body = jsonEncode({'id': id, 'name': name, 'review': review});

    final headers = {'Content-Type': 'application/json'};

    final response = await http.post(
      Uri.parse("$_baseUrl/review"),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final List<dynamic> reviewsJson = jsonResponse['customerReviews'];

      return reviewsJson.map((json) => CustomerReview.fromJson(json)).toList();
    } else {
      throw Exception('Gagal mengirim ulasan.');
    }
  }

  Future<SearchResponse> searchRestaurants(String query) async {
    final response = await http.get(Uri.parse("$_baseUrl/search?q=$query"));

    if (response.statusCode == 200) {
      return SearchResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal mencari restoran.');
    }
  }
}
