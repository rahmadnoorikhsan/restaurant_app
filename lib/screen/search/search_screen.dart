import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/search/search_provider.dart';
import 'package:restaurant_app/widget/search/search_bar_widget.dart';
import 'package:restaurant_app/widget/search/search_result_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<SearchProvider>();
      _controller.text = provider.query;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = context.read<SearchProvider>();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cari Restoran'),
      ),
      body: Column(
        children: [
          SearchBarWidget(
            controller: _controller,
            onChanged: (query) {
              searchProvider.searchRestaurants(query);
            },
            onClear: () {
              _controller.clear();
              searchProvider.searchRestaurants('');
            },
          ),
          const SearchResultWidget(),
        ],
      ),
    );
  }
}