import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sida_mangan/common/constant.dart';
import 'package:sida_mangan/common/style.dart';
import 'package:sida_mangan/data/api/api_service.dart';
import 'package:sida_mangan/data/model/category_restaurant_model.dart';
import 'package:sida_mangan/data/model/customer_review_model.dart';
import 'package:sida_mangan/provider/database_provider.dart';
import 'package:sida_mangan/provider/detail_restaurant_provider.dart';
import 'package:sida_mangan/ui/detail_restaurant_page.dart';
import 'package:sida_mangan/utils/result_state.dart';
import 'package:sida_mangan/widgets/ratings_bar.dart';
import 'package:sida_mangan/widgets/review_restaurant.dart';
import 'package:sida_mangan/widgets/text_deskripsi.dart';

class CardDetailRestaurant extends StatelessWidget {
  const CardDetailRestaurant({
    super.key,
    required this.widget,
    required this.tabController,
  });

  final DetailRestaurant widget;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailRestaurantsProvider>(
      create: (_) =>
          DetailRestaurantsProvider(apiService: ApiService(), id: widget.id),
      child: Consumer<DetailRestaurantsProvider>(
        builder: (context, restaurant, _) {
          if (restaurant.state == ResultState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (restaurant.state == ResultState.hasData) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 300,
                  pinned: true,
                  leading: IconButton(
                    icon: Ink(
                      decoration: const ShapeDecoration(
                        color: Colors.white,
                        shape: CircleBorder(),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  flexibleSpace: Hero(
                    tag: restaurant.result.restaurant.id,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            imageUrl + restaurant.result.restaurant.pictureId,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  restaurant.result.restaurant.name,
                                  style: myTextTheme.bodyLarge,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  restaurant.result.restaurant.address,
                                  style: myTextTheme.bodySmall,
                                ),
                                const SizedBox(height: 10),
                                MyRatingBar(
                                  rating: restaurant.result.restaurant.rating,
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: restaurant
                                            .result.restaurant.category.length,
                                        itemBuilder: (_, index) => Container(
                                          margin:
                                              const EdgeInsets.only(right: 5),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 3,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          child: Text(
                                            restaurant.result.restaurant
                                                .category[index].name,
                                            style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.black45,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Text(
                                    restaurant.result.restaurant.city,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Consumer<DatabaseProvider>(
                                    builder: (context, provider, child) {
                                  return FutureBuilder<bool>(
                                    future: provider.isFavorited(restaurant.id),
                                    builder: (context, snapshot) {
                                      var isFavorited = snapshot.data ?? false;
                                      return Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 1),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Center(
                                          child: isFavorited
                                              ? IconButton(
                                                  icon: const Icon(
                                                    Icons.favorite,
                                                    size: 22,
                                                  ),
                                                  onPressed: () =>
                                                      provider.removeFavorit(
                                                          restaurant.id),
                                                )
                                              : IconButton(
                                                  icon: const Icon(
                                                    Icons
                                                        .favorite_border_outlined,
                                                    size: 22,
                                                  ),
                                                  onPressed: () => provider
                                                      .addFavorite(restaurant
                                                          .result.restaurant),
                                                ),
                                        ),
                                      );
                                    },
                                  );
                                }),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: ReadMoreText(
                          text: restaurant.result.restaurant.description,
                          maxLength: 120,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) => ReviewRestaurantWidget(
                                id: restaurant.result.restaurant.id,
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Center(
                              child: Text(
                                'Add Review',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: TabBar(
                          controller: tabController,
                          labelColor: Colors.white,
                          indicatorSize: TabBarIndicatorSize.tab,
                          dividerColor: Colors.transparent,
                          indicatorPadding: const EdgeInsets.symmetric(
                            vertical: 7,
                          ),
                          unselectedLabelColor: Colors.black,
                          indicator: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          tabs: [
                            Tab(
                              child: Text(
                                'Foods',
                                style: myTextTheme.bodyMedium,
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Drinks',
                                style: myTextTheme.bodyMedium,
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Reviews',
                                style: myTextTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 2.1,
                        child: TabBarView(
                          controller: tabController,
                          children: [
                            // Foods GridView
                            GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 2 / 2.1,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                              itemCount:
                                  restaurant.result.restaurant.menu.food.length,
                              itemBuilder: (context, index) {
                                Category food = restaurant
                                    .result.restaurant.menu.food[index];
                                return Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        ),
                                        child: Image.asset(
                                          'assets/images/food.jpg',
                                          height: 104,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      ListTile(
                                        title: Center(
                                          child: Text(
                                            food.name,
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                            // Drinks GridView
                            GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 2 / 2.1,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                              itemCount: restaurant
                                  .result.restaurant.menu.drink.length,
                              itemBuilder: (context, index) {
                                Category drink = restaurant
                                    .result.restaurant.menu.drink[index];
                                return Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        ),
                                        child: Image.asset(
                                          'assets/images/coffee.jpg',
                                          height: 104,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      ListTile(
                                        title: Center(
                                          child: Text(
                                            drink.name,
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),

                            // List Reviews
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              itemCount: restaurant
                                  .result.restaurant.customerReview.length,
                              itemBuilder: (context, index) {
                                List<CustomerReview> reviews = List.from(
                                  restaurant.result.restaurant.customerReview,
                                );

                                reviews.sort(
                                  (a, b) => DateFormat('dd MMMM yyyy', 'id_ID')
                                      .parse(b.date)
                                      .compareTo(
                                        DateFormat('dd MMMM yyyy', 'id_ID')
                                            .parse(a.date),
                                      ),
                                );

                                CustomerReview review = reviews[index];
                                return Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ListTile(
                                    title: Text(review.name),
                                    subtitle: Text(review.review),
                                    trailing: Text(review.date),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (restaurant.state == ResultState.noData) {
            return const Center(
              child: Material(
                child: Text('Tidak ada Data!'),
              ),
            );
          } else if (restaurant.state == ResultState.error) {
            return const Center(
              child: Text('Tidak ada koneksi Internet!'),
            );
          } else {
            return const Center(child: Text(''));
          }
        },
      ),
    );
  }
}
