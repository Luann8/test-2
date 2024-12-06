import 'package:flutter/material.dart';

class HeartBPMController extends ChangeNotifier {
  final ValueNotifier<int> currentValue = ValueNotifier<int>(0);
  ValueNotifier<int> get currentValueNotifier => currentValue;

  List<List<int>> rrMatrix = [];

  void updateCurrentValue(int newValue) {
    currentValue.value = newValue;
    print('Novo valor de currentValue: ${currentValue.value}');
    notifyListeners();
  }

  void addRRInterval(int interval) {
    if (rrMatrix.isEmpty) {
      rrMatrix.add([]);
    }
    rrMatrix.last.add(interval);
    notifyListeners();
  }
}
