
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:hrv4life_flutter/src/constants/routes_assets.dart';
import 'package:hrv4life_flutter/src/modules/menu/menu_page.dart';

class MenuModule extends FlutterGetItModule{
  @override
  String get moduleRouteName => RoutesAssets.menuPage;

  @override
  Map<String, WidgetBuilder> get pages => {
    RoutesAssets.splash: (context) => const MenuPage(),
  };
  
}