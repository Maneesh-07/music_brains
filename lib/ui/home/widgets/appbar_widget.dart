import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:music_brains/core/constant/test_style.dart';

class AppBar_Widgets extends StatelessWidget implements PreferredSizeWidget {
  const AppBar_Widgets({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      title: Text(
        "Good Afternoon",
        style: ktextHome,
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 15, left: 10),
          child: Row(
            children: [
              Icon(
                Ionicons.headset,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              CircleAvatar(
                radius: 15,
                backgroundImage: AssetImage("assets/images/image01.jpg"),
              )
            ],
          ),
        )
      ],
    );
  }
}
