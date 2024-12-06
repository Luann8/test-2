import 'package:flutter/material.dart';
import 'package:hrv4life_flutter/src/constants/app_colors.dart';
import 'package:hrv4life_flutter/src/constants/app_text_styles.dart';
import 'package:hrv4life_flutter/src/constants/routes_assets.dart';

class RegisterQuestion2Page extends StatefulWidget {
  const RegisterQuestion2Page({super.key});

  @override
  State<RegisterQuestion2Page> createState() => _RegisterQuestion2PageState();
}

class _RegisterQuestion2PageState extends State<RegisterQuestion2Page> {
  int? selectedOption;

  @override
  Widget build(BuildContext context) {
    final sizeOF = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: sizeOF.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                      child: SizedBox(
                        height: 2,
                        child: LinearProgressIndicator(
                          value: .15,
                          minHeight: 10,
                          color: AppColors.secondaryBar,
                          backgroundColor: Colors.black12,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 10),
                      child: SizedBox(
                        width: sizeOF.width * .8,
                        child: Text(
                          'Sua Saúde',
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
                        'Para personalizarmos a sua experiência, precisamos te conhecer melhor',
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 10),
                        child: Text(
                          textAlign: TextAlign.center,
                          'Como você percebe a sua saúde?',
                          style: TextStyle(
                            color: AppColors.primaryPure,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontFamily: TextStyles.instance.secondary,
                          ),
                        ),
                      ),
                    ),
                    _buildOptionItem('Tenho doença crônica', 0),
                    _buildOptionItem('Ruim', 1),
                    _buildOptionItem('Mais ou menos', 2),
                    _buildOptionItem('Boa, mas pode melhorar', 3),
                    _buildOptionItem('Estou em perfeita saúde', 4),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: sizeOF.height * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildNavigationButton(
                        'Voltar',
                        Icons.arrow_circle_left,
                        () => Navigator.popAndPushNamed(
                            context, RoutesAssets.registerQuestion),
                        isBackButton: true,
                      ),
                      _buildNavigationButton(
                        'Avançar',
                        Icons.arrow_circle_right,
                        () => Navigator.popAndPushNamed(
                            context, RoutesAssets.registerQuestion3),
                        isBackButton: false,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionItem(String text, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: MediaQuery.of(context).size.width * .8,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.backgroundLight,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: TextStyles.instance.secondary,
                ),
              ),
            ),
            Radio<int>(
              value: value,
              groupValue: selectedOption,
              onChanged: (int? newValue) {
                setState(() {
                  selectedOption = newValue;
                });
              },
              activeColor: AppColors.secondaryBar,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButton(
      String label, IconData icon, VoidCallback onPressed,
      {required bool isBackButton}) {
    final sizeOF = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: sizeOF.height * 0.05,
        width: sizeOF.width * 0.37,
        decoration: isBackButton
            ? null
            : BoxDecoration(
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
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            foregroundColor: isBackButton ? Colors.black45 : Colors.white,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            textStyle: const TextStyle(fontWeight: FontWeight.w600),
          ),
          icon: Icon(icon, color: isBackButton ? Colors.white : Colors.white),
          label: Text(label),
        ),
      ),
    );
  }
}
