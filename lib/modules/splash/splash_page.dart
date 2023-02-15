import 'package:flutter/material.dart';
import 'package:my_vocation_app/core/core.dart';
import 'package:my_vocation_app/modules/home/home_page.dart';
import 'package:my_vocation_app/modules/login/domain/models/usuario.dart';
import 'package:my_vocation_app/modules/login/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  _checkLogin() async {
    await Future.delayed(Duration(seconds: 2));
    final sp = await SharedPreferences.getInstance();
    final accessToken = sp.getString('accessToken');
    final username = sp.getString('username');

    if (context.mounted) {
      if (accessToken != null) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomePage(username: username!),
        ));
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginPage()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppGradients.linear,
        ),
        child: Center(
          child: Text(
            "My Vocation",
            style: AppTextStyles.heading40.copyWith(color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
