/// Classe para armazenar um ponto de dado de amostra
class SensorValue {
  final DateTime time;
  final double value;

  SensorValue({required this.time, required this.value});

  // Retorna um ponto de dado mapeado em JSON
  Map<String, dynamic> toJSON() =>
      {'time': time.toIso8601String(), 'value': value};

  // Mapeia uma lista de amostras de [dados] para um array formatado em JSON
  static List<Map<String, dynamic>> toJSONArray(List<SensorValue> data) =>
      data.map((e) => e.toJSON()).toList();
}
