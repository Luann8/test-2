import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:hrv4life_flutter/src/constants/routes_assets.dart';
import 'package:hrv4life_flutter/src/modules/register/register_name_page.dart';
import 'package:hrv4life_flutter/src/modules/register/register_question2_page.dart';
import 'package:hrv4life_flutter/src/modules/register/register_question3_page.dart';
import 'package:hrv4life_flutter/src/modules/register/register_question4_page.dart';
import 'package:hrv4life_flutter/src/modules/register/register_question5_page.dart';
import 'package:hrv4life_flutter/src/modules/register/register_question_page.dart';


class RegisterModule extends FlutterGetItModule{
  @override
  String get moduleRouteName => RoutesAssets.registerHome;
  @override

  Map<String, WidgetBuilder> get pages => {
    RoutesAssets.splash :(context) => const RegisterNamePage(),
    '/question' :(context) => const RegisterQuestionPage(),
    '/question2' :(context) => const RegisterQuestion2Page(),
    '/question3' :(context) => const RegisterQuestion3Page(),
    '/question4' :(context) => const RegisterQuestion4Page(),
    '/question5' :(context) => const RegisterQuestion5Page(),
    
    };
  
}