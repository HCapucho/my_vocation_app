import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:my_vocation_app/core/core.dart';
import 'package:my_vocation_app/core/global/global_context.dart';
import 'package:my_vocation_app/core/rest/custom_dio.dart';
import 'package:my_vocation_app/modules/home/home_module.dart';
import 'package:my_vocation_app/modules/login/domain/bloc/login_bloc.dart';
import 'package:my_vocation_app/modules/login/infra/repositories/login_repository.dart';
import 'package:my_vocation_app/modules/login/login_module.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  runApp(MyVocationApp());
}

class MyVocationApp extends StatelessWidget {
  final navigatorKey = GlobalKey<NavigatorState>();
  MyVocationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<CustomDio>(create: (context) => CustomDio()),
        Provider<GlobalContext>(
          create: (context) => GlobalContext(
            navigatorKey: navigatorKey,
            loginRepository: context.read(),
          ),
        ),
        ...loginDependencies,
        ...homeDependencies,
      ],
      child: AppWidget(),
    );
  }
}
