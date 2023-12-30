import 'package:flutter/material.dart';
import 'package:sida_mangan/widgets/card_detail_restaurant.dart';

class DetailRestaurant extends StatefulWidget {
  final String id;

  const DetailRestaurant({
    required this.id,
    super.key,
  });

  @override
  State<DetailRestaurant> createState() => _DetailRestaurantState();
}

class _DetailRestaurantState extends State<DetailRestaurant>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CardDetailRestaurant(widget: widget, tabController: tabController),
    );
  }
}
