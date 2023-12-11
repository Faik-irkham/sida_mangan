import 'package:flutter/material.dart';
import 'package:sida_mangan/common/style.dart';
import 'package:sida_mangan/data/model/restaurant.dart';
import 'package:sida_mangan/widgets/text_deskripsi.dart';
import 'package:sida_mangan/widgets/ratings_bar.dart';

class DetailRestaurant extends StatefulWidget {
  static const routeName = '/detail_restaurant';

  final Restaurant restaurant;

  const DetailRestaurant({super.key, required this.restaurant});

  @override
  State<DetailRestaurant> createState() => _DetailRestaurantState();
}

class _DetailRestaurantState extends State<DetailRestaurant>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Hero(
            tag: widget.restaurant.id,
            child: Container(
              padding: const EdgeInsets.only(left: 15, bottom: 15),
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    widget.restaurant.pictureId,
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.restaurant.name,
                      style: myTextTheme.bodyLarge,
                    ),
                    const SizedBox(height: 10),
                    MyRatingBar(
                      nilaiRating: widget.restaurant.rating,
                    ),
                  ],
                ),
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
                    widget.restaurant.city,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ReadMoreText(
              text: widget.restaurant.description,
              maxLength: 120,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TabBar(
              controller: tabController,
              labelColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab,
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
              ],
            ),
          ),
          SizedBox(
            height: 500,
            width: double.maxFinite,
            child: TabBarView(
              controller: tabController,
              children: [
                // Foods GridView
                GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: widget.restaurant.menus.foods.length,
                  itemBuilder: (context, index) {
                    Food food = widget.restaurant.menus.foods[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            child: Image.asset(
                              'assets/images/food.jpg',
                              height: 85,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          ListTile(
                            title: Text(food.name),
                          )
                        ],
                      ),
                    );
                  },
                ),
                // Drinks GridView
                GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2 / 2.1,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: widget.restaurant.menus.drinks.length,
                  itemBuilder: (context, index) {
                    Drink drink = widget.restaurant.menus.drinks[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            child: Image.asset(
                              'assets/images/coffee.jpg',
                              height: 85,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          ListTile(
                            title: Text(drink.name),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
