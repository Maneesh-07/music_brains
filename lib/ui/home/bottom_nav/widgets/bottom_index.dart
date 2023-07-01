import 'package:flutter/material.dart';
import 'package:music_brains/core/color/colors.dart';
import 'package:music_brains/ui/home/bottom_nav/bottom_nav.dart';
import 'package:music_brains/ui/home/homepage.dart';
import 'package:music_brains/ui/search/search_page.dart';

class ScreenMainPage extends StatelessWidget {
  ScreenMainPage({
    super.key,
  });

  final _pages = [
    const HomeScreen(),
    const SearchScreen()
   
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor,
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: indexChangeNotifier,
          builder: (context, int index, _) {
            return _pages[index];
          },
        ),
      ),
      bottomNavigationBar: const BottomNavigationScreen(),
    );
  }
}
