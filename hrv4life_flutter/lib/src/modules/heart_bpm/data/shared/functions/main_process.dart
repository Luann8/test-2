import 'package:hrv4life_flutter/src/modules/heart_bpm/data/shared/functions/is_within_range.dart';
import 'package:hrv4life_flutter/src/modules/heart_bpm/domain/sensor_value.dart';
import 'package:hrv4life_flutter/src/modules/heart_bpm/presentation/controllers/heart_bpm_controller.dart';

class MainProcess {
  ////PROCESSAMENTO PRINCIPAL////
// 1. Calcula a média dos valores de uma lista
  double calculateAverage(List<double> values) {
    if (values.isEmpty) return 0;
    return values.reduce((a, b) => a + b) / values.length;
  }

  //2. Detecção de picos
  void detectPeaks(List<SensorValue> measureWindow, List<int> rrIntervals,
      int lastBPM, HeartBPMController heartBPMController,
      {double minAmplitudePercentage = 0.9, int minDistance = 428}) {
    // Cálculo das derivadas
    List<double> firstDerivative = [];
    List<double> secondDerivative = [];
    for (int i = 1; i < measureWindow.length - 1; i++) {
      // Aproximação da primeira derivada
      firstDerivative
          .add((measureWindow[i + 1].value - measureWindow[i - 1].value) / 2);
      // Aproximação da segunda derivada
      secondDerivative.add(measureWindow[i + 1].value -
          2 * measureWindow[i].value +
          measureWindow[i - 1].value);
    }

    // Calcular média dos valores absolutos da segunda derivada
    double avgSecondDerivative =
        calculateAverage(secondDerivative.map((e) => e.abs()).toList());

    // Definir limiar adaptativo como uma porcentagem da média
    double minAmplitude = minAmplitudePercentage * avgSecondDerivative;

    // Detecção de picos
    int previousTimestamp = 0;
    for (int i = 1; i < secondDerivative.length - 1; i++) {
      if (secondDerivative[i - 1] > 0 && secondDerivative[i] < 0) {
        bool isPeak = true;

        if (secondDerivative[i].abs() < minAmplitude) {
          isPeak = false;
        }

        if (previousTimestamp != 0 &&
            measureWindow[i].time.millisecondsSinceEpoch - previousTimestamp <
                minDistance) {
          isPeak = false;
        }

        int maxIndex = i;
        for (int j = i - 1; j >= 0 && j >= i - 200; j--) {
          if (firstDerivative[j] > firstDerivative[maxIndex]) {
            maxIndex = j;
          } else {
            break;
          }
        }

        if (isPeak && maxIndex != i) {
          int currentTimestamp =
              measureWindow[maxIndex].time.millisecondsSinceEpoch;
          int rrInterval = currentTimestamp - previousTimestamp;
          print(
              "Pico detectado em $currentTimestamp, intervalo RR: $rrInterval");

          ///VALIDAÇÃO DE INTERVALOS
          bool isValidInterval = rrInterval >= 428 && rrInterval <= 1500;
          if (isValidInterval && rrIntervals.isNotEmpty) {
            if (rrIntervals.length == 1) {
              isValidInterval = isWithinRange(rrInterval, rrIntervals[0], 0.3);
            } else if (rrIntervals.length >= 10) {
              int avgPreviousIntervals = (rrIntervals[rrIntervals.length - 1] +
                      rrIntervals[rrIntervals.length - 2]) ~/
                  2;
              isValidInterval =
                  isWithinRange(rrInterval, avgPreviousIntervals, 0.3);
            }
          }

          // Adiciona o intervalo RR à lista se for válido
          if (isValidInterval) {
            rrIntervals.add(rrInterval);
            heartBPMController.addRRInterval(rrInterval);
            //           Provider.of<HeartBPMController>(context, listen: false)
            //               .addRRInterval(rrInterval);
          }

          previousTimestamp = currentTimestamp;
        }
      }
    }

    if (rrIntervals.isNotEmpty) {
      int currentBPM = (60000 / rrIntervals.last).round();
      print('BPM calculado: $currentBPM');
      heartBPMController.updateCurrentValue(currentBPM);
    } else {
      print('Nenhum intervalo RR detectado');
    }
  }
}
