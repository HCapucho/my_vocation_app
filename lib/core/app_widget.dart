import 'package:flutter/material.dart';
import 'package:my_vocation_app/modules/splash/splash_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "My Vocation",
      home: SplashPage(),
    );
  }
}
