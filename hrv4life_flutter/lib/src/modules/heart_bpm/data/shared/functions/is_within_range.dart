// Torne o método isWithinRange público e estático
bool isWithinRange(int value, int reference, double percentRange) {
  double lowerBound = reference * (1 - percentRange);
  double upperBound = reference * (1 + percentRange);
  return value >= lowerBound && value <= upperBound;
}


 /* /// Verifica se um valor está dentro de uma faixa percentual de outro valor.
  /// [value] é o valor a ser verificado.
  /// [reference] é o valor de referência.
  /// [percentRange] é a faixa percentual permitida (por exemplo, 0.3 para 30%).
  /// Retorna true se o valor estiver dentro da faixa, false caso contrário.
  bool _isWithinRange(int value, int reference, double percentRange) {
    double lowerBound = reference * (1 - percentRange);
    double upperBound = reference * (1 + percentRange);
    return value >= lowerBound && value <= upperBound;
  } */