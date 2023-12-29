import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sida_mangan/common/constant.dart';
import 'package:sida_mangan/common/style.dart';
import 'package:sida_mangan/provider/search_restaurant_provider.dart';
import 'package:sida_mangan/ui/detail_restaurant_page.dart';
import 'package:sida_mangan/widgets/ratings_bar.dart';

class SearchRestaurantPage extends StatefulWidget {
  const SearchRestaurantPage({super.key});

  @override
  State<SearchRestaurantPage> createState() => _SearchRestaurantPageState();
}

class _SearchRestaurantPageState extends State<SearchRestaurantPage> {
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Search Restaurants'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: const BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: _textController,
                  onSubmitted: (value) {
                    Provider.of<SearchRestaurantsProvider>(context,
                            listen: false)
                        .searchRestaurant(_textController.text);
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search restaurant',
                    suffixIcon: GestureDetector(
                      onTap: () {
                        Provider.of<SearchRestaurantsProvider>(context,
                                listen: false)
                            .searchRestaurant(_textController.text);
                      },
                      child: const Icon(
                        Icons.search,
                        size: 27,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  context.watch<SearchRestaurantsProvider>().isLoading == true
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : context
                                  .watch<SearchRestaurantsProvider>()
                                  .result
                                  .founded >
                              0
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.8,
                              child: ListView.builder(
                                itemCount: context
                                    .watch<SearchRestaurantsProvider>()
                                    .result
                                    .founded,
                                itemBuilder: (context, index) {
                                  var restaurant = context
                                      .watch<SearchRestaurantsProvider>()
                                      .result
                                      .restaurants[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetailRestaurant(
                                            id: restaurant.id,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 15,
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 10.0,
                                              offset: Offset(0, 5.0),
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          children: [
                                            Hero(
                                              tag: restaurant.id,
                                              child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey,
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15),
                                                    bottomLeft:
                                                        Radius.circular(15),
                                                  ),
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        imageUrl +
                                                            restaurant
                                                                .pictureId),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  restaurant.name,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                MyRatingBar(
                                                    nilaiRating:
                                                        restaurant.rating),
                                                Text(
                                                  restaurant.city,
                                                  style: myTextTheme.bodySmall,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : context
                                      .watch<SearchRestaurantsProvider>()
                                      .result
                                      .founded ==
                                  0
                              ? Center(
                                  child: Text(context
                                      .watch<SearchRestaurantsProvider>()
                                      .message),
                                )
                              : const SizedBox()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
