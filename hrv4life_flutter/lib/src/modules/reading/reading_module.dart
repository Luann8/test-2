import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:hrv4life_flutter/src/constants/routes_assets.dart';
import 'package:hrv4life_flutter/src/modules/reading/readingDaily/daily_evaluation_page.dart';
import 'package:hrv4life_flutter/src/modules/reading/readingmoring/reading_morning_page.dart';
import 'package:hrv4life_flutter/src/modules/reading/reading_page.dart';
import 'package:hrv4life_flutter/src/modules/reading/pacer/pacer_page.dart';

class ReadingModule extends FlutterGetItModule {
  @override
  String get moduleRouteName => RoutesAssets.readingHome;
  @override
  Map<String, WidgetBuilder> get pages => {
        RoutesAssets.splash: (context) => const ReadingPage(),
        '/morning': (context) => const ReadingMorningPage(),
        '/daily': (context) => const DailyEvaluationPage(),
        '/pacer': (context) => const PacerPage(),
      };
}
