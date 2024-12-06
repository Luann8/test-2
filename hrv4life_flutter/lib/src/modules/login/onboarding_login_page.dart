import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:hrv4life_flutter/src/constants/app_assets.dart';
import 'package:hrv4life_flutter/src/constants/app_colors.dart';
import 'package:hrv4life_flutter/src/constants/app_text_styles.dart';
import 'package:hrv4life_flutter/src/modules/login/login_page.dart';
import 'package:hrv4life_flutter/src/modules/register/register_name_page.dart';

class OnboardingLoginPage extends StatelessWidget {
  final Color kDarkBlueColor = const Color(0xFF053149);
  const OnboardingLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeOF = MediaQuery.sizeOf(context);

    return OnBoardingSlider(
      finishButtonText: 'Cadastro',
      onFinish: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => const RegisterNamePage(),
          ),
        );
      },
      finishButtonStyle: const FinishButtonStyle(
        backgroundColor: AppColors.primaryLight,
      ),
      skipTextButton: const Text(
        'Pular',
        style: TextStyle(
          fontSize: 16,
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: const Text(
        'Login',
        style: TextStyle(
          fontSize: 16,
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailingFunction: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      },
      controllerColor: AppColors.primary,
      totalPage: 3,
      headerBackgroundColor: Colors.white,
      pageBackgroundColor: Colors.white,
      background: [
        Image.asset(
          AppAssets.pressentation1,
          height: MediaQuery.of(context).size.height * .8,
          width: MediaQuery.of(context).size.width,
        ),
        Image.asset(
          AppAssets.pressentation2,
          height: MediaQuery.of(context).size.height * .8,
          width: MediaQuery.of(context).size.width,
        ),
        Image.asset(
          AppAssets.pressentation3,
          height: MediaQuery.of(context).size.height * .8,
          width: MediaQuery.of(context).size.width,
        ),
      ],
      speed: 1.8,
      pageBodies: [
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: sizeOF.height * .55,
              ),
              Text(
                'Sua saúde na\n ponta do dedo',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: TextStyles.instance.primary,
                  color: AppColors.primaryPure,
                  fontSize: 28.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'A qualquer momento,\n em qualquer lugar',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: TextStyles.instance.secondary,
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: sizeOF.height * .55,
              ),
              Text(
                'Conheça o seu\n Corpo',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.primaryPure,
                    fontSize: 28.0,
                    fontWeight: FontWeight.w700,
                    fontFamily: TextStyles.instance.primary),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Veja os resultados e\n avalie como está sua saúde',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    fontFamily: TextStyles.instance.secondary),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: sizeOF.height * .55,
              ),
              Text(
                'Tenha controle da sua saúde',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.primaryPure,
                    fontSize: 28.0,
                    fontWeight: FontWeight.w700,
                    fontFamily: TextStyles.instance.primary),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Tenha dados para ser o protagonista da sua saúde!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    fontFamily: TextStyles.instance.secondary),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
