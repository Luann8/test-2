import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hrv4life_core/hrv4life_core.dart';
import 'package:hrv4life_flutter/src/constants/app_assets.dart';
import 'package:hrv4life_flutter/src/constants/app_colors.dart';
import 'package:hrv4life_flutter/src/constants/app_text_styles.dart';
import 'package:hrv4life_flutter/src/constants/routes_assets.dart';
import 'package:hrv4life_flutter/src/modules/register/register_controller.dart';

class RegisterQuestionPage extends StatelessWidget {
  const RegisterQuestionPage({super.key});

  @override
  Widget build(BuildContext context) {
    late RegisterController controller;
    controller = GetIt.instance<RegisterController>();

    final sizeOF = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          // Adicionado para evitar overflow
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: sizeOF.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment
                  .spaceBetween, // Distribui o espaço verticalmente
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: sizeOF.height * 0.07,
                    ),
                    SizedBox(
                      height: 121,
                      width: 121,
                      child: Image.asset(
                        AppAssets.splash,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      height: sizeOF.height * 0.08,
                    ),
                    SizedBox(
                      height: sizeOF.height * 0.10,
                      child: Text(
                        'Que bom ter você na HRV4Life, ${controller.nome}!',
                        style: Hrv4lifeThema.titleStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        textAlign: TextAlign.center,
                        'Agora que você já nos conheceu, queremos saber mais sobre você',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: TextStyles.instance.secondary,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: sizeOF.height *
                          0.05), // Aumenta o espaço na parte inferior
                  child: Center(
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
                        onPressed: () {
                          Navigator.pushNamed(
                              context, RoutesAssets.registerQuestion2);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          textStyle:
                              const TextStyle(fontWeight: FontWeight.w600),
                          padding: const EdgeInsets.symmetric(
                              vertical:
                                  15), // Aumenta o padding vertical do botão
                        ),
                        child: Text(
                          'Vamos Lá!',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontFamily: TextStyles.instance.secondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
