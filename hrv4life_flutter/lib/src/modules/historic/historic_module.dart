

import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:hrv4life_flutter/src/constants/routes_assets.dart';
import 'package:hrv4life_flutter/src/modules/historic/historic_page.dart';


class HistoricModule extends FlutterGetItModule{
  @override
  String get moduleRouteName => RoutesAssets.historicPage;
  @override

  Map<String, WidgetBuilder> get pages => {
    RoutesAssets.splash :(context) => const HistoricPage(),
    };
  
}