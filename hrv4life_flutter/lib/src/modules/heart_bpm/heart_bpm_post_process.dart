/* 
////POS-PROCESSAMENTO ESSA PARTE TEM QUE SER CHAMADA QUANDO FINALIZAR A MEDIDA ANTES DE SALVAR OS DADOS////
void posProcessamento(List<int> rrIntervals) {
  // 1. Suavização ZigZag
  if (rrIntervals.length >= 4) {
    int previousValue = rrIntervals[0]; // Armazena o valor anterior
    int previousTrend =
        0; // 1 para crescente, -1 para decrescente, 0 para indefinido

    for (int i = 1; i < rrIntervals.length; i++) {
      int currentValue = rrIntervals[i];
      int currentTrend;

      if (currentValue > previousValue) {
        currentTrend = 1; // Tendência crescente
      } else if (currentValue < previousValue) {
        currentTrend = -1; // Tendência decrescente
      } else {
        currentTrend = previousTrend; // Mantém a tendência anterior
      }

      // Verifica se houve mudança de tendência (pico ou vale)
      if (previousTrend != 0 && currentTrend != previousTrend) {
        // Suaviza o valor atual como a média do anterior e do atual
        rrIntervals[i] = ((previousValue + currentValue) / 2).toInt();
      }

      previousValue = currentValue;
      previousTrend = currentTrend;
    }
  }

  // 2. Média Móvel Ponderada
  for (int i = 0; i < rrIntervals.length - 3; i++) {
    rrIntervals[i] = (0.68 * rrIntervals[i].toDouble() +
            0.32 *
                (0.35 * rrIntervals[i + 2].toDouble() +
                    0.49 * rrIntervals[i + 1].toDouble() +
                    0.16 * rrIntervals[i].toDouble()))
        .toInt();
  }

  // Salvando os intervalos RR em uma matriz
  List<List<int>> rrMatrix = [];

  // Adicionando os intervalos RR suavizados na matriz
  rrMatrix.add(rrIntervals);
} */