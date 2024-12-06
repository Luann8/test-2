import 'dart:async';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:hrv4life_flutter/src/constants/app_assets.dart';
import 'package:hrv4life_flutter/src/constants/app_colors.dart';
import 'package:hrv4life_flutter/src/constants/app_text_styles.dart';
import 'package:hrv4life_flutter/src/constants/routes_assets.dart';
import 'package:lottie/lottie.dart';

class PacerPage extends StatefulWidget {
  const PacerPage({super.key});

  @override
  State<PacerPage> createState() => _PacerPageState();
}

class _PacerPageState extends State<PacerPage> with TickerProviderStateMixin {
  late final AnimationController _controller;
  String displayText = "Inspire";
  Color displayColor = AppColors.primary;

  final List<String> duracaoItems = [
    '1 minuto',
    '2 minutos',
    '3 minutos',
    '4 minutos',
  ];
  final List<String> posicaoItems = [
    'Sentado',
    'Deitado',
  ];
  String? selectedDuracao;
  String? selectedPosicao;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.duration = const Duration(seconds: 12);
    _controller.repeat();

    Timer.periodic(const Duration(seconds: 6), (timer) {
      setState(() {
        if (displayText == 'Inspire') {
          displayText = 'Expire';
          displayColor = AppColors.secondaryPure;
        } else {
          displayText = 'Inspire';
          displayColor = AppColors.primary;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final sizeOF = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.topCenter,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  'Instruções',
                  style: TextStyle(
                    color: AppColors.black,
                    fontFamily: TextStyles.instance.secondary,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Text(
                  'Respiração Guiada',
                  style: TextStyle(
                    color: Colors.black54,
                    fontFamily: TextStyles.instance.secondary,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Text(
                  displayText,
                  style: TextStyle(
                    color: displayColor,
                    fontFamily: TextStyles.instance.secondary,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Stack(
                  children: [
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: Transform.scale(
                        scale: 1.5,
                        child: Lottie.asset(
                          AppAssets.pacerFace,
                          controller: _controller,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 50,
                      left: 50,
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: Transform.scale(
                          scale: 2.5,
                          child: Lottie.asset(
                            AppAssets.pulseCircle,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: Text(
                  'Puxe o ar pelo nariz enquanto o círculo abre, e solte o ar pela boca enquanto o círculo fecha',
                  style: TextStyle(
                    color: Colors.black54,
                    fontFamily: TextStyles.instance.secondary,
                    fontSize: 14,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  'Duração',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: TextStyles.instance.secondary,
                    fontSize: 16,
                  ),
                ),
              ),
              Center(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: Row(
                      children: [
                        const Icon(
                          Icons.list,
                          size: 16,
                          color: Colors.black,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            'Escolha a duração',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: TextStyles.instance.secondary,
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    items: duracaoItems
                        .map((String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: TextStyles.instance.secondary,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    value: selectedDuracao,
                    onChanged: (value) {
                      setState(() {
                        selectedDuracao = value;
                      });
                    },
                    buttonStyleData: ButtonStyleData(
                      height: 50,
                      width: sizeOF.width * .8,
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: Colors.black26,
                        ),
                        color: Colors.white,
                      ),
                      elevation: 2,
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(Icons.arrow_forward_ios_outlined),
                      iconSize: 14,
                      iconEnabledColor: Colors.black,
                      iconDisabledColor: Colors.grey,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.white,
                      ),
                      offset: const Offset(-20, 0),
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness: WidgetStateProperty.all(6),
                        thumbVisibility: WidgetStateProperty.all(true),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                      padding: EdgeInsets.only(left: 14, right: 14),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Text(
                  'Posição',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: TextStyles.instance.secondary,
                    fontSize: 16,
                  ),
                ),
              ),
              Center(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: Row(
                      children: [
                        const Icon(
                          Icons.list,
                          size: 16,
                          color: Colors.black,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            'Escolha a posição de Medida',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: TextStyles.instance.secondary,
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    items: posicaoItems
                        .map((String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: TextStyles.instance.secondary,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    value: selectedPosicao,
                    onChanged: (value) {
                      setState(() {
                        selectedPosicao = value;
                      });
                    },
                    buttonStyleData: ButtonStyleData(
                      height: 50,
                      width: sizeOF.width * .8,
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: Colors.black26,
                        ),
                        color: Colors.white,
                      ),
                      elevation: 2,
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(Icons.arrow_forward_ios_outlined),
                      iconSize: 14,
                      iconEnabledColor: Colors.black,
                      iconDisabledColor: Colors.grey,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.white,
                      ),
                      offset: const Offset(-20, 0),
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness: WidgetStateProperty.all(6),
                        thumbVisibility: WidgetStateProperty.all(true),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                      padding: EdgeInsets.only(left: 14, right: 14),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: sizeOF.height * 0.05,
                      width: sizeOF.width * 0.37,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.popAndPushNamed(
                              context, RoutesAssets.readingHome);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          textStyle:
                              const TextStyle(fontWeight: FontWeight.w600),
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
                    padding: const EdgeInsets.all(8.0),
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
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          textStyle:
                              const TextStyle(fontWeight: FontWeight.w600),
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
            ]),
          ),
        ),
      ),
    );
  }
}
