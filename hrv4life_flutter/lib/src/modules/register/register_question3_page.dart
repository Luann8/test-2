import 'package:flutter/material.dart';
import 'package:hrv4life_flutter/src/constants/app_colors.dart';
import 'package:hrv4life_flutter/src/constants/app_text_styles.dart';
import 'package:hrv4life_flutter/src/constants/routes_assets.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

class RegisterQuestion3Page extends StatefulWidget {
  const RegisterQuestion3Page({super.key});

  @override
  State<RegisterQuestion3Page> createState() => _RegisterQuestion3PageState();
}

class _RegisterQuestion3PageState extends State<RegisterQuestion3Page> {
  bool isChecked = false;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime(1990, 1, 1); // Set default date to 01/01/1990
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
                  value: .3,
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
                'Agora, conte-nos mais sobre você! Esses dados vão ajudar a personalizar as análises de saúde.',
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
                  'Qual é a sua data de nascimento?',
                  style: TextStyle(
                    color: AppColors.primaryPure,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    fontFamily: TextStyles.instance.secondary,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 350,
              child: ScrollDatePicker(
                selectedDate: _selectedDate,
                locale: const Locale('pt', 'BR'),
                options: const DatePickerOptions(
                  isLoop: false,
                ),
                maximumDate: DateTime.now(),
                minimumDate: DateTime(1920, 1, 1),
                onDateTimeChanged: (DateTime value) {
                  setState(() {
                    _selectedDate = value;
                  });
                },
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
                            context, RoutesAssets.registerQuestion2);
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
                            context, RoutesAssets.registerQuestion4);
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
