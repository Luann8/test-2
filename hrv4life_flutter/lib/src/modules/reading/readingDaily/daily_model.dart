import 'package:flutter/foundation.dart';
import 'package:hrv4life_flutter/src/modules/heart_bpm/domain/sensor_value.dart';

class DailyModel extends ChangeNotifier {
  final List<SensorValue> _bpmValues = [];
  final List<SensorValue> _currentValue = [];
  // Método para adicionar um valor BPM à lista
  void addBpmValue(SensorValue value) {
    _bpmValues.add(value);
    notifyListeners(); // Notificar os ouvintes sobre a alteração
  }

  // Método para obter o último valor da lista de valores BPM
  String getLastBpmValue() {
    if (_currentValue.isNotEmpty) {
      final lastValue = _currentValue.last;
      return '${lastValue.value.toStringAsFixed(0)} Bpm'; // Corrigido aqui
    } else {
      return '0 Bpm';
    }
  }
  // Outros métodos e propriedades da classe...
}
