/*import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hrv4life_flutter/src/modules/heart_bpm/domain/sensor_value.dart';
import 'package:iirjdart/butterworth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

/// Obtains heart beats per minute using camera sensor
// ignore: must_be_immutable

class HeartBPMDialog extends StatefulWidget {
  final Widget?
      centerLoadingWidget; // Widget de carregamento para exibir durante a inicialização
  final double? cameraWidgetHeight; // Altura do widget da câmera
  final double? cameraWidgetWidth; // Largura do widget da câmera
  bool? showTextValues = false; // Indica se deve mostrar valores em texto
  final double? borderRadius; // Raio de borda para o widget da câmera
  final void Function(int) onBPM; // Callback para notificar atualizações de BPM
  final void Function(SensorValue)?
      onRawData; // Callback para notificar atualizações de dados brutos
  final int sampleDelay; // Taxa de amostragem da câmera em milissegundos
  final BuildContext context; // Contexto pai
  final Widget? child; // Widget filho adicional para exibir

  HeartBPMDialog({
    super.key,
    this.centerLoadingWidget,
    this.cameraWidgetHeight,
    this.cameraWidgetWidth,
    this.showTextValues,
    this.borderRadius,
    required this.onBPM,
    this.onRawData,
    this.sampleDelay = 1000 ~/ 30,
    required this.context,
    this.child,
  });

// Torne o método isWithinRange público e estático
  static bool isWithinRange(int value, int reference, double percentRange) {
    double lowerBound = reference * (1 - percentRange);
    double upperBound = reference * (1 + percentRange);
    return value >= lowerBound && value <= upperBound;
  }

  @override
  _HeartBPPView createState() => _HeartBPPView();
}

class _HeartBPPView extends State<HeartBPMDialog> {
  HeartBPMController heartBPMController = GetIt.instance<HeartBPMController>();
  CameraController? _controller;
  bool _processing = false;
  int currentValue = 0;
  bool isCameraInitialized = false;
  //StreamSubscription<CameraImage>? _imageStreamSubscription;

  // Declaração da variável de stream

  @override
  void initState() {
    super.initState();
    _initController();
  }

  @override
  void dispose() {
    _deinitController();
    super.dispose();
  }

  // Cancelamento do stream
  void _deinitController() async {
    isCameraInitialized = false;
    if (_controller == null) return;

    // Pare o stream de imagens
    await _controller!.stopImageStream();

    // Dispose do controlador
    await _controller!.dispose();
    _controller = null;
  }

  Future<void> _initController() async {
    if (_controller != null) return;
    try {
      List<CameraDescription> _cameras = await availableCameras();

      if (_cameras.isNotEmpty) {
        _controller ??= CameraController(
          _cameras.first,
          ResolutionPreset.low,
          enableAudio: false,
          imageFormatGroup: ImageFormatGroup.yuv420,
        );

        await _controller!.initialize();

        if (_controller != null && _controller!.value.isInitialized) {
          await Future.delayed(const Duration(milliseconds: 500));
          await _controller!.setFlashMode(FlashMode.torch);

          // Inicie o stream de imagens
          await _startImageStream();
        }

        setState(() {
          isCameraInitialized = true;
        });
      } else {
        throw Exception("No cameras available");
      }
    } catch (e) {
      print("Error initializing camera: $e");
    }
  }

  Future<void> _startImageStream() async {
    await _controller!.startImageStream((image) async {
      _processing = true;
      await _scanImage(image);
    });
  }

  ///Cria a lista para os valores de cada frame
  final List<SensorValue> measureWindow = [];

  ///Calcula a intensidade média de bits de cada frame
  Future<void> _scanImage(CameraImage image) async {
    _processing = true;
    double avgIntensity =
        image.planes.first.bytes.reduce((value, element) => value + element) /
            image.planes.first.bytes.length;
    print('Intensidade média calculada: $avgIntensity');
    measureWindow.add(SensorValue(time: DateTime.now(), value: avgIntensity));
    if (measureWindow.length > 100) {
      await Future.microtask(() => preProcessamento(avgIntensity));
      measureWindow.clear();
    }
    if (widget.onRawData != null) {
      widget.onRawData!(SensorValue(time: DateTime.now(), value: avgIntensity));
    }

    Timer(Duration(milliseconds: widget.sampleDelay), () {
      if (mounted) {
        setState(() {
          _processing = false;
        });
      }
    });
  }

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
      setState(() {
        currentValue = newValue;
      });
      widget.onBPM(currentValue);
      heartBPMController.updateCurrentValue(currentValue);
      print('currentValue atualizado: $currentValue');

      List<int> rrIntervals = [];
      detectPeaks(measureWindow, rrIntervals, currentValue, heartBPMController);
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
              isValidInterval = _isWithinRange(rrInterval, rrIntervals[0], 0.3);
            } else if (rrIntervals.length >= 10) {
              int avgPreviousIntervals = (rrIntervals[rrIntervals.length - 1] +
                      rrIntervals[rrIntervals.length - 2]) ~/
                  2;
              isValidInterval =
                  _isWithinRange(rrInterval, avgPreviousIntervals, 0.3);
            }
          }

          // Adiciona o intervalo RR à lista se for válido
          if (isValidInterval) {
            rrIntervals.add(rrInterval);
            Provider.of<HeartBPMModel>(context, listen: false)
                .addRRInterval(rrInterval);
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

  /// Verifica se um valor está dentro de uma faixa percentual de outro valor.
  /// [value] é o valor a ser verificado.
  /// [reference] é o valor de referência.
  /// [percentRange] é a faixa percentual permitida (por exemplo, 0.3 para 30%).
  /// Retorna true se o valor estiver dentro da faixa, false caso contrário.
  bool _isWithinRange(int value, int reference, double percentRange) {
    double lowerBound = reference * (1 - percentRange);
    double upperBound = reference * (1 + percentRange);
    return value >= lowerBound && value <= upperBound;
  }

  ///widget de visualizacao
  @override
  Widget build(BuildContext context) {
    return Container(
      child: isCameraInitialized
          ? Column(
              children: [
                Container(
                  constraints: BoxConstraints.tightFor(
                    width: widget.cameraWidgetWidth ?? 100,
                    height: widget.cameraWidgetHeight ?? 130,
                  ),
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(widget.borderRadius ?? 10),
                    child: _controller!.buildPreview(),
                  ),
                ),
                if (widget.showTextValues == true)
                  ValueListenableBuilder<int>(
                    valueListenable:
                        Provider.of<HeartBPMModel>(context, listen: false)
                            .currentValueNotifier,
                    builder: (context, value, child) {
                      return Text('$value BPM');
                    },
                  )
                else
                  const SizedBox(),
                widget.child ?? const SizedBox(),
              ],
            )
          : Center(
              child: widget.centerLoadingWidget ??
                  const CircularProgressIndicator(),
            ),
    );
  }
}
*/