import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:hrv4life_flutter/src/constants/routes_assets.dart';
import 'package:hrv4life_flutter/src/modules/login/login_router.dart';
import 'package:hrv4life_flutter/src/repositories/user_repository.dart';
import 'package:hrv4life_flutter/src/repositories/user_repository_impl.dart';

class AuthModule extends FlutterGetItModule {
  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton<UserRepository>(
            (i) => UserRepositoryImpl(restClient: i()))
      ];

  @override
  String get moduleRouteName => RoutesAssets.auth;

  @override
  Map<String, WidgetBuilder> get pages => {
        RoutesAssets.login: (_) => const LoginRouter(),
      };
}
