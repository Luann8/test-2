

import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:hrv4life_flutter/src/modules/login/login_controller.dart';
import 'package:hrv4life_flutter/src/modules/login/onboarding_login_page.dart';
import 'package:hrv4life_flutter/src/services/user_login_service.dart';
import 'package:hrv4life_flutter/src/services/user_login_service_impl.dart';

class LoginRouter  extends FlutterGetItModulePageRouter {
  const LoginRouter({super.key});
  @override
  List<Bind<Object>> get bindings => [
    Bind.lazySingleton<UserLoginServices>((i) => UserLoginServicesImpl(userRepository: i())),
    Bind.lazySingleton((i) => LoginController(loginService: i())),
  ];
  
  @override
  WidgetBuilder get view => (_) => const OnboardingLoginPage();
}