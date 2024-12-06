import 'package:flutter/material.dart';
import 'package:hrv4life_flutter/src/constants/app_assets.dart';
import 'package:hrv4life_flutter/src/constants/app_colors.dart';
import 'package:hrv4life_flutter/src/constants/app_text_styles.dart';
import 'package:hrv4life_flutter/src/constants/routes_assets.dart';

const List<String> list = <String>[
  'Sentado',
  'Deitado',
];

class ReadingMorningPage extends StatefulWidget {
  const ReadingMorningPage({super.key});

  @override
  State<ReadingMorningPage> createState() => _ReadingMorningPageState();
}

class _ReadingMorningPageState extends State<ReadingMorningPage> {
  String dropdownValue = list.first;
  @override
  Widget build(BuildContext context) {
    final sizeOF = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.only(top: 70),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Instruções',
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontFamily: TextStyles.instance.secondary,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Avaliação diária',
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  fontFamily: TextStyles.instance.secondary,
                ),
              ),
              SizedBox(
                width: sizeOF.width * 0.6,
                height: sizeOF.height * 0.4,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Image.asset(AppAssets.womanInstruction),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Fique parado por 3 minuto.\n Encoste o dedo na câmera sem apertar. \n Não coloque o dedo sobre o flash.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: TextStyles.instance.secondary,
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    'Posição:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontFamily: TextStyles.instance.secondary,
                    ),
                  )),
              Container(
                alignment: Alignment.center,
                width: 295,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Icon(
                        Icons.arrow_drop_down_outlined,
                        color: AppColors.primaryLight,
                      ),
                    ),
                    elevation: 16,
                    style: const TextStyle(color: AppColors.black),
                    underline: Container(
                      height: 2,
                      color: AppColors.primaryLight,
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: TextStyles.instance.secondary,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(
                height: sizeOF.height * 0.05,
              ),
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
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(RoutesAssets.readingDaily);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          textStyle:
                              const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        label: const Text('Iniciar'),
                        icon: const Icon(
                          color: Colors.white,
                          Icons.arrow_forward,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
