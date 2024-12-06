import 'package:flutter/material.dart';
import 'package:hrv4life_flutter/src/constants/app_colors.dart';
import 'package:hrv4life_flutter/src/constants/app_text_styles.dart';
import 'package:hrv4life_flutter/src/constants/routes_assets.dart';

class ScrollHeightPicker extends StatefulWidget {
  final double initialHeight;
  final ValueChanged<double> onHeightChanged;

  const ScrollHeightPicker({
    super.key,
    required this.initialHeight,
    required this.onHeightChanged,
  });

  @override
  _ScrollHeightPickerState createState() => _ScrollHeightPickerState();
}

class _ScrollHeightPickerState extends State<ScrollHeightPicker> {
  late FixedExtentScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = FixedExtentScrollController(
      initialItem: (widget.initialHeight - 100).round(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListWheelScrollView.useDelegate(
        controller: _scrollController,
        itemExtent: 50,
        perspective: 0.005,
        diameterRatio: 2,
        physics: const FixedExtentScrollPhysics(),
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: 121, // 220 - 100 + 1
          builder: (context, index) {
            final height = 100 + index;
            return Center(
              child: Text(
                '$height cm',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: height == widget.initialHeight
                      ? AppColors.primaryPure
                      : Colors.black,
                ),
              ),
            );
          },
        ),
        onSelectedItemChanged: (index) {
          widget.onHeightChanged(100 + index.toDouble());
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class RegisterQuestion5Page extends StatefulWidget {
  const RegisterQuestion5Page({super.key});

  @override
  State<RegisterQuestion5Page> createState() => _RegisterQuestion5PageState();
}

class _RegisterQuestion5PageState extends State<RegisterQuestion5Page> {
  double _selectedHeight = 160;

  @override
  Widget build(BuildContext context) {
    final sizeOF = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 60, vertical: 10),
              child: SizedBox(
                height: 2,
                child: LinearProgressIndicator(
                  value: .60,
                  minHeight: 10,
                  color: AppColors.secondaryBar,
                  backgroundColor: Colors.black12,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: SizedBox(
                width: sizeOF.width * .8,
                child: Text(
                  'Seu perfil',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    fontFamily: TextStyles.instance.primary,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                textAlign: TextAlign.justify,
                'Esses dados vão ajudar a personalizar as análises de seus indicadores e seu monitoramento de saúde',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: TextStyles.instance.secondary,
                ),
              ),
            ),
            SizedBox(
              height: sizeOF.height * 0.04,
            ),
            SizedBox(
              width: sizeOF.width,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: Text(
                  textAlign: TextAlign.center,
                  'Qual é a sua altura?',
                  style: TextStyle(
                    color: AppColors.primaryPure,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    fontFamily: TextStyles.instance.secondary,
                  ),
                ),
              ),
            ),
            ScrollHeightPicker(
              initialHeight: _selectedHeight,
              onHeightChanged: (height) {
                setState(() {
                  _selectedHeight = height;
                });
              },
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  //      padding: const EdgeInsets.all(8.0),
                  padding: EdgeInsets.only(
                      bottom: sizeOF.height * 0.05,
                      right: 20), // Aumenta o espaço na parte inferior
                  child: SizedBox(
                    height: sizeOF.height * 0.05,
                    width: sizeOF.width * 0.37,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.popAndPushNamed(
                            context, RoutesAssets.registerQuestion4);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        textStyle: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      label: const Text(
                        'Voltar',
                        style: TextStyle(color: Colors.black45),
                      ),
                      icon: const Icon(
                        color: Colors.white,
                        Icons.arrow_circle_left,
                      ),
                    ),
                  ),
                ),
                Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  padding: EdgeInsets.only(
                      bottom: sizeOF.height *
                          0.05), // Aumenta o espaço na parte inferior
                  child: Container(
                    height: sizeOF.height * 0.05,
                    width: sizeOF.width * 0.37,
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 4),
                            blurRadius: 5.0)
                      ],
                      gradient: const LinearGradient(colors: [
                        Color(0xFFFF9000),
                        Color(0xFFFD821C),
                        Color(0xFFF37221)
                      ]),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Aqui você pode adicionar a lógica para salvar a altura selecionada
                        print('Altura selecionada: $_selectedHeight cm');
                        // Navegar para a próxima tela
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        textStyle: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      label: const Text('Avançar'),
                      icon: const Icon(
                        color: Colors.white,
                        Icons.arrow_circle_right,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
