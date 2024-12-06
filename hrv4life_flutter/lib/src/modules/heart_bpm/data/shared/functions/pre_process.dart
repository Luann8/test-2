import 'package:get_it/get_it.dart';
import 'package:hrv4life_flutter/src/modules/heart_bpm/data/shared/functions/main_process.dart';
import 'package:hrv4life_flutter/src/modules/heart_bpm/domain/sensor_value.dart';
import 'package:hrv4life_flutter/src/modules/heart_bpm/presentation/controllers/heart_bpm_controller.dart';
import 'package:iirjdart/butterworth.dart';

class PreProcess {
  MainProcess mainProcess = MainProcess();
  HeartBPMController heartBPMController = GetIt.instance<HeartBPMController>();
  int currentValue = 0;

  /// ///Cria a lista para os valores de cada frame
  final List<SensorValue> measureWindow = [];

  ////PRE-PROCESSAMENTO////

  Future<void> preProcessamento(double value) async {
    // 1. Extraia valores e tempos da janela de medição
    List<double> values = measureWindow.map((e) => e.value.toDouble()).toList();
    List<double> times = measureWindow
        .map((e) => e.time.millisecondsSinceEpoch.toDouble())
        .toList();

    // 2. Aplique interpolação cúbica spline
    List<double> newTimes = [];
    double startTime = times.first;
    double endTime = times.last;
    int numPoints = 100; // Número de pontos para interpolação

    for (int i = 0; i <= numPoints; i++) {
      double t = startTime + i * (endTime - startTime) / numPoints;
      newTimes.add(t);
    }

    List<double> interpolatedValues = splineInterp(times, values, newTimes, 1);

    // Atualize a janela de medição com valores interpolados
    for (int i = 0; i < measureWindow.length; i++) {
      measureWindow[i] = SensorValue(
          time: measureWindow[i].time, value: interpolatedValues[i]);
    }

    // 3. Normalização (Min-Max)
    double findMin(List<double> values) =>
        values.reduce((a, b) => a < b ? a : b);
    double findMax(List<double> values) =>
        values.reduce((a, b) => a > b ? a : b);

    // Extraia os valores do measureWindow
    List<double> windowValues =
        measureWindow.map((e) => e.value.toDouble()).toList();

    // Calcule os valores mínimo e máximo
    double minValue = findMin(windowValues);
    double maxValue = findMax(windowValues);

    if (maxValue == minValue) {
      // Trate o caso em que todos os valores são iguais
      for (int i = 0; i < measureWindow.length; i++) {
        measureWindow[i] = SensorValue(
            time: measureWindow[i].time, value: 0.001); // Valore normalizado
      }
    } else {
      for (int i = 0; i < measureWindow.length; i++) {
        double normalizedValue =
            (measureWindow[i].value - minValue) / (maxValue - minValue);
        measureWindow[i] = SensorValue(
            time: measureWindow[i].time,
            value: normalizedValue); // Valor normalizado
      }
    }

    // 4. Aplique filtros passa-baixa e passa-alta
    double cameraFPS = 30.0; // 30.0 FPS por padrao

    /*   if (_controller != null && _controller!.value.isInitialized) {
      cameraFPS = 1000.0 / _controller!.value.exposureMode.index;
      // Limitamos o FPS entre 10 e 120 para evitar valores extremos
      cameraFPS = cameraFPS.clamp(10.0, 120.0);
    } */

    print("Estimated Camera FPS: $cameraFPS");

    Butterworth butterworthLowpass = Butterworth();
    butterworthLowpass.lowPass(2, cameraFPS, 4);

    Butterworth butterworthHighpass = Butterworth();
    butterworthHighpass.highPass(2, cameraFPS, 0.4);

    for (int i = 0; i < measureWindow.length; i++) {
      double filteredSignalLowpass =
          butterworthLowpass.filter(measureWindow[i].value.toDouble());
      double filteredSignal = butterworthHighpass.filter(filteredSignalLowpass);
      measureWindow[i] =
          SensorValue(time: measureWindow[i].time, value: filteredSignal);
    }

    // Atualize o valor atual de BPM
    if (interpolatedValues.isNotEmpty) {
      int newValue = interpolatedValues.last.round();
      print('Novo valor de BPM calculado: $newValue');
//      setState(() {
      currentValue = newValue;
      //     });
      //    widget.onBPM(currentValue);
      heartBPMController.updateCurrentValue(currentValue);
      print('currentValue atualizado: $currentValue');

      List<int> rrIntervals = [];
      mainProcess.detectPeaks(
          measureWindow, rrIntervals, currentValue, heartBPMController);
    } else {
      print('interpolatedValues está vazio');
    }
  }

  /// 5. Função de interpolação cúbica spline (aplicada no item 2)
  List<double> splineInterp(
      List<double> x, List<double> y, List<double> xInterp, int boundaryType) {
    int n = x.length;
    int nInterp = xInterp.length;

    if (n < 2 || nInterp < 1) {
      throw ArgumentError(
          "Erro SplineInterp! Argumentos possuem dimensões erradas.");
    }

    List<double> yInterp = List.filled(nInterp, 0.0);

    List<double> a = List.filled(n, 0.0);
    List<double> b = List.filled(n, 0.0);
    List<double> d = List.filled(n, 0.0);
    List<double> h = List.filled(n, 0.0);

    // Calcule os intervalos h e os coeficientes b
    for (int i = 0; i < n - 1; i++) {
      h[i] = x[i + 1] - x[i];
      b[i] = (y[i + 1] - y[i]) / h[i];
    }

    // Calcule os coeficientes a e d
    List<double> alpha = List.filled(n, 0.0);
    List<double> l = List.filled(n, 1.0);
    List<double> mu = List.filled(n, 0.0);
    List<double> z = List.filled(n, 0.0);

    for (int i = 1; i < n - 1; i++) {
      alpha[i] = 3 * (b[i] - b[i - 1]);
    }

    for (int i = 1; i < n - 1; i++) {
      l[i] = 2 * (x[i + 1] - x[i - 1]) - h[i - 1] * mu[i - 1];
      mu[i] = h[i] / l[i];
      z[i] = (alpha[i] - h[i - 1] * z[i - 1]) / l[i];
    }

    List<double> c = List.filled(n, 0.0);
    for (int j = n - 2; j >= 0; j--) {
      c[j] = z[j] - mu[j] * c[j + 1];
      b[j] = (y[j + 1] - y[j]) / h[j] - h[j] * (c[j + 1] + 2 * c[j]) / 3;
      d[j] = (c[j + 1] - c[j]) / (3 * h[j]);
      a[j] = y[j];
    }

    // Faz a interpolação
    for (int i = 0; i < nInterp; i++) {
      int j = n - 2;
      for (int k = 0; k < n - 1; k++) {
        if (xInterp[i] < x[k + 1]) {
          j = k;
          break;
        }
      }
      double dx = xInterp[i] - x[j];
      yInterp[i] = a[j] + b[j] * dx + c[j] * dx * dx + d[j] * dx * dx * dx;
    }

    return yInterp;
  }

  /// Encontre o valor mínimo em uma lista de doubles
  double findMin(List<double> values) => values.reduce((a, b) => a < b ? a : b);

  /// Encontre o valor máximo em uma lista de doubles
  double findMax(List<double> values) => values.reduce((a, b) => a > b ? a : b);
}
