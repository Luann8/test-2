import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:hrv4life_flutter/src/constants/app_assets.dart';
import 'package:hrv4life_flutter/src/constants/app_colors.dart';
import 'package:hrv4life_flutter/src/constants/app_text_styles.dart';
import 'package:hrv4life_flutter/src/constants/routes_assets.dart';
import 'package:lottie/lottie.dart';
import 'package:hrv4life_flutter/src/modules/home/dica_do_dia.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _greeting = '';
  Phrase? _dailyTip;

  @override
  void initState() {
    super.initState();
    _updateGreeting();
    _updateDailyTip();
    // Atualizar a saudação a cada minuto
    Timer.periodic(const Duration(minutes: 1), (timer) {
      _updateGreeting();
    });
  }

  void _updateGreeting() {
    DateTime now = DateTime.now();
    int hour = now.hour;
    setState(() {
      _greeting = (hour >= 5 && hour < 12)
          ? 'Bom dia'
          : (hour < 18)
              ? 'Boa tarde'
              : 'Boa noite';
    });
  }

  void _updateDailyTip() {
    setState(() {
      _dailyTip = getDailyTip();
    });
  }

  @override
  Widget build(BuildContext context) {
    final sizeOF = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Container(
            alignment: AlignmentDirectional.centerStart,
            height: sizeOF.height * 0.15,
            width: sizeOF.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment(0.8, 1),
                colors: <Color>[
                  Color(0xFFFF9000),
                  Color(0xffFD821C),
                  Color(0xffF37221),
                ],
                tileMode: TileMode.mirror,
              ),
              boxShadow: [
                BoxShadow(
                  blurStyle: BlurStyle.normal,
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: MediaQuery.of(context).padding.top +
                    10, // Adiciona padding extra no topo
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white24,
                        ),
                        child: const Icon(
                          Icons.person_outline_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$_greeting,',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: TextStyles.instance.secondary,
                            ),
                          ),
                          Text(
                            'Nome do Usuario',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: TextStyles.instance.secondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, RoutesAssets.menuPage);
                    },
                    icon: const Icon(
                      Icons.menu,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: sizeOF.height * 0.03),
          Container(
            //   height: sizeOF.height * .2,
            padding: const EdgeInsets.only(bottom: 10),
            width: sizeOF.width * .9,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  blurStyle: BlurStyle.normal,
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(6, 6),
                ),
              ],
            ),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Avaliação Diária',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: TextStyles.instance.secondary,
                    )),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .8,
                child: const Divider(
                  color: Colors.black12,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 8),
                child: AutoSizeText('Você ainda não fez sua avaliação hoje?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: 14,
                      fontFamily: TextStyles.instance.secondary,
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: sizeOF.width * 0.4,
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
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/home/morning');
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(
                              vertical:
                                  12), // Ajuste o padding vertical conforme necessário
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: Center(
                          // Adicione um widget Center aqui
                          child: Text(
                            "Iniciar avaliação",
                            textAlign: TextAlign.center, // Adicione esta linha
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: TextStyles.instance.secondary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: sizeOF.height * 0.057,
                      width: sizeOF.width * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/home/pacer');
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          textStyle:
                              const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        child: const Text(
                          "Volte a calma",
                          style: TextStyle(
                            color: Colors.black38,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
          SizedBox(height: sizeOF.height * 0.02),
          Container(
            width: sizeOF.width * 0.9,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dica do dia',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: TextStyles.instance.secondary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      AutoSizeText(
                        _dailyTip?.text ??
                            'Não foi possível obter uma dica do dia.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: TextStyles.instance.secondary,
                        ),
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: sizeOF.width * 0.2,
                  height: sizeOF.width *
                      0.2, // Fazendo a altura igual à largura para manter proporção
                  child: Center(
                    child: Lottie.asset(
                      AppAssets.ideiaLottie,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: sizeOF.height * 0.02),
          Container(
            //   height: sizeOF.height * 0.23,
            padding: const EdgeInsets.all(10),
            width: sizeOF.width * .9,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  blurStyle: BlurStyle.normal,
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(6, 6),
                ),
              ],
            ),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Diário de Saúde',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: TextStyles.instance.secondary,
                    )),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .8,
                child: const Divider(
                  color: Colors.black12,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: AutoSizeText(
                    'Anote seu peso, pressão, glicemia e temperatura',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: 14,
                      fontFamily: TextStyles.instance.secondary,
                    )),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: sizeOF.width * 0.7,
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
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        textStyle: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      child: const Text("Preencher Diário"),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
      bottomNavigationBar: ConvexAppBar(
        color: Colors.white,
        backgroundColor: AppColors.primaryPure,
        style: TabStyle.titled,
        items: const [
          TabItem(icon: Icons.home, title: 'Início'),
          // TabItem(icon: Icons.edit_note, title: 'Diario'),
          TabItem(icon: Icons.add, title: 'Medidas'),
          // TabItem(icon: Icons.message, title: 'Chat'),
          TabItem(icon: Icons.calendar_month_rounded, title: 'Histórico'),
        ],
        initialActiveIndex: 0,
        onTap: (int i) {
          switch (i) {
            case 0:
              Navigator.pushReplacementNamed(context, RoutesAssets.homePage);
            case 1:
              Navigator.pushReplacementNamed(context, RoutesAssets.readingHome);
            case 2:
              Navigator.pushReplacementNamed(
                  context, RoutesAssets.historicPage);
          }
        },
      ),
    );
  }
}
