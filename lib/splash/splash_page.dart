import 'dart:async';

import 'package:flutter/material.dart';
import 'package:music_brains/ui/home/bottom_nav/widgets/bottom_index.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ScreenMainPage(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/images/M.png',
                fit: BoxFit.fill,
                width: 270,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                strokeWidth: 4,
                color: Color.fromARGB(255, 232, 15, 0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
