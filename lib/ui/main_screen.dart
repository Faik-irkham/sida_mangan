import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sida_mangan/provider/app_navigator.dart';
import 'package:sida_mangan/ui/favorite_page.dart';
import 'package:sida_mangan/ui/home_page.dart';
import 'package:sida_mangan/ui/setting_page.dart';
import 'package:sida_mangan/widgets/bottom_navigation.dart'; // Sesuaikan dengan nama file Anda

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppNavigator>(
      builder: (context, appNavigator, _) {
        return Scaffold(
          body: _getPage(appNavigator.currentIndex),
          bottomNavigationBar: BottomNavBar(
            currentIndex: appNavigator.currentIndex,
            onTap: (index) => appNavigator.navigateTo(index),
          ),
        );
      },
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return const HomePage();
      case 1:
        return const FavoritePage();
      case 2:
        return const SettingPage();
      default:
        return const HomePage();
    }
  }
}
