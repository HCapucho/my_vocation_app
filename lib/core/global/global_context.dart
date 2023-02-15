import 'package:flutter/cupertino.dart';
import 'package:my_vocation_app/core/core.dart';
import 'package:my_vocation_app/modules/login/infra/repositories/login_repository.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class GlobalContext {
  final GlobalKey<NavigatorState> navigatorKey;
  final LoginRepository loginRepository;
  GlobalContext({
    required this.navigatorKey,
    required this.loginRepository,
  });

  Future<void> loginExpire() async {
    final sp = await SharedPreferences.getInstance();
    sp.clear();
    showTopSnackBar(
      Overlay.of(navigatorKey.currentState!.context),
      CustomSnackBar.error(
        message: 'Login expirado',
        backgroundColor: AppColors.lightBlue,
      ),
    );
    navigatorKey.currentState!
        .pushNamedAndRemoveUntil('/auth/login', (route) => false);
  }
}
