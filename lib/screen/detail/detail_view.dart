import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app/static/restaurant_detail_result_state.dart';
import 'package:restaurant_app/widget/detail/detail_restaurant_header.dart';
import 'package:restaurant_app/widget/detail/detail_silver_appbar.dart';
import 'package:restaurant_app/widget/detail/menu_list.dart';
import 'package:restaurant_app/widget/detail/review_card.dart';
import 'package:restaurant_app/widget/detail/review_sheet.dart';
import 'package:restaurant_app/widget/detail/section_title.dart';

class DetailView extends StatelessWidget {
  const DetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<RestaurantDetailProvider>().resultState;

    if (state is RestaurantDetailLoadedState) {
      final detailRestaurant = state.restaurant;
      return CustomScrollView(
        slivers: [
          DetailSliverAppBar(restaurant: detailRestaurant),
          SliverPadding(
            padding: const EdgeInsets.all(20.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                DetailRestaurantHeader(restaurant: detailRestaurant),
                const Divider(height: 40),
                const SectionTitle(title: "Deskripsi"),
                const SizedBox(height: 10),
                Text(
                  detailRestaurant.description,
                  textAlign: TextAlign.justify,
                ),
                const Divider(height: 40),
                const SectionTitle(title: "Menu"),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MenuList(
                      title: "Makanan",
                      icon: Icons.restaurant_menu,
                      items: detailRestaurant.menus.foods,
                    ),
                    const SizedBox(width: 16),
                    MenuList(
                      title: "Minuman",
                      icon: Icons.local_bar,
                      items: detailRestaurant.menus.drinks,
                    ),
                  ],
                ),
                const Divider(height: 40),
                const SectionTitle(title: "Ulasan Pelanggan"),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 20.0,
                  ),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      final provider = context.read<RestaurantDetailProvider>();

                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (sheetContext) {
                          return ChangeNotifierProvider.value(
                            value: provider,
                            child: const ReviewSheet(),
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.add_comment),
                    label: const Text('Tambah Ulasan'),
                  ),
                ),
                ...detailRestaurant.customerReviews.reversed.map(
                  (review) => ReviewCard(review: review),
                ),
              ]),
            ),
          ),
        ],
      );
    }
    return const SizedBox.shrink();
  }
}
