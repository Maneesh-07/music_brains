import 'package:flutter/material.dart';
import 'package:music_brains/core/constant/test_style.dart';
import 'package:music_brains/ui/home/widgets/appbar_widget.dart';
import 'package:music_brains/ui/home/widgets/card_widget.dart';
import 'package:music_brains/ui/home/widgets/popular_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  // Future<List<>>

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const AppBar_Widgets(),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Discover Songs",
                  style: ktextHome,
                ),
                Container(
                  width: 80,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.purple[600],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 14, top: 5),
                    child: Text(
                      "Explore",
                      style: kCardtext,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
             CardWidget(),
            const Popular_widget()
          ],
        ),
      ),
    );
  }
}
