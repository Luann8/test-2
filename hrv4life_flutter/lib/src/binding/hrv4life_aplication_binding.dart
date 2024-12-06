import 'package:flutter_getit/flutter_getit.dart';
import 'package:hrv4life_core/hrv4life_core.dart';
import 'package:hrv4life_flutter/src/core/env.dart';

class Hrv4lifeAplicationBinding extends ApplicationBindings {
  @override
  List<Bind<Object>> bindings() => [
        Bind.lazySingleton<RestClient>(
          (i) => RestClient(
            Env.backEndBaseUrl,
          ),
        ),
      ];
}
