import 'package:flutter/material.dart';
import 'package:hrv4life_flutter/src/constants/app_assets.dart';
import 'package:hrv4life_flutter/src/constants/app_colors.dart';
import 'package:hrv4life_flutter/src/constants/app_text_styles.dart';
import 'package:hrv4life_flutter/src/constants/routes_assets.dart';

enum Gender { Male, Female, Other }

class CustomGenderPicker extends StatefulWidget {
  final Function(Gender) onChanged;

  const CustomGenderPicker({super.key, required this.onChanged});

  @override
  _CustomGenderPickerState createState() => _CustomGenderPickerState();
}

class _CustomGenderPickerState extends State<CustomGenderPicker> {
  Gender? _selectedGender;

  Widget _buildGenderOption(Gender gender, String text, String assetPath) {
    bool isSelected = _selectedGender == gender;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedGender = gender;
        });
        widget.onChanged(gender);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: isSelected ? 110 : 100,
        height: isSelected ? 110 : 100,
        decoration: BoxDecoration(
          color: AppColors.primaryPure,
          border: Border.all(
            color: AppColors.primaryPure,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primaryPure.withOpacity(0.3),
                    blurRadius: 8,
                    spreadRadius: 2,
                  )
                ]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              assetPath,
              width: isSelected ? 60 : 50,
              height: isSelected ? 60 : 50,
              color: Colors.white,
            ),
            const SizedBox(height: 8),
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontFamily: TextStyles.instance.secondary,
                fontSize: isSelected ? 14 : 12,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildGenderOption(Gender.Male, 'Masculino', AppAssets.maleGender),
        _buildGenderOption(Gender.Female, 'Feminino', AppAssets.femaleGender),
        _buildGenderOption(Gender.Other, 'Não Declarar', AppAssets.notGender),
      ],
    );
  }
}

class RegisterQuestion4Page extends StatefulWidget {
  const RegisterQuestion4Page({super.key});

  @override
  State<RegisterQuestion4Page> createState() => _RegisterQuestion4PageState();
}

class _RegisterQuestion4PageState extends State<RegisterQuestion4Page> {
  Gender? selectedGender;

  void _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Informação',
            style: TextStyle(
              fontFamily: TextStyles.instance.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Os valores esperados dos índices de saúde dependem de sexo e idade, '
            'pois podem variar de acordo com os hormônios. Por isso é importante que saibamos seu sexo ao nascer. '
            'Sua orientação sexual não interfere nestes resultados.',
            style: TextStyle(fontFamily: TextStyles.instance.secondary),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Fechar',
                style: TextStyle(
                  color: AppColors.primaryPure,
                  fontFamily: TextStyles.instance.secondary,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

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
                  value: .45,
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
                'Esses dados vão ajudar a personalizar as análises da sua de saúde',
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
                  'Qual seu sexo ao nascer?',
                  style: TextStyle(
                    color: AppColors.primaryPure,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    fontFamily: TextStyles.instance.secondary,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  CustomGenderPicker(
                    onChanged: (Gender gender) {
                      setState(() {
                        selectedGender = gender;
                      });
                      print(gender);
                    },
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      onPressed: () => _showInfoDialog(context),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.white,
                        shadowColor: Colors.transparent,
                        padding:
                            const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      label: Text(
                        'Saiba mais',
                        style: TextStyle(
                          color: AppColors.black,
                          fontFamily: TextStyles.instance.secondary,
                          fontSize: 12,
                        ),
                      ),
                      icon: const Icon(
                        Icons.info_outline,
                        color: AppColors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(bottom: sizeOF.height * 0.05, right: 20),
                  child: SizedBox(
                    height: sizeOF.height * 0.05,
                    width: sizeOF.width * 0.37,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.popAndPushNamed(
                            context, RoutesAssets.registerQuestion3);
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
                  padding: EdgeInsets.only(bottom: sizeOF.height * 0.05),
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
                        Navigator.popAndPushNamed(
                            context, RoutesAssets.registerQuestion5);
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
